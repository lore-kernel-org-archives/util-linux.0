Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13677 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214Ab1EDMnq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 May 2011 08:43:46 -0400
Date: Wed, 4 May 2011 14:43:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Austen Dicken <cvpcsm@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] dmesg: adds the ability to "follow" the klog ring
	buffer
Message-ID: <20110504122449.GA27184@nb.net.home>
References: <BANLkTin=y5oaEU0913dOnjWhosiyXe3Zwg@mail.gmail.com> <20110503125322.GK29492@nb.net.home> <BANLkTikGoXaYdwvY3fZPGVmvBkGzT23xtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTikGoXaYdwvY3fZPGVmvBkGzT23xtw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 03, 2011 at 09:14:41AM -0500, Austen Dicken wrote:
> > Then you can use klogctl(2, ...). It waits until the kernel log buffer
> > is non-empty, so the last_line and usleep() will be unnecessary, and
> > the implementation will be pretty simple.
> 
> Agreed.  I have decided to change the patch to function this way,
> which simplifies things
> immensely.

Unfortunately, it seems that SYSLOG_ACTION_READ (aka klogctl(2, ...))
is not ideal solution too. Sorry.

The output is incomplete if another process(e.g. syslog daemon) is
reading the buffer. The buffer (and index into the buffer) is shared
for all processes, so it's possible to read the information only once.
For more details see kernel/printk.c (log_start index) in kernel
sources.

Anyway for debugging or on some non-standard boxes the '-f' option
could be still usable. I'd like to add --level= and --facility=
options, so dmesg(1) should be definitely better than the "cat
/proc/kmsg" command.

I did some changes to the patch to minimize overhead, see below. Maybe
it would be better to use open(/proc/kmsg) + read() instead of
klogctl(2, ...) for the -f option to minimize overhead in glibc.

Comments?

    Karel


>From 8e2ae5130c8f03e8ab6e28f194e409f8c322daf8 Mon Sep 17 00:00:00 2001
From: Austen Dicken <cvpcsm@gmail.com>
Date: Tue, 3 May 2011 09:14:41 -0500
Subject: [PATCH] dmesg: adds the ability to "follow" (-f) the klog ring buffer

Co-Author: Karel Zak <kzak@redhat.com>
Signed-off-by: Austen Dicken <cvpcsm@gmail.com>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/dmesg.1 |    5 +++
 sys-utils/dmesg.c |   88 ++++++++++++++++++++++++++++++-----------------------
 2 files changed, 55 insertions(+), 38 deletions(-)

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index d7af1da..9b4471d 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -6,6 +6,7 @@ dmesg \- print or control the kernel ring buffer
 .SH SYNOPSIS
 .B dmesg
 .RB [ \-c ]
+.RB [ \-f ]
 .RB [ \-r ]
 .RB [ \-n
 .IR level ]
@@ -28,6 +29,10 @@ file to whoever can debug their problem.
 .B \-c
 Clear the ring buffer contents after printing.
 .TP
+.B \-f
+Output ring buffer contents as they are added. The output could be incomplete
+if another process (e.g. syslog daemon) is reading the kernel log buffer.
+.TP
 .B \-r
 Print the raw message buffer, i.e., don't strip the log level prefixes.
 .TP
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index c3e5659..2f6b30e 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -40,38 +40,41 @@
 #include "nls.h"
 #include "strutils.h"
 #include "xalloc.h"
+#include "writeall.h"
 
 static void __attribute__ ((noreturn)) usage(void)
 {
 	fprintf(stderr,
-		_("Usage: %s [-c] [-n level] [-r] [-s bufsize]\n"),
+		_("Usage: %s [-c] [-f] [-n level] [-r] [-s bufsize]\n"),
 		program_invocation_short_name);
 	exit(EXIT_FAILURE);
-
 }
 
 int main(int argc, char *argv[])
 {
 	char *buf = NULL;
-	int  sz;
+	int  sz = 0;
 	int  bufsize = 0;
-	int  i;
 	int  n;
 	int  c;
 	int  level = 0;
-	int  lastc;
 	int  cmd = 3;		/* Read all messages in the ring buffer */
 	int  raw = 0;
+	int  follow = 0;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	while ((c = getopt(argc, argv, "crn:s:")) != -1) {
+	while ((c = getopt(argc, argv, "cfrn:s:")) != -1) {
 		switch (c) {
 		case 'c':
 			cmd = 4;	/* Read and clear all messages */
 			break;
+		case 'f':
+			cmd = 2;
+			follow = 1;
+			break;
 		case 'n':
 			cmd = 8;	/* Set level of messages */
 			level = strtol_or_err(optarg, _("failed to parse level"));
@@ -105,46 +108,55 @@ int main(int argc, char *argv[])
 
 	if (!bufsize) {
 		n = klogctl(10, NULL, 0);	/* read ringbuffer size */
-		if (n > 0)
+		if (n > 0) {
 			bufsize = n;
+			sz = bufsize + 8;
+			buf = xmalloc(sz * sizeof(char));
+		}
 	}
 
-	if (bufsize) {
-		sz = bufsize + 8;
-		buf = xmalloc(sz * sizeof(char));
-		n = klogctl(cmd, buf, sz);
-	} else {
-		sz = 16392;
-		while (1) {
-			buf = xmalloc(sz * sizeof(char));
-			n = klogctl(3, buf, sz);	/* read only */
-			if (n != sz || sz > (1 << 28))
-				break;
+	do {
+		if (bufsize && sz)
+			n = klogctl(cmd, buf, sz);
+		else {
 			free(buf);
-			sz *= 4;
+			sz = 16392;
+			while (1) {
+				buf = xmalloc(sz * sizeof(char));
+				n = klogctl(3, buf, sz);	/* read only */
+				if (n != sz || sz > (1 << 28))
+					break;
+				free(buf);
+				sz *= 4;
+			}
+			if (n > 0 && cmd == 4)
+				n = klogctl(cmd, buf, sz);	/* read and clear */
 		}
 
-		if (n > 0 && cmd == 4)
-			n = klogctl(cmd, buf, sz);	/* read and clear */
-	}
-
-	if (n < 0)
-		err(EXIT_FAILURE, _("klogctl failed"));
-
-	lastc = '\n';
-	for (i = 0; i < n; i++) {
-		if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
-			i++;
-			while (isdigit(buf[i]))
-				i++;
-			if (buf[i] == '>')
-				i++;
+		if (n < 0)
+			err(EXIT_FAILURE, _("klogctl failed"));
+		if (raw)
+			write_all(STDIN_FILENO, buf, n);
+		else {
+			int i;
+
+			for (i = 0; i < n; i++) {
+				if ((i == 0 || buf[i - 1] == '\n') &&
+				    buf[i] == '<') {
+					i++;
+					while (isdigit(buf[i]))
+						i++;
+					if (buf[i] == '>')
+						i++;
+				}
+				putchar(buf[i]);
+			}
 		}
-		lastc = buf[i];
-		putchar(lastc);
-	}
-	if (lastc != '\n')
+	} while (follow);
+
+	if (sz && n > 0 && buf && buf[n - 1] != '\n')
 		putchar('\n');
+
 	free(buf);
 
 	return EXIT_SUCCESS;
-- 
1.7.3.4

