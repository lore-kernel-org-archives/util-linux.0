Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44088 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab2DEPuV (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 5 Apr 2012 11:50:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 79F231B4013
	for <util-linux-ng@vger.kernel.org>; Thu,  5 Apr 2012 15:50:20 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH 3/3] eject: use CDROM_DRIVE_STATUS if available for tray toggling
Date: Thu,  5 Apr 2012 11:50:46 -0400
Message-Id: <1333641046-13125-3-git-send-email-vapier@gentoo.org>
In-Reply-To: <1333641046-13125-1-git-send-email-vapier@gentoo.org>
References: <1333641046-13125-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

One some platforms, the -T option can be unreliable (see reference bug
report for some examples).  Instead, if the kernel supports the cdrom
status ioctl, use that to ask explicitly for the current tray status
and then open/close accordingly.

The eject_cdrom() func was reworked slightly, but none of the existing
callers care about the explicit normalization to [0,1] values, so have
it return the raw value so we can convert toggle_tray() over to using
that.

Finally, now that toggle_tray() uses a lot of helper functions, drop
the check on CDROMCLOSETRAY.  The sub-functions take care of that.

Reference: https://bugs.gentoo.org/261880
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/eject.c |   52 ++++++++++++++++++++++++++++++++--------------------
 1 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 68d5e9c..245c028 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -386,6 +386,22 @@ static void close_tray(int fd)
 }
 
 /*
+ * Eject using CDROMEJECT ioctl.
+ */
+static int eject_cdrom(int fd)
+{
+#if defined(CDROMEJECT)
+	return ioctl(fd, CDROMEJECT);
+#elif defined(CDIOCEJECT)
+	return ioctl(fd, CDIOCEJECT);
+#else
+	warnx(_("CD-ROM eject unsupported"));
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
+/*
  * Toggle tray.
  *
  * Written by Benjamin Schwenk <benjaminschwenk@yahoo.de> and
@@ -400,7 +416,21 @@ static void toggle_tray(int fd)
 	struct timeval time_start, time_stop;
 	int time_elapsed;
 
-#ifdef CDROMCLOSETRAY
+#ifdef CDROM_DRIVE_STATUS
+	/* First ask the CDROM for info, otherwise fall back to manual.  */
+	switch (ioctl(fd, CDROM_DRIVE_STATUS)) {
+	case CDS_TRAY_OPEN:
+		close_tray(fd);
+		return;
+
+	case CDS_NO_DISC:
+	case CDS_DISC_OK:
+		if (eject_cdrom(fd))
+			err(EXIT_FAILURE, _("CD-ROM eject command failed"));
+		return;
+	}
+#endif
+
 	/* Try to open the CDROM tray and measure the time therefor
 	 * needed.  In my experience the function needs less than 0.05
 	 * seconds if the tray was already open, and at least 1.5 seconds
@@ -408,7 +438,7 @@ static void toggle_tray(int fd)
 	gettimeofday(&time_start, NULL);
 
 	/* Send the CDROMEJECT command to the device. */
-	if (ioctl(fd, CDROMEJECT, 0) < 0)
+	if (eject_cdrom(fd) < 0)
 		err(EXIT_FAILURE, _("CD-ROM eject command failed"));
 
 	/* Get the second timestamp, to measure the time needed to open
@@ -423,10 +453,6 @@ static void toggle_tray(int fd)
 	 * closed before. This would mean that we are done.  */
 	if (time_elapsed < TRAY_WAS_ALREADY_OPEN_USECS)
 		close_tray(fd);
-#else
-	warnx(_("CD-ROM tray toggle command not supported by this kernel"));
-#endif
-
 }
 
 /*
@@ -531,20 +557,6 @@ static void list_speeds(const char *name, int fd)
 }
 
 /*
- * Eject using CDROMEJECT ioctl. Return 1 if successful, 0 otherwise.
- */
-static int eject_cdrom(int fd)
-{
-#if defined(CDROMEJECT)
-	return ioctl(fd, CDROMEJECT) == 0;
-#elif defined(CDIOCEJECT)
-	return ioctl(fd, CDIOCEJECT) == 0;
-#else
-	warnx(_("CD-ROM eject unsupported"));
-#endif
-}
-
-/*
  * Eject using SCSI SG_IO commands. Return 1 if successful, 0 otherwise.
  */
 static int eject_scsi(int fd)
-- 
1.7.8.5

