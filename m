Return-Path: util-linux-owner@vger.kernel.org
Received: from vint.altlinux.org ([194.107.17.35]:35674 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab2I0Qsl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Sep 2012 12:48:41 -0400
Date: Thu, 27 Sep 2012 20:48:34 +0400
From: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH v2] libmount: fix support of comma-separated fs types lists
Message-ID: <20120927164834.GA19341@c227.office.altlinux.ru>
References: <20120927161807.GA19450@c227.office.altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
In-Reply-To: <20120927161807.GA19450@c227.office.altlinux.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

	# grep cdrom /etc/fstab
	/dev/sr0 /media/cdrom udf,iso9660 ro,noauto,user,utf8 0 0
	# mount /media/cdrom
	mount: unknown filesystem type 'udf,iso9660'

	# mount -t udf,iso9660 /dev/sr0 /media/cdrom
	mount: /dev/sr0 is write-protected, mounting read-only

Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
---
 libmount/src/context_mount.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index f3d8ff1..867e644 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -691,9 +691,12 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
 		cxt->mountdata = (char *) mnt_fs_get_fs_options(cxt->fs);
 
 	type = mnt_fs_get_fstype(cxt->fs);
-	if (type)
-		res = do_mount(cxt, NULL);
-	else
+	if (type) {
+		if (strchr(type, ','))
+			res = do_mount_by_pattern(cxt, type);
+		else
+			res = do_mount(cxt, NULL);
+	} else
 		res = do_mount_by_pattern(cxt, cxt->fstype_pattern);
 
 	if (mnt_context_get_status(cxt)

-- 
	glebfm
	Глеб Фотенгауэр-Малиновский

