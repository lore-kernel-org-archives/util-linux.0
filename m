Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:52213 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:13 -0400
Received: by mail-we0-f177.google.com with SMTP id x48so4309319wes.8
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/17] setterm: remove devfs and /dev/vcsa0 support
Date: Sun, 18 May 2014 15:05:33 +0100
Message-Id: <1400421941-14244-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The devfs files /dev/vcc/a* does not need to be supported, and vcsa0 has
not existed in years if ever.

Reference: http://lwn.net/Articles/65197/
Reference: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devices.txt?id=14186fea0cb06bc43181ce239efe0df6f1af260a#n260
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/setterm |  2 +-
 term-utils/setterm.c    | 26 +++++++-------------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/bash-completion/setterm b/bash-completion/setterm
index a7ef6eb..f47debf 100644
--- a/bash-completion/setterm
+++ b/bash-completion/setterm
@@ -40,7 +40,7 @@ _setterm_module()
 			;;
 		'-dump'|'-append')
 			local NUM_CONS
-			NUM_CONS=(/sys/class/tty/*)
+			NUM_CONS=(/dev/vcsa?*)
 			COMPREPLY=( $(compgen -W "{1..${#NUM_CONS[*]}}" -- $cur) )
 			return 0
 			;;
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index d889db4..3a02347 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -724,31 +724,18 @@ static void show_tabs(void)
 
 static void __attribute__((__noreturn__)) read_error(struct setterm_control *ctl)
 {
-	if (ctl->opt_sn_num != 0)
-		errx(EXIT_DUMPFILE, _("Couldn't read %s"), ctl->in_device);
-	else
-		errx(EXIT_DUMPFILE, _("Couldn't read neither /dev/vcsa0 nor /dev/vcsa"));
+	err(EXIT_DUMPFILE, _("Couldn't read %s"), ctl->in_device);
 }
 
 static int open_snapshot_device(struct setterm_control *ctl)
 {
-	char infile[MAXPATHLEN];
 	int fd;
 
-	sprintf(infile, "/dev/vcsa%d", ctl->opt_sn_num);
-	fd = open(infile, O_RDONLY);
-	if (fd < 0 && ctl->opt_sn_num == 0) {
-		/* vcsa0 is often called vcsa */
-		sprintf(infile, "/dev/vcsa");
-		fd = open(infile, O_RDONLY);
-	}
-	if (fd < 0) {
-		/* try devfs name - for zero ctl->opt_sn_num just /dev/vcc/a */
-		/* some gcc's warn for %.u - add 0 */
-		sprintf(infile, "/dev/vcc/a%.0u", ctl->opt_sn_num);
-		fd = open(infile, O_RDONLY);
-	}
-	ctl->in_device = infile;
+	if (ctl->opt_sn_num)
+		xasprintf(&ctl->in_device, "/dev/vcsa%d", ctl->opt_sn_num);
+	else
+		xasprintf(&ctl->in_device, "/dev/vcsa");
+	fd = open(ctl->in_device, O_RDONLY);
 	if (fd < 0)
 		read_error(ctl);
 	return fd;
@@ -803,6 +790,7 @@ static void screendump(struct setterm_control *ctl)
 	close(fd);
 	free(inbuf);
 	free(outbuf);
+	free(ctl->in_device);
 	if (close_stream(out) != 0)
 		errx(EXIT_FAILURE, _("write error"));
 	return;
-- 
1.9.2

