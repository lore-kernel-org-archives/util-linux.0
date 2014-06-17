Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:53592 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130AbaFQURW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Jun 2014 16:17:22 -0400
Received: by mail-wi0-f170.google.com with SMTP id cc10so7502224wib.1
        for <util-linux@vger.kernel.org>; Tue, 17 Jun 2014 13:17:21 -0700 (PDT)
From: arnaud.mouiche@gmail.com
To: util-linux@vger.kernel.org
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH] mkfs.cramfs: fix potential uid, gid or mode drop.
Date: Tue, 17 Jun 2014 22:16:54 +0200
Message-Id: <1403036214-13067-1-git-send-email-arnaud.mouiche@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

find_identical_file() may squash files with identical contents, but
different uid/gid or mode.

here is a test script to show the problem (to run as root):
without this patch, the output is

  -rw-r--r-- 1 root root 4 janv.  1  1970 a
  -rw-r--r-- 1 root root 4 janv.  1  1970 b
  -rw-r--r-- 1 root root 4 janv.  1  1970 c

whereas the expected result should be

  -rw-r--r-- 1 root   root 4 janv.  1  1970 a
  -rw------- 1 root   root 4 janv.  1  1970 b
  -rw-r--r-- 1 daemon root 4 janv.  1  1970 c



#!/bin/sh
mkdir -p /tmp/fs
cd /tmp/fs

echo foo > a
cp a b
cp a c
chmod 600 b
chown 1 c

cd /tmp
mkfs.cramfs -v /tmp/fs /tmp/fs.cramfs

losetup -f /tmp/fs.cramfs
mkdir -p /tmp/fs_mnt

DEVICE=$(sudo losetup -j /tmp/fs.cramfs -o 0 | sed -e 's/:.*//')
mount $DEVICE /tmp/fs_mnt -o ro
ls -l /tmp/fs_mnt

umount $DEVICE
losetup -d $DEVICE


Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 disk-utils/mkfs.cramfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 6f412d8..b217645 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -242,7 +242,11 @@ static int find_identical_file(struct entry *orig, struct entry *new, loff_t *fs
 		return 1;
 	if (!orig)
 		return 0;
-	if (orig->size == new->size && orig->path) {
+	if (orig->size == new->size &&
+		orig->uid == new->uid &&
+		orig->gid == new->gid &&
+		orig->mode == new->mode &&
+		orig->path) {
 		if (!orig->flags)
 			mdfile(orig);
 		if (!new->flags)
-- 
1.9.1

