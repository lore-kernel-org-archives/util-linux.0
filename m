Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:59654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750889AbdALPdv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 12 Jan 2017 10:33:51 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 955ED75012
        for <util-linux@vger.kernel.org>; Thu, 12 Jan 2017 14:45:27 +0000 (UTC)
To: Util-Linux <util-linux@vger.kernel.org>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 1/3] libmount: fix mount -oloop=/dev/loopX regression
Message-ID: <9d3edce3-83f4-bc14-82fc-823db481064e@suse.cz>
Date: Thu, 12 Jan 2017 15:45:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If mount option "loop" is used with an argument, it should be respected. Commit
8efad715 introduced a regression. Even with an argument, overlaying loop device
is searched and argument is ignored. It could have unexpected side effects.

If argument is set, never allocate a new loop device.

How to reproduce:
mkdir -p cdrom
mkisofs -o cdrom.iso cdrom/ 2>/dev/null
losetup /dev/loop0 cdrom.iso
strace mount -t auto -o ro,loop=/dev/loop1 cdrom.iso /mnt 2>&1 | grep ^mount
cat /proc/self/mountinfo | grep /mnt
umount /mnt
losetup -d /dev/loop0

mount("/dev/loop0", "/mnt", "iso9660", MS_MGC_VAL|MS_RDONLY, NULL) = 0
327 60 7:0 / /mnt ro,relatime shared:241 - iso9660 /dev/loop0 ro
losetup: /dev/loop0: detach failed: No such device or address

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/context_loopdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 8ef183107..18eb2cc56 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -259,7 +259,12 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 				goto done;
 			}
 			rc = 0;
-			goto success;
+			/* loop= used with argument. Conflict will occur. */
+			if (loopval) {
+				rc = -MNT_ERR_LOOPOVERLAP;
+				goto done;
+			} else
+				goto success;
 		}
 		default: /* error */
 			goto done;
-- 
2.11.0

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
