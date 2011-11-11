Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58483 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab1KKKMo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Nov 2011 05:12:44 -0500
Received: by wyh15 with SMTP id 15so3671797wyh.19
        for <util-linux@vger.kernel.org>; Fri, 11 Nov 2011 02:12:43 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 2/5] fdisk: rename bselect, xselect functions
Date: Fri, 11 Nov 2011 11:12:08 +0100
Message-Id: <1321006331-7633-2-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
References: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c         |    9 +++++----
 fdisk/fdisk.h         |    2 +-
 fdisk/fdiskbsdlabel.c |    3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 135d118..7d1bd19 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2735,7 +2735,8 @@ move_begin(int i) {
 }
 
 static void
-xselect(void) {
+expert_command_prompt(void)
+{
 	char c;
 
 	while(1) {
@@ -3089,7 +3090,7 @@ main(int argc, char **argv) {
 		printf(_("Detected an OSF/1 disklabel on %s, entering "
 			 "disklabel mode.\n"),
 		       disk_device);
-		bselect();
+		bsd_command_prompt();
 		/* If we return we may want to make an empty DOS label? */
 		disklabel = DOS_LABEL;
 	}
@@ -3120,7 +3121,7 @@ main(int argc, char **argv) {
 				else
 					sgi_set_bootfile(line_ptr);
 			} else
-				bselect();
+				bsd_command_prompt();
 			break;
 		case 'c':
 			if (disklabel == DOS_LABEL)
@@ -3192,7 +3193,7 @@ main(int argc, char **argv) {
 					_("\n\tSorry, no experts menu for SGI "
 					"partition tables available.\n\n"));
 			} else
-				xselect();
+				expert_command_prompt();
 			break;
 		default:
 			unknown_command(c);
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index e289043..0bc1289 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -107,7 +107,7 @@ enum labeltype {
 extern enum labeltype disklabel;
 
 /* prototypes for fdiskbsdlabel.c */
-extern void bselect(void);
+extern void bsd_command_prompt(void);
 extern int check_osf_label(void);
 extern int btrydev(char * dev);
 extern void xbsd_print_disklabel(int);
diff --git a/fdisk/fdiskbsdlabel.c b/fdisk/fdiskbsdlabel.c
index aa27bad..68d481c 100644
--- a/fdisk/fdiskbsdlabel.c
+++ b/fdisk/fdiskbsdlabel.c
@@ -160,7 +160,8 @@ is_bsd_partition_type(int type) {
 #endif
 
 void
-bselect (void) {
+bsd_command_prompt (void)
+{
 #if !defined (__alpha__)
   int t, ss;
   struct partition *p;
-- 
1.7.3.4

