Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f41.google.com ([209.85.215.41]:36340 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbaEENar (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 09:30:47 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so4007388lab.14
        for <util-linux@vger.kernel.org>; Mon, 05 May 2014 06:30:45 -0700 (PDT)
From: Alexander <alexsamilovskih@gmail.com>
To: alexander samilovskih <alexsamilovskih@gmail.com>,
        util-linux@vger.kernel.org, kerolasa@iki.fi
Subject: [PATCH 2/3] sys-utils/eject: add monotonic clock support
Date: Mon, 05 May 2014 20:30:14 +0200
Message-ID: <8403293.zXXAmOpAMP@alexpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From b72b47b2f8e12c4cb53e817939bad464139e9042 Mon Sep 17 00:00:00 2001
From: Alex Samilovskih <alexsamilovskih@gmail.com>
Date: Fri, 2 May 2014 18:21:20 +0000
Subject: [PATCH 2/3] Add support for monotonic clock in eject

---
 sys-utils/eject.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 03744c7..049cdb7 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -52,6 +52,7 @@
 #include "xalloc.h"
 #include "pathnames.h"
 #include "sysfs.h"
+#include "timeutils.h"
 
 /*
  * sg_io_hdr_t driver_status -- see kernel include/scsi/scsi.h
@@ -460,7 +461,7 @@ static void toggle_tray(int fd)
 	 * needed.  In my experience the function needs less than 0.05
 	 * seconds if the tray was already open, and at least 1.5 seconds
 	 * if it was closed.  */
-	gettimeofday(&time_start, NULL);
+	gettime_monotonic(&time_start);
 
 	/* Send the CDROMEJECT command to the device. */
 	if (!eject_cdrom(fd))
@@ -468,7 +469,7 @@ static void toggle_tray(int fd)
 
 	/* Get the second timestamp, to measure the time needed to open
 	 * the tray.  */
-	gettimeofday(&time_stop, NULL);
+	gettime_monotonic(&time_stop);
 
 	time_elapsed = (time_stop.tv_sec * 1000000 + time_stop.tv_usec) -
 		(time_start.tv_sec * 1000000 + time_start.tv_usec);
-- 
1.9.2
