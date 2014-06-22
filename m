Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:35922 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbaFVTpk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Jun 2014 15:45:40 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h31.telenor.se (Postfix) with ESMTP id EDCEAC241
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 21:45:07 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] libmount: special treatment for auto in fstype pattern
Date: Sun, 22 Jun 2014 21:44:50 +0200
Message-Id: <1403466290-12880-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Quoting from https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=506695 :

according to mount(8), mount tries to guess a filesystem type when given
fstype `auto' and it tries multiple filesystems if a list of fstypes is
given.

A single fstype `auto' works as expected:
	mount -t auto /dev/sde /media/stick
mounts /dev/sde as vfat, which is correct.
However, merging `auto' with other types doesn't work as expected:
	mount -t ext2,auto /dev/sde /media/stick
does not mount /dev/sde but returns:
	mount: unknown filesystem type 'auto'

Trying multiple fstypes before allowing mount to guess makes sense in
different scenarios, for example to prefer specific fstypes (ext2
instead of ext3) or to try fstypes that mount doesn't guess (minix).
I'm not sure if the Debian installer still sets CDROM fstab entries to
`udf,iso9660,auto' but I remember it did once. This wouldn't work then
either.

Reported-by: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 libmount/src/context_mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index dcfdabf..d07fa02 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -782,6 +782,8 @@ static int do_mount_by_pattern(struct libmnt_context *cxt, const char *pattern)
 			char *end = strchr(p, ',');
 			if (end)
 				*end = '\0';
+			if (strcmp(p, "auto") == 0)
+				p = NULL;
 			rc = do_mount(cxt, p);
 			p = end ? end + 1 : NULL;
 
-- 
2.0.0

