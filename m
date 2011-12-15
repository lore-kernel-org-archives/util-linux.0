Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47344 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759166Ab1LOTC6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:02:58 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431824eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:02:57 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 03/13] fdisk: move code for renaming SGI bootfile to SGI module
Date: Thu, 15 Dec 2011 20:02:39 +0100
Message-Id: <1323975769-21929-3-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This moves the code for renaming SGI bootfile from command_prompt() to
sgi_set_bootfilename() function.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c         |   12 +++---------
 fdisk/fdisksgilabel.c |   21 +++++++++++----------
 fdisk/fdisksgilabel.h |    3 +--
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index a23f45e..1a4c823 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2906,15 +2906,9 @@ static void command_prompt(void)
 				unknown_command(c);
 			break;
 		case 'b':
-			if (disklabel == SGI_LABEL) {
-				printf(_("\nThe current boot file is: %s\n"),
-				       sgi_get_bootfile());
-				if (read_chars(_("Please enter the name of the "
-					       "new boot file: ")) == '\n')
-					printf(_("Boot file unchanged\n"));
-				else
-					sgi_set_bootfile(line_ptr);
-			} else if (disklabel == DOS_LABEL) {
+			if (disklabel == SGI_LABEL)
+				sgi_set_bootfile();
+			else if (disklabel == DOS_LABEL) {
 				disklabel = OSF_LABEL;
 				bsd_command_prompt();
 				disklabel = DOS_LABEL;
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 002688a..b432b13 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -316,20 +316,21 @@ sgi_check_bootfile(const char* aFile) {
 	return 0;	/* filename did not change */
 }
 
-const char *
-sgi_get_bootfile(void) {
-	return (char *) sgilabel->boot_file;
-}
-
 void
-sgi_set_bootfile(const char* aFile) {
+sgi_set_bootfile(void)
+{
+	printf(_("\nThe current boot file is: %s\n"), sgilabel->boot_file);
+	if (read_chars(_("Please enter the name of the new boot file: ")) == '\n') {
+		printf(_("Boot file unchanged\n"));
+		return;
+	}
 
-	if (sgi_check_bootfile(aFile)) {
+	if (sgi_check_bootfile(line_ptr)) {
 		size_t i = 0;
 		while (i < 16) {
-			if ((aFile[i] != '\n')	/* in principle caught again by next line */
-			    &&  (strlen(aFile) > i))
-				sgilabel->boot_file[i] = aFile[i];
+			if ((line_ptr[i] != '\n')	/* in principle caught again by next line */
+			    &&  (strlen(line_ptr) > i))
+				sgilabel->boot_file[i] = line_ptr[i];
 			else
 				sgilabel->boot_file[i] = 0;
 			i++;
diff --git a/fdisk/fdisksgilabel.h b/fdisk/fdisksgilabel.h
index 1c47bb4..255fe9c 100644
--- a/fdisk/fdisksgilabel.h
+++ b/fdisk/fdisksgilabel.h
@@ -133,7 +133,6 @@ extern void	sgi_set_bootpartition( int i );
 extern void	sgi_set_swappartition( int i );
 extern int	sgi_get_bootpartition( void );
 extern int	sgi_get_swappartition( void );
-extern void	sgi_set_bootfile( const char* aFile );
-extern const char *sgi_get_bootfile( void );
+extern void	sgi_set_bootfile(void);
 
 #endif /* FDISK_SGI_LABEL_H */
-- 
1.7.7

