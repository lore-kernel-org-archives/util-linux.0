Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33197 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750903AbdFSVpO (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 17:45:14 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.20/8.16.0.20) with SMTP id v5JLffYN021930
        for <util-linux@vger.kernel.org>; Mon, 19 Jun 2017 14:45:13 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2b6pkp0171-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Mon, 19 Jun 2017 14:45:13 -0700
Received: from facebook.com (2401:db00:2120:20db:face:0:33:0)   by
 mx-out.facebook.com (2401:db00:2050:5102:face:0000:0037:0000) with ESMTP       id
 92544b2a553811e7bf0275369c678944-ff93c8f0 for <util-linux@vger.kernel.org>;
        Mon, 19 Jun 2017 14:45:12 -0700
From: Vinnie Magro <vmagro@fb.com>
To: <util-linux@vger.kernel.org>
CC: Vinnie Magro <vmagro@fb.com>
Subject: [PATCH] dmesg: fragment concatenation
Date: Mon, 19 Jun 2017 14:45:02 -0700
Message-ID: <20170619214502.968882-1-vmagro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When extended console is enabled, the kernel doesn't internally
concatenate message fragments, this change adds log fragment
concatenation to dmesg: instead of being printed as separate messages,
fragments are combined onto one line and printed with the timestamp of
the first line.

This doesn't work in all cases - such as if another message is logged in
between two fragment lines, but in this case the behavior matches the
previous output format (printed on the separate lines).

Signed-off-by: Vinnie Magro <vmagro@fb.com>
---
 sys-utils/dmesg.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 7 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 3263c3a..a58f787 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -20,6 +20,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <poll.h>
 
 #include "c.h"
 #include "colors.h"
