Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:35526 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3DMT4G (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:06 -0400
Received: by mail-we0-f173.google.com with SMTP id t57so2737982wey.4
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 21/33] sfdisk: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:49 +0100
Message-Id: <1365882901-11429-22-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 3206a6b..27f62d8 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -284,12 +284,16 @@ save_sectors(char *dev, int fdin) {
 	    }
 	}
 
-    close(fdout);
+    if (close_fd(fdout) != 0) {
+	warn(_("write failed: %s"), save_sector_file);
+	return 0;
+    }
     return 1;
 
  err:
     if (fdout >= 0)
-	close(fdout);
+	if (close_fd(fdout) != 0)
+	    warn(_("write failed: %s"), save_sector_file);
     return 0;
 }
 
@@ -355,7 +359,10 @@ restore_sectors(char *dev) {
     if (!reread_disk_partition(dev, fdout))	/* closes fdout */
 	goto err;
     close(fdin);
-
+    if (close_fd(fdout) != 0) {
+	error(_("write failed: %s"), dev);
+	return 0;
+    }
     return 1;
 
  err:
@@ -791,7 +798,7 @@ reread_disk_partition(char *dev, int fd) {
 	return 0;
     }
 
-    if (fsync(fd) || close(fd)) {
+    if (close_fd(fd) != 0) {
 	perror(dev);
 	warnx(_("Error closing %s\n"), dev);
 	return 0;
@@ -3026,7 +3033,10 @@ do_activate(char **av, int ac, char *arg) {
 		 "but the DOS MBR will only boot a disk with 1 active partition.\n"),
 		i);
 
-    close(fd);
+    if (close_fd(fd) != 0) {
+	my_warn(_("write failed"));
+	exit_status = 1;
+    }
 }
 
 static void
@@ -3074,7 +3084,10 @@ do_unhide(char **av, int ac, char *arg) {
     else
 	exit_status = 1;
 
-    close(fd);
+    if (close_fd(fd) != 0) {
+	my_warn(_("write failed"));
+	exit_status = 1;
+    }
 }
 
 static void
@@ -3108,7 +3121,10 @@ do_change_id(char *dev, char *pnam, char *id) {
 	exit_status = 1;
 
 done:
-    close(fd);
+    if (close_fd(fd) != 0) {
+	my_warn(_("write failed"));
+	exit_status = 1;
+    }
 }
 
 static void
-- 
1.8.2.1

