Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:60373 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753527AbdGUSoF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Jul 2017 14:44:05 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA55DABC3
        for <util-linux@vger.kernel.org>; Fri, 21 Jul 2017 18:44:03 +0000 (UTC)
Subject: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and retry
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
 <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
Message-ID: <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
Date: Fri, 21 Jul 2017 20:44:03 +0200
MIME-Version: 1.0
In-Reply-To: <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In past, d50c5917 introduced an interesting behavior: If mount was called on a
CDROM with open tray, the tray was closed and mount was retried. But the
implementation caused 15 seconds delay, so ca55a451 reverted it.

This is another attempt to implement that:
If tray is closed: No delay, no retry, simply fail.
If tray is open: Check, whether the drive can close tray.
  If yes, close tray and retry after 3 seconds.
  If not, no delay, no retry, simply fail.

It can never cause delay more than time to close tray + 3 sec.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/context_mount.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 65f7dbfd0..ed0b84080 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -18,11 +18,15 @@
 
 #include <sys/wait.h>
 #include <sys/mount.h>
+#include <linux/cdrom.h>
 
 #include "linux_version.h"
 #include "mountP.h"
 #include "strutils.h"
 
+/* open() retries when errno is ENOMEDIUM and tray is open */
+#define CRDOM_TRAYOPEN_RETRIES    5
+
 /*
  * Kernel supports only one MS_PROPAGATION flag change by one mount(2) syscall,
  * to bypass this restriction we call mount(2) per flag. It's really not a perfect
@@ -1292,6 +1296,8 @@ int mnt_context_get_mount_excode(
 	int syserr;
 	struct stat st;
 	unsigned long uflags = 0, mflags = 0;
+	int cdrom;
+	unsigned int retries = 0;
 
 	int restricted = mnt_context_is_restricted(cxt);
 	const char *tgt = mnt_context_get_target(cxt);
@@ -1399,6 +1405,7 @@ int mnt_context_get_mount_excode(
 	/*
 	 * mount(2) errors
 	 */
+mount_retry:
 	syserr = mnt_context_get_syscall_errno(cxt);
 
 
@@ -1563,6 +1570,19 @@ int mnt_context_get_mount_excode(
 		break;
 
 	case ENOMEDIUM:
+		cdrom = open(mnt_context_get_source(cxt), O_RDONLY | O_NONBLOCK);
+		if (cdrom != -1) {
+			if (retries < CRDOM_TRAYOPEN_RETRIES &&
+			    (ioctl(cdrom, CDROM_GET_CAPABILITY, NULL) & CDC_CLOSE_TRAY) &&
+			    ioctl(cdrom, CDROM_DRIVE_STATUS, NULL) == CDS_TRAY_OPEN) {
+				ioctl(cdrom, CDROMCLOSETRAY);
+				close(cdrom);
+				sleep(3);
+				++retries;
+				goto mount_retry;
+			} else
+				close(cdrom);
+		}
 		if (uflags & MNT_MS_NOFAIL)
 			return MNT_EX_SUCCESS;
 		if (buf)
-- 
2.13.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