@@ -178,6 +179,8 @@ struct dmesg_control {
 	int		kmsg;		/* /dev/kmsg file descriptor */
 	ssize_t		kmsg_first_read;/* initial read() return code */
 	char		kmsg_buf[BUFSIZ];/* buffer to read kmsg data */
+	char		kmsg_saved[BUFSIZ];/* buffer to save line after fragment */
+	ssize_t		kmsg_read_buf;  /* if nonzero, read from kmsg_saved */
 
 	/*
 	 * For the --file option we mmap whole file. The unnecessary (already
@@ -206,6 +209,7 @@ struct dmesg_record {
 	int		level;
 	int		facility;
 	struct timeval  tv;
+	char		flags;
 
 	const char	*next;		/* buffer with next unparsed record */
 	size_t		next_size;	/* size of the next buffer */
@@ -222,6 +226,13 @@ struct dmesg_record {
 
 static int read_kmsg(struct dmesg_control *ctl);
 
+
+static int parse_kmsg_record(struct dmesg_control *ctl,
+			     struct dmesg_record *rec,
+			     char *buf,
+			     size_t sz);
+
+
 static int set_level_color(int log_level, const char *mesg, size_t mesgsz)
 {
 	int id = -1;
@@ -1013,15 +1024,102 @@ static void print_buffer(struct dmesg_control *ctl,
 		print_record(ctl, &rec);
 }
 
+/*
+ * Read one record from kmsg, automatically concatenating message fragments
+ */
 static ssize_t read_kmsg_one(struct dmesg_control *ctl)
 {
 	ssize_t size;
 
-	/* kmsg returns EPIPE if record was modified while reading */
+	if (ctl->kmsg_read_buf != 0) {
+		size = ctl->kmsg_read_buf;
+		memcpy(ctl->kmsg_buf, ctl->kmsg_saved, size);
+		ctl->kmsg_read_buf = 0;
+		return size;
+	}
+
+	struct dmesg_record rec;
+	char fragment_buf[BUFSIZ];
+	memset(fragment_buf, 0, sizeof(fragment_buf));
+	ssize_t fragment_offset = 0;
+
+	/*
+	 * kmsg returns EPIPE if record was modified while reading.
+	 * Read records until there is one with a flag different from 'c'/'+',
+	 * which indicates that a fragment (if it exists) is complete.
+	 */
 	do {
-		size = read(ctl->kmsg, ctl->kmsg_buf,
-			    sizeof(ctl->kmsg_buf) - 1);
-	} while (size < 0 && errno == EPIPE);
+		/*
+		 * If there is a fragment in progress, and we're in follow mode,
+		 * read with a timeout so that if no line is read in 100ms, we can
+		 * assume that the fragment is the last line in /dev/kmsg and it
+		 * is completed.
+		 */
+		if (ctl->follow && fragment_offset) {
+			struct pollfd pfd = {.fd = ctl->kmsg, .events = POLLIN};
+			poll(&pfd, 1, 100);
+			/* If 100ms has passed and kmsg has no data to read() */
+			if (!(pfd.revents & POLLIN)) {
+				memcpy(ctl->kmsg_buf, fragment_buf, fragment_offset);
+				return fragment_offset + 1;
+			}
+		}
+		size = read(ctl->kmsg, ctl->kmsg_buf, sizeof(ctl->kmsg_buf) - 1);
+
+		/*
+		 * If read() would have blocked and we have a fragment in
+		 * progress, assume that it's completed (ie. it was the last line
+		 * in the ring buffer) otherwise it won't be displayed until
+		 * another non-fragment message is logged.
+		 */
+		if (errno == EAGAIN && fragment_offset) {
+			memcpy(ctl->kmsg_buf, fragment_buf, fragment_offset);
+			return fragment_offset + 1;
+		}
+
+		if(parse_kmsg_record(ctl, &rec, ctl->kmsg_buf,
+				     (size_t) size) == 0) {
+			/*
+			 * 'c' can indicate a start of a fragment or a
+			 * continuation, '+' is used in older kernels to
+			 * indicate a continuation.
+			 */
+			if (rec.flags == 'c' || rec.flags == '+') {
+				if (fragment_offset == 0) {
+					memcpy(fragment_buf, ctl->kmsg_buf, size);
+					fragment_offset = size - 1;
+				} else {
+					/*
+					 * In case of a buffer overflow, just
+					 * truncate the fragment - no one should
+					 * be logging this much anyway
+					 */
+					ssize_t truncate_size =
+						MIN(fragment_offset + rec.mesg_size,
+						    sizeof(fragment_buf));
+					memcpy(fragment_buf + fragment_offset,
+					       rec.mesg, truncate_size);
+					fragment_offset += rec.mesg_size;
+				}
+			}
+			else if (rec.flags == '-') {
+				/*
+				 * If there was a fragment being built, move it
+				 * into kmsg_buf, but first save a copy of the
+				 * current message so that it doesn't get lost.
+				 */
+				if (fragment_offset) {
+					memcpy(ctl->kmsg_saved,
+					       ctl->kmsg_buf, size);
+					ctl->kmsg_read_buf = size;
+					memcpy(ctl->kmsg_buf,
+					       fragment_buf, fragment_offset);
+					return fragment_offset + 1;
+				}
+			}
+		}
+	} while ((size < 0 && errno == EPIPE) ||
+		 (rec.flags == 'c' || rec.flags == '+'));
 
 	return size;
 }
@@ -1115,11 +1213,17 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 	if (LAST_KMSG_FIELD(p))
 		goto mesg;
 
-	/* D) optional fields (ignore) */
+	/* D) flags */
+	rec->flags = *p; // flag is one char
+	p = p + 1;
+	if (LAST_KMSG_FIELD(p))
+		goto mesg;
+
+	/* E) optional fields (ignore) */
 	p = skip_item(p, end, ";");
 
 mesg:
-	/* E) message text */
+	/* F) message text */
 	rec->mesg = p;
 	p = skip_item(p, end, "\n");
 
@@ -1135,7 +1239,7 @@ mesg:
 	 */
 	unhexmangle_to_buffer(rec->mesg, (char *) rec->mesg, rec->mesg_size + 1);
 
-	/* F) message tags (ignore) */
+	/* G) message tags (ignore) */
 
 	return 0;
 }
-- 
2.9.3

