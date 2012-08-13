Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24393 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab2HMLze (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Aug 2012 07:55:34 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7DBtXVN005244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 13 Aug 2012 07:55:33 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH] dmesg: fix kmsg read if read returns EPIPE
Date: Mon, 13 Aug 2012 13:55:30 +0200
Message-Id: <1344858930-21075-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The /dev/kmsg can return EPIPE if current record has beed modified
while reading.

For init_kmsg, it cause switch to DMESG_METHOD_SYSLOG
(which is not expected) and later it can truncate output.

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 sys-utils/dmesg.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index e92904f..0ee03ee 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -851,6 +851,19 @@ static void print_buffer(struct dmesg_control *ctl,
 		print_record(ctl, &rec);
 }
 
+static ssize_t read_kmsg_one(struct dmesg_control *ctl)
+{
+	ssize_t size;
+
+	/* kmsg returns EPIPE if record was modified while reading */
+	do {
+		size = read(ctl->kmsg, ctl->kmsg_buf,
+			    sizeof(ctl->kmsg_buf) - 1);
+	} while (size < 0 && errno == EPIPE);
+
+	return size;
+}
+
 static int init_kmsg(struct dmesg_control *ctl)
 {
 	int mode = O_RDONLY;
@@ -877,8 +890,7 @@ static int init_kmsg(struct dmesg_control *ctl)
 	 * Let's try to read the first record. The record is later processed in
 	 * read_kmsg().
 	 */
-	ctl->kmsg_first_read = read(ctl->kmsg, ctl->kmsg_buf,
-				  sizeof(ctl->kmsg_buf) - 1);
+	ctl->kmsg_first_read = read_kmsg_one(ctl);
 	if (ctl->kmsg_first_read < 0) {
 		close(ctl->kmsg);
 		ctl->kmsg = -1;
@@ -996,7 +1008,7 @@ static int read_kmsg(struct dmesg_control *ctl)
 				      ctl->kmsg_buf, (size_t) sz) == 0)
 			print_record(ctl, &rec);
 
-		sz = read(ctl->kmsg, ctl->kmsg_buf, sizeof(ctl->kmsg_buf) - 1);
+		sz = read_kmsg_one(ctl);
 	}
 
 	return 0;
-- 
1.7.10.4

