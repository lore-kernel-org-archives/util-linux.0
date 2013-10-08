Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3JHIyQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Oct 2013 04:54:16 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r988sFRX025104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Oct 2013 04:54:15 -0400
Received: from choo.home.annexia.org (vpn1-7-220.ams2.redhat.com [10.36.7.220])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r988sE0p026361
	for <util-linux@vger.kernel.org>; Tue, 8 Oct 2013 04:54:15 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] blockdev: Remove the --setbsz (set blocksize) option which has never worked.
Date: Tue,  8 Oct 2013 09:54:10 +0100
Message-Id: <1381222450-30380-1-git-send-email-rjones@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Richard W.M. Jones" <rjones@redhat.com>

This option has never worked.  If you try setting the block size on a
block device, and then read it using --getbsz, you will see that the
block size never changes.

The reason for this is because the block size is specific to the
current file descriptor opening the block device, so the change of
block size only persists for as long as blockdev has the device open,
and is lost once blockdev exits.

Also the block size is not really used anywhere.  Filesystems, for
example, have their own idea of block size and ignore this setting
completely.

(Thanks Masayoshi Mizuma for diagnosing the problem)

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 bash-completion/blockdev | 7 +------
 disk-utils/blockdev.8    | 2 --
 disk-utils/blockdev.c    | 7 -------
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/bash-completion/blockdev b/bash-completion/blockdev
index ce986cb..5889955 100644
--- a/bash-completion/blockdev
+++ b/bash-completion/blockdev
@@ -19,7 +19,6 @@ _blockdev_module()
 		--getalignoff
 		--getmaxsect
 		--getbsz
-		--setbsz
 		--getsize64
 		--setra
 		--getra
@@ -29,11 +28,7 @@ _blockdev_module()
 		--rereadpt
 		$DEVS"
 	case $prev in
-		'--setbsz')
-			COMPREPLY=( $(compgen -W "bytes" -- $cur) )
-			return 0
-			;;
-		'--setbsz'|'--setfra')
+		'--setfra')
 			COMPREPLY=( $(compgen -W "sectors" -- $cur) )
 			return 0
 			;;
diff --git a/disk-utils/blockdev.8 b/disk-utils/blockdev.8
index 2b3d64c..6ab4324 100644
--- a/disk-utils/blockdev.8
+++ b/disk-utils/blockdev.8
@@ -67,8 +67,6 @@ Print sectorsize in bytes - usually 512.
 Get size in 512-byte sectors.
 .IP "\fB\-\-rereadpt\fP"
 Reread partition table
-.IP "\fB\-\-setbsz\fP \fIbytes\fP"
-Set blocksize.
 .IP "\fB\-\-setfra\fP \fIsectors\fP"
 Set filesystem readahead (same like --setra on 2.6 kernels).
 .IP "\fB\-\-setra\fP \fIsectors\fP"
diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index 4543818..dc02d48 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -122,13 +122,6 @@ static const struct bdc bdcms[] =
 		.argval = -1,
 		.help = N_("get blocksize")
 	},{
-		IOCTL_ENTRY(BLKBSZSET),
-		.name = "--setbsz",
-		.argname = "<bytes>",
-		.argtype = ARG_INT,
-		.flags = FL_NORESULT,
-	        .help = N_("set blocksize")
-	},{
 		IOCTL_ENTRY(BLKGETSIZE),
 		.name = "--getsize",
 		.argtype = ARG_ULONG,
-- 
1.8.3.1

