Return-Path: glebfm@altlinux.org
Date: Thu, 27 Sep 2012 20:18:16 +0400
From: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] libmount: fix support of comma-separated fs types lists
Message-ID: <20120927161807.GA19450@c227.office.altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
List-ID: <util-linux.vger.kernel.org>

	# grep cdrom /etc/fstab
	/dev/sr0 /media/cdrom udf,iso9660 ro,noauto,user,utf8 0 0
	# mount /media/cdrom
	mount: unknown filesystem type 'udf,iso9660'

	# mount -t udf,iso9660 /dev/sr0 /media/cdrom
	mount: /dev/sr0 is write-protected, mounting read-only

Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
---
 libmount/src/context_mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index f3d8ff1..efd7e7b 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -691,7 +691,7 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
 		cxt->mountdata =3D (char *) mnt_fs_get_fs_options(cxt->fs);
=20
 	type =3D mnt_fs_get_fstype(cxt->fs);
-	if (type)
+	if (type && !strchr(type, ','))
 		res =3D do_mount(cxt, NULL);
 	else
 		res =3D do_mount_by_pattern(cxt, cxt->fstype_pattern);

--=20
	glebfm
	=E7=CC=C5=C2 =E6=CF=D4=C5=CE=C7=C1=D5=DC=D2-=ED=C1=CC=C9=CE=CF=D7=D3=CB=C9=
=CA
