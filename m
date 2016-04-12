Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48742 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933065AbcDLSW5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Apr 2016 14:22:57 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 6A175AC13
	for <util-linux@vger.kernel.org>; Tue, 12 Apr 2016 18:22:55 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/3] libmount: reuse existing loop device
Message-ID: <570D3D00.1060404@suse.cz>
Date: Tue, 12 Apr 2016 20:22:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

According to the Al Viro[1], kernel has no way to detect that a single file is
used by multiple loop devices, and multiple mounts of the same file using
different loop devices will result in a data corruption. Exactly this now
happens, if multiple btrfs sub-volumes in one file are mounted with "-oloop".

Make use of multiple -oloop mounting the same file safe: Do a loop devices
lookup, and if a loop device is already initialized, use it.

Hopefully it is possible, as "losetup -d" will return OK, even if the device
itself is in use, and is not released.

Problems:

There is a risk of race condition between the lookup and real mount.

Once loop device is initialized read-only, kernel offers no way to turn it to
read-write. It has to fail.

References:
https://lkml.org/lkml/2016/2/26/897

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/context_loopdev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 47d6294..0aa91ea 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -210,6 +210,29 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	if (rc)
 		goto done_no_deinit;
 
+	/* It is possible to mount the same file more times. If we set more
+	 * than one loop device referring to the same file, kernel has no
+	 * mechanism to detect it. To prevent data corruption, the same loop
+	 * device has to be recycled.
+	*/
+	rc = loopcxt_init(&lc, 0);
+	if (rc)
+		goto done;
+	if (backing_file && !(loopcxt_find_by_backing_file(&lc,
+			backing_file, offset, LOOPDEV_FL_OFFSET))) {
+		DBG(LOOP, ul_debugobj(cxt, "using existing loop device %s",
+					loopcxt_get_device(&lc)));
+		/* Once a loop is initialized RO, there is no way to safely
+		   mount that file in R/W mode. */
+		if (loopcxt_is_readonly(&lc) && !(lo_flags & LO_FLAGS_READ_ONLY)) {
+			rc = -EROFS;
+			goto done;
+		}
+
+		goto success;
+	}
+	loopcxt_deinit(&lc);
+
 	rc = loopcxt_init(&lc, 0);
 	if (rc == 0 && loopval) {
 		rc = loopcxt_set_device(&lc, loopval);
@@ -267,6 +290,7 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 		DBG(LOOP, ul_debugobj(cxt, "device stolen...trying again"));
 	} while (1);
 
+success:
 	if (!rc)
 		rc = mnt_fs_set_source(cxt->fs, loopcxt_get_device(&lc));
 
-- 
2.8.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
