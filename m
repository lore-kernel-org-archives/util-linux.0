Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48404 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab2GYTQN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:13 -0400
Received: by wibhm11 with SMTP id hm11so5657356wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/5] dmesg: inform user when klogctl() or read_buffer() fails
Date: Wed, 25 Jul 2012 21:15:44 +0200
Message-Id: <1343243745-1172-27-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix to small regression which made 'dmesg --clear' not to error
when running without root privileges.  Same happen with '-D' and
few other options as well.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 1819c7c..15b9fae 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -985,7 +985,7 @@ static int read_kmsg(struct dmesg_control *ctl)
 int main(int argc, char *argv[])
 {
 	char *buf = NULL;
-	ssize_t  n;
+	ssize_t  n, r;
 	int  c;
 	int  console_level = 0;
 	static struct dmesg_control ctl = {
@@ -1138,6 +1138,7 @@ int main(int argc, char *argv[])
 	argc -= optind;
 	argv += optind;
 	n = 0;
+	r = 0;
 
 	if (argc > 1)
 		usage(stderr);
@@ -1158,9 +1159,9 @@ int main(int argc, char *argv[])
 		if (ctl.method == DMESG_METHOD_KMSG && init_kmsg(&ctl) != 0)
 			ctl.method = DMESG_METHOD_SYSLOG;
 
-		n = read_buffer(&ctl, &buf);
-		if (n > 0)
-			print_buffer(&ctl, buf, n);
+		r = read_buffer(&ctl, &buf);
+		if (r > 0)
+			print_buffer(&ctl, buf, r);
 		if (!ctl.mmap_buff)
 			free(buf);
 		break;
@@ -1180,8 +1181,10 @@ int main(int argc, char *argv[])
 	if (ctl.kmsg >= 0)
 		close(ctl.kmsg);
 
-	if (n < 0 && ctl.method == DMESG_METHOD_SYSLOG)
+	if (n < 0)
 		err(EXIT_FAILURE, _("klogctl failed"));
+	if (r < 0)
+		err(EXIT_FAILURE, _("read_buffer failed"));
 
 	return EXIT_SUCCESS;
 }
-- 
1.7.11.3

