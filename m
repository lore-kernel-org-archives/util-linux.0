Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64935 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1KKKMn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Nov 2011 05:12:43 -0500
Received: by wwe5 with SMTP id 5so1085409wwe.1
        for <util-linux@vger.kernel.org>; Fri, 11 Nov 2011 02:12:42 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 1/5] fdisk: print the welcome message when OSF/1 disklabel is detected
Date: Fri, 11 Nov 2011 11:12:07 +0100
Message-Id: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 249de71..135d118 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -3079,7 +3079,12 @@ main(int argc, char **argv) {
 	gpt_warning(disk_device);
 	get_boot(fdisk);
 
+	fprintf(stderr, _("Welcome to fdisk (%s).\n\n"
+		"Changes will remain in memory only, until you decide to write them.\n"
+		"Be careful before using the write command.\n"), PACKAGE_STRING);
+
 	if (disklabel == OSF_LABEL) {
+		putchar('\n');
 		/* OSF label, and no DOS label */
 		printf(_("Detected an OSF/1 disklabel on %s, entering "
 			 "disklabel mode.\n"),
@@ -3089,10 +3094,6 @@ main(int argc, char **argv) {
 		disklabel = DOS_LABEL;
 	}
 
-	fprintf(stderr, _("Welcome to fdisk (%s).\n\n"
-		"Changes will remain in memory only, until you decide to write them.\n"
-		"Be careful before using the write command.\n"), PACKAGE_STRING);
-
 	while (1) {
 		putchar('\n');
 		c = tolower(read_char(_("Command (m for help): ")));
-- 
1.7.3.4

