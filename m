Received: from out-2z4y-a151.jellyfish.systems (out-2z4y-a151.jellyfish.systems [198.54.127.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF5244687
	for <util-linux@vger.kernel.org>; Sun,  4 Oct 2026 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791081729; cv=none; b=Fq1rBN1heiKtGlwhDJZCPu6NZkIcQHd6i8lFW0lkvc5ymTa15Pu0trL5/VuH6RdvOjNVuzqvKZAb0oS+t+eAG9/pbicWHs3ZxWztvwaQ/iWoBFitaJBaDaq6Im3827p7eCxSNlrlo8MfInmGybGhY6kF9sm0yPZJ8C1A0oA3DHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791081729; c=relaxed/simple;
	bh=x6lV2zVpKjV4rvAIa2QW0i/n6Bazo4lUXeHdjc0mjKw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=i/V6U2nLCjBwjD09bovd4dKNrPF4Dfh3UID+hRDkT17M8AeaDCIObRBF1vH3l7zx0D1AqJiV+4yMnPRivlH4a+zzUjqD8OYr5OIfPx6A3bdZKYJsC3WSNIaUFjbgrXls08M6mzzjZi6aVyzFimlt3iClyGpBTf44SWmnZs4j68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=fDrsGPUB; arc=none smtp.client-ip=198.54.127.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="fDrsGPUB"
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hy6Gq64Kdz8sWN;
	Sun, 04 Oct 2026 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1791081701;
	bh=TNO44zj46CvCcChPBKf3Iub1W/bg1/+qhPkPNLE2LEo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=fDrsGPUBiJ+3zrODolAVvOvpPPZXlDljqh2Ltr7OOM6x9xWt+bao2ef4FtAswef1x
	 eMEtJlMgh8UaepviCidZsfXe5lgh422TKzEZBEVlxwWajdzPPTKk0zPT0wlIhmZ/NJ
	 cbhARXRLvWNaGxebSRbIj9lpeDJK9J0maoavnczDS5rQ5b8AIHA70rFluvSvz8q4rn
	 hJ6qB1PYmB9Y+nrOk7k8F+8YUS3ozwminn/au/IA79BOlHX3vULiOm9ltXT+1LjRgU
	 PpHcFjMRsVtVH2sxXlkmO3ocEH76pMBzDRFuxX1v/REOc3FBwp+GqcjBHpGz122Ri0
	 T/2FzSXAeuy+Q==
X-Mailbox-Line: From 3916bb55c0b50b8a0f9a5caddf2acab86be1d12e Mon Sep 17 00:00:00 2001
Message-ID: <3916bb55c0b50b8a0f9a5caddf2acab86be1d12e.1791081687.git.hi@tychen.cc>
In-Reply-To: <cover.1791081687.git.hi@tychen.cc>
References: <cover.1791081687.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Fri, 2 Oct 2026 21:17:19 +0900
Subject: [PATCH v2 1/2] libmount: keep reused loop devices attached on mount
 failure
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
X-Envelope-From: hi@tychen.cc
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

A loop device found by overlap detection may have been set up by the
caller. Do not detach it when a later mount step fails; only close the
reference acquired by this mount.

Add a regression test using a preconfigured device and an invalid
filesystem option.

Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 libmount/src/hook_loopdev.c     |  7 +++++++
 tests/expected/mount/loop-reuse |  1 +
 tests/ts/mount/loop-reuse       | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 tests/expected/mount/loop-reuse
 create mode 100755 tests/ts/mount/loop-reuse

diff --git a/libmount/src/hook_loopdev.c b/libmount/src/hook_loopdev.c
index b2291340..809d64d8 100644
--- a/libmount/src/hook_loopdev.c
+++ b/libmount/src/hook_loopdev.c
@@ -21,6 +21,7 @@
 
 struct hook_data {
 	int loopdev_fd;
+	bool reused;
 };
 
 static int delete_loopdev(struct libmnt_context *cxt, struct hook_data *hd);
@@ -350,6 +351,7 @@ static int setup_loopdev(struct libmnt_context *cxt,
 	} while (1);
 
 success:
+	hd->reused = reuse;
 	if (!rc)
 		rc = mnt_fs_set_source(cxt->fs, loopcxt_get_device(&lc));
 
@@ -408,6 +410,11 @@ static int delete_loopdev(struct libmnt_context *cxt, struct hook_data *hd)
 		hd->loopdev_fd = -1;
 	}
 
+	if (hd && hd->reused) {
+		DBG_OBJ(LOOP, cxt, ul_debug("keeping reused device"));
+		return 0;
+	}
+
 	rc = loopdev_detach(src);	/* see lib/loopdev.c */
 
 	DBG_OBJ(LOOP, cxt, ul_debug("deleted [rc=%d]", rc));
diff --git a/tests/expected/mount/loop-reuse b/tests/expected/mount/loop-reuse
new file mode 100644
index 00000000..9b132bb6
--- /dev/null
+++ b/tests/expected/mount/loop-reuse
@@ -0,0 +1 @@
+reused device preserved: OK
diff --git a/tests/ts/mount/loop-reuse b/tests/ts/mount/loop-reuse
new file mode 100755
index 00000000..704b3378
--- /dev/null
+++ b/tests/ts/mount/loop-reuse
@@ -0,0 +1,23 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="keep reused loop device on failure"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_skip_nonroot
+ts_check_losetup
+ts_check_prog "mkfs.ext2"
+
+ts_device_init
+mkfs.ext2 -F "$TS_LODEV" &> /dev/null || ts_die "Cannot make filesystem"
+mkdir -p "$TS_MOUNTPOINT"
+$TS_CMD_MOUNT -t ext2 -o loop,invalid-fs-option "$TS_OUTDIR/$TS_TESTNAME.img" \
+	"$TS_MOUNTPOINT" &> /dev/null && ts_die "Accepted invalid filesystem option"
+[ "$($TS_CMD_LOSETUP -j "$TS_OUTDIR/$TS_TESTNAME.img" | cut -d: -f1)" = "$TS_LODEV" ] ||
+	ts_die "Failed mount detached reused device"
+ts_log "reused device preserved: OK"
+ts_finalize
-- 
2.55.0


