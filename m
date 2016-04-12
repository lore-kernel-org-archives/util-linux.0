Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48785 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933037AbcDLSX1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Apr 2016 14:23:27 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 291B6AC13
	for <util-linux@vger.kernel.org>; Tue, 12 Apr 2016 18:23:25 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 3/3] mount: Handle EROFS before calling mount() syscall
Message-ID: <570D3D1D.1050502@suse.cz>
Date: Tue, 12 Apr 2016 20:23:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If the loop device is already initialized read-only, the new code for loop
device reuse returns -EROFS. There is no solution of this situation. But mount
can behave in the same way, as it does for EROFS returned by mount syscall: Try
again in read-only mode.

Before:
mount: /mnt/2: mount failed: Read-only file system

After:
mount: /btrfs.img is used as read only loop, mounting read-only

Note: It would be nice to mention loop device name in the warning message, but
it is not available in the mount context.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/mount.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 9c4729e..3e90fcc 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -402,6 +402,15 @@ try_readonly:
 		case -EBUSY:
 			warnx(_("%s is already mounted"), src);
 			return MOUNT_EX_USAGE;
+		/* -EROFS before syscall can happen only for loop mount */
+		case -EROFS:
+			warnx(_("%s is used as read only loop, mounting read-only"), src);
+			mnt_context_reset_status(cxt);
+			mnt_context_set_mflags(cxt, mflags | MS_RDONLY);
+			rc = mnt_context_mount(cxt);
+			if (!rc)
+				rc = mnt_context_finalize_mount(cxt);
+			goto try_readonly;
 		case -MNT_ERR_NOFSTAB:
 			if (mnt_context_is_swapmatch(cxt)) {
 				warnx(_("can't find %s in %s"),
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
