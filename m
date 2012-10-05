Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62049 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab2JEQh7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 5 Oct 2012 12:37:59 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q95GbxuT019496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 5 Oct 2012 12:37:59 -0400
From: Milan Broz <mbroz@redhat.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <mbroz@redhat.com>
Subject: [PATCH 3/3] tests: fix mount move test to work with shared mount
Date: Fri,  5 Oct 2012 18:37:40 +0200
Message-Id: <1349455060-807-3-git-send-email-mbroz@redhat.com>
In-Reply-To: <1349455060-807-1-git-send-email-mbroz@redhat.com>
References: <1349455060-807-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If parent mount for test directory is mounted with shared flag,
move mount test fails because kernel rejects mount move operation.

Use another directory level and explicitly make parent mount private.

(All "modern" systems using system have mounts shared for some reason.)

Signed-off-by: Milan Broz <mbroz@redhat.com>
---
 tests/ts/mount/move |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tests/ts/mount/move b/tests/ts/mount/move
index 3862f46..ea37685 100755
--- a/tests/ts/mount/move
+++ b/tests/ts/mount/move
@@ -22,9 +22,19 @@ TS_DESC="move"
 ts_init "$*"
 ts_skip_nonroot
 
-DIR_SRC="$TS_OUTDIR/mnt-move-src"
-DIR_A="$TS_OUTDIR/mnt-move-A"
-DIR_B="$TS_OUTDIR/mnt-move-B"
+DIR_PRIVATE2="$TS_OUTDIR/mnt-move-private2"
+DIR_PRIVATE="$TS_OUTDIR/mnt-move-private"
+
+DIR_SRC="$DIR_PRIVATE/mnt-move-src"
+DIR_A="$DIR_PRIVATE/mnt-move-A"
+DIR_B="$DIR_PRIVATE/mnt-move-B"
+
+# create bind mount and make it private to be sure
+# (kernel cannot move mount with shared parent)
+[ -d $DIR_PRIVATE2 ] || mkdir $DIR_PRIVATE2
+[ -d $DIR_PRIVATE ] || mkdir $DIR_PRIVATE
+$TS_CMD_MOUNT --bind $DIR_PRIVATE2 $DIR_PRIVATE
+$TS_CMD_MOUNT --make-private $DIR_PRIVATE
 
 [ -d $DIR_SRC ] || mkdir $DIR_SRC
 [ -d $DIR_A ] || mkdir $DIR_A
@@ -48,6 +58,9 @@ $TS_CMD_FINDMNT --kernel --target "$DIR_B" &> /dev/null
 $TS_CMD_UMOUNT $DIR_B
 rmdir $DIR_SRC $DIR_A $DIR_B
 
+$TS_CMD_UMOUNT $DIR_PRIVATE
+rmdir $DIR_PRIVATE $DIR_PRIVATE2
+
 ts_log "Success"
 ts_finalize
 
-- 
1.7.10.4

