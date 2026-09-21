Received: from out-2z4y-a134.jellyfish.systems (out-2z4y-a134.jellyfish.systems [198.54.127.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C024886E
	for <util-linux@vger.kernel.org>; Sun,  4 Oct 2026 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791081729; cv=none; b=JTZFFGJz8Y+2Ti+pKVMlr4Me3Ypxb+ajhTVDN3OXEFy0UCER4RIwT+5woV+nyBsU5PnfOrBqkpdOlrebHUWh0mgXtG1SsQhDqu3kef2CnmGGJCvKWKcRTze2mI0wcLKz+4lllJID5BFd07DRnio6RJHc+w7FNdeIqbd2HS8ShwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791081729; c=relaxed/simple;
	bh=KNiyYz6coA+AIPLT93DANbNUOw91vOdgjh9Ibo5Ib2Y=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=GasQilaSHWbIjfEpGP+K9xjt1RSqhzutCkfRhv8BQ/pH14qap9h4G6fWiE/VZGhE6mY65L9AFYHxv/qeTGEQuPn6EW49I9Yyv6XoVmWp12nmsePaCev9UzTXni+4KwJpqcavtRmjzs3Rkx58XZwvEpnIu7qy8gR/r1EKpiG3lI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=AwjlS8oy; arc=none smtp.client-ip=198.54.127.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="AwjlS8oy"
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hy6Gt2hFyz8sWR;
	Sun, 04 Oct 2026 02:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1791081704;
	bh=oyhuHSmK38s9E75NfcoUge8YepZO3ruUH0pH61dAA/Y=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=AwjlS8oyBShcKngxC7Dyy9kVwApoqLlJpdsOu4f5yTA3jBSeZGIxHG0ah6yGTsRpn
	 lLC2Lkl5vpkMZlENbeuv1ojO9RHnF3yO/19Nlg7Q1mzowoPDsHg70V0sfqlr2lBhGV
	 VC9RtROwNSo+OmyL/L8ijc2+0VyULt1EbW69pFAf+56eQBM1UIKT66zKIAFOLeVueu
	 M75B2MTGRNe2c2q1utEZxKhuFNaeXdk9E/kZwe0SV5NzV5e4T/iG4h1cHHD0n972FY
	 nY76kfQIosmui/X31VO8+/6DtygdPBiFeBryJ42HSm1ozszBDZ9k4GA2xceLudCUiZ
	 o8NZU1p6dElnQ==
X-Mailbox-Line: From 7c812fc97f090bbf42479c455fb65df6f5f2135e Mon Sep 17 00:00:00 2001
Message-ID: <7c812fc97f090bbf42479c455fb65df6f5f2135e.1791081687.git.hi@tychen.cc>
In-Reply-To: <cover.1791081687.git.hi@tychen.cc>
References: <cover.1791081687.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Mon, 21 Sep 2026 16:34:05 +0900
Subject: [PATCH v2 2/2] libmount: support explicit loop direct I/O requests
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
X-Envelope-From: hi@tychen.cc
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Allow X-loopdev.direct-io=on|off to select the direct I/O mode when
mounting a file through a loop device. Pass the flag to the existing
loop setup path and require a matching mode when reusing a device.
Omitting the option preserves the current behavior.

Add an explicit diagnostic for direct I/O mode conflicts and document
that the option is a request whose result should be checked with
losetup. Parse the boolean with ul_strtobool and cover the option with
the standard loop-device test cleanup helpers.

Fixes: https://github.com/util-linux/util-linux/issues/3464
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 libmount/src/hook_loopdev.c         | 34 +++++++++++-
 sys-utils/mount.8.adoc              | 13 ++++-
 tests/expected/mount/loop-direct-io |  6 +++
 tests/ts/mount/loop-direct-io       | 84 +++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 tests/expected/mount/loop-direct-io
 create mode 100755 tests/ts/mount/loop-direct-io

diff --git a/libmount/src/hook_loopdev.c b/libmount/src/hook_loopdev.c
index 809d64d8..981ad6c1 100644
--- a/libmount/src/hook_loopdev.c
+++ b/libmount/src/hook_loopdev.c
@@ -139,7 +139,7 @@ static int setup_loopdev(struct libmnt_context *cxt,
 {
 	const char *backing_file, *loopdev = NULL;
 	struct loopdev_cxt lc;
-	int rc = 0, lo_flags = 0;
+	int rc = 0, lo_flags = 0, direct_io = -1;
 	uint64_t offset = 0, sizelimit = 0;
 	bool reuse = FALSE;
 	struct libmnt_opt *opt, *loopopt = NULL;
@@ -155,6 +155,23 @@ static int setup_loopdev(struct libmnt_context *cxt,
 		lo_flags |= LO_FLAGS_READ_ONLY;
 	}
 
+	/*
+	 * X-loopdev.direct-io=
+	 */
+	opt = mnt_optlist_get_named(ol, "X-loopdev.direct-io", cxt->map_userspace);
+	if (opt) {
+		const char *value = mnt_opt_get_value(opt);
+		bool enabled;
+
+		if (ul_strtobool(value, &enabled) != 0) {
+			rc = -MNT_ERR_MOUNTOPT;
+			goto done_no_deinit;
+		}
+		direct_io = enabled;
+		if (enabled)
+			lo_flags |= LO_FLAGS_DIRECT_IO;
+	}
+
 	/*
 	 * loop=
 	 */
@@ -258,6 +275,18 @@ static int setup_loopdev(struct libmnt_context *cxt,
 				goto done;
 			}
 
+			if (direct_io != -1 && !!loopcxt_is_dio(&lc) != direct_io) {
+				const char *dev = loopcxt_get_device(&lc);
+
+				DBG_OBJ(LOOP, cxt, ul_debug("%s has incompatible direct I/O mode",
+						dev));
+				/* TRANSLATORS: Do not translate "e ". It is a message classifier. */
+				mnt_context_sprintf_mesg(cxt,
+						_("e loop device %s has incompatible direct I/O mode"), dev);
+				rc = -MNT_ERR_LOOPOVERLAP;
+				goto done;
+			}
+
 			/* This is no more supported, but check to be safe. */
 			if (loopcxt_get_encrypt_type(&lc, &lc_encrypt_type) == 0
 			    && lc_encrypt_type != LO_CRYPT_NONE) {
@@ -454,7 +483,8 @@ static int is_loopdev_required(struct libmnt_context *cxt, struct libmnt_optlist
 		return 0;
 
 	/* loop= (sizelimit= or offset=) explicitly specified */
-	if (flags & (MNT_MS_LOOP | MNT_MS_OFFSET | MNT_MS_SIZELIMIT)) {
+	if (flags & (MNT_MS_LOOP | MNT_MS_OFFSET | MNT_MS_SIZELIMIT)
+	    || mnt_optlist_get_named(ol, "X-loopdev.direct-io", cxt->map_userspace)) {
 		DBG_OBJ(LOOP, cxt, ul_debug("loopdev specific options detected"));
 		return 1;
 	}
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 922ecda7..6261bac3 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -796,6 +796,17 @@ ____
 mount -t auto -o'X-mount.auto-fstypes="noext2,ext3"'  /dev/sdc1 /mnt/test
 ____
 
+*X-loopdev.direct-io*=*on*|*off*::
+Request enabling or disabling direct I/O when setting up a loop device. The
+kernel may fall back to buffered I/O, for example when the backing file
+offset is unaligned or the block size is too small. Direct I/O is a request,
+not a guarantee; check the effective mode with *losetup --list -O NAME,DIO*. If a loop device already exists for
+the same file, offset and size limit, its direct I/O mode must match; otherwise
+the mount fails without changing the existing device. Without this option, new
+loop devices use buffered I/O and existing devices can be reused in either
+mode. This option does not change an existing mount or apply when no loop
+device is needed. See also *losetup*(8) *--direct-io*.
+
 *X-mount.mkdir*[**=**_mode_]::
 Allow to make a target directory (mountpoint) if it does not exist yet. The optional argument _mode_ specifies the filesystem access mode used for *mkdir*(2) in octal notation. The default mode is 0755. This functionality is supported only for root users or when *mount* is executed without suid permissions. The option is also supported as *x-mount.mkdir*, but this notation is deprecated since v2.30. See also *--mkdir* command line option.
 
@@ -1708,7 +1719,7 @@ ____
 *mount -t ext4 /tmp/disk.img /mnt*
 ____
 
-This type of mount knows about three options, namely *loop*, *offset* and *sizelimit*, that are really options to *losetup*(8). (These options can be used in addition to those specific to the filesystem type.)
+Loop device setup accepts *loop*, *offset*, *sizelimit* and *X-loopdev.direct-io*, corresponding to options of *losetup*(8). (These options can be used in addition to those specific to the filesystem type.)
 
 Since Linux 2.6.25 auto-destruction of loop devices is supported, meaning that any loop device allocated by *mount* will be freed by *umount* independently of _/etc/mtab_.
 
diff --git a/tests/expected/mount/loop-direct-io b/tests/expected/mount/loop-direct-io
new file mode 100644
index 00000000..990eda84
--- /dev/null
+++ b/tests/expected/mount/loop-direct-io
@@ -0,0 +1,6 @@
+invalid options: OK
+new device (on): OK
+new device (off): OK
+new device (default): OK
+reuse and failed mount (on): OK
+reuse and failed mount (off): OK
diff --git a/tests/ts/mount/loop-direct-io b/tests/ts/mount/loop-direct-io
new file mode 100755
index 00000000..c5cf9723
--- /dev/null
+++ b/tests/ts/mount/loop-direct-io
@@ -0,0 +1,84 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="loop direct I/O"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_skip_nonroot
+ts_check_losetup
+ts_check_prog "mkfs.ext2"
+
+IMAGE=$(ts_image_init)
+
+mkfs.ext2 -F "$IMAGE" &> /dev/null || ts_die "Cannot make filesystem"
+mkdir -p "$TS_MOUNTPOINT"
+
+for option in X-loopdev.direct-io X-loopdev.direct-io= X-loopdev.direct-io=invalid; do
+	$TS_CMD_MOUNT -o "$option" "$IMAGE" "$TS_MOUNTPOINT" &> /dev/null &&
+		ts_die "Accepted invalid option: $option"
+done
+[ -z "$($TS_CMD_LOSETUP -j "$IMAGE")" ] || ts_die "Invalid option left a loop device"
+ts_log "invalid options: OK"
+
+DEVICE=$($TS_CMD_LOSETUP --direct-io=on --find --show "$IMAGE" 2>> "$TS_ERRLOG") ||
+	ts_skip "backing filesystem does not support direct I/O"
+ts_register_loop_device "$DEVICE"
+[ "$(cat "/sys/class/block/${DEVICE##*/}/loop/dio")" = 1 ] ||
+	ts_skip "loop direct I/O not supported"
+ts_cleanup_on_exit
+
+for mode in on off default; do
+	options=loop
+	expected=0
+	[ "$mode" = default ] || options+=",X-loopdev.direct-io=$mode"
+	[ "$mode" != on ] || expected=1
+	$TS_CMD_MOUNT -o "$options" "$IMAGE" "$TS_MOUNTPOINT" >> "$TS_ERRLOG" 2>&1 ||
+		ts_die "Cannot mount with mode $mode"
+	DEVICE=$($TS_CMD_LOSETUP -j "$IMAGE" | cut -d: -f1)
+	ts_register_loop_device "$DEVICE"
+	[ "$(cat "/sys/class/block/${DEVICE##*/}/loop/dio")" = "$expected" ] ||
+		ts_die "Wrong direct I/O mode: $mode"
+	$TS_CMD_UMOUNT "$TS_MOUNTPOINT" || ts_die "Cannot unmount"
+	ts_cleanup_on_exit
+	$TS_CMD_MOUNT -t ext2 -o "$options,invalid-fs-option" "$IMAGE" "$TS_MOUNTPOINT" &> /dev/null &&
+		ts_die "Accepted invalid filesystem option on new device"
+	[ -z "$($TS_CMD_LOSETUP -j "$IMAGE")" ] || ts_die "Failed mount left a new loop device"
+	ts_log "new device ($mode): OK"
+done
+
+for mode in on off; do
+	DEVICE=$($TS_CMD_LOSETUP --direct-io="$mode" --find --show "$IMAGE") ||
+		ts_die "Cannot set up device"
+	ts_register_loop_device "$DEVICE"
+	alias=yes
+	[ "$mode" != off ] || alias=no
+	for options in "loop,X-loopdev.direct-io=$mode" "X-loopdev.direct-io=$alias" loop; do
+		$TS_CMD_MOUNT -o "$options" "$IMAGE" "$TS_MOUNTPOINT" >> "$TS_ERRLOG" 2>&1 ||
+			ts_die "Cannot reuse device: $options"
+		$TS_CMD_UMOUNT "$TS_MOUNTPOINT" || ts_die "Cannot unmount reused device"
+	done
+	other=on
+	[ "$mode" != on ] || other=off
+	$TS_CMD_MOUNT -o "X-loopdev.direct-io=$other" "$IMAGE" "$TS_MOUNTPOINT" > "$TS_OUTDIR/mode-error" 2>&1 &&
+		ts_die "Reused device with incompatible direct I/O mode"
+	grep -q "incompatible direct I/O mode" "$TS_OUTDIR/mode-error" ||
+		ts_die "Missing direct I/O diagnostic"
+	$TS_CMD_MOUNT -t ext2 -o "X-loopdev.direct-io=$mode,invalid-fs-option" \
+		"$IMAGE" "$TS_MOUNTPOINT" &> /dev/null &&
+		ts_die "Accepted invalid filesystem option"
+	[ "$($TS_CMD_LOSETUP -j "$IMAGE" | cut -d: -f1)" = "$DEVICE" ] ||
+		ts_die "Failed mount detached or duplicated reused device"
+	expected=0
+	[ "$mode" != on ] || expected=1
+	[ "$(cat "/sys/class/block/${DEVICE##*/}/loop/dio")" = "$expected" ] ||
+		ts_die "Reuse changed direct I/O mode"
+	ts_cleanup_on_exit
+	ts_log "reuse and failed mount ($mode): OK"
+done
+
+ts_finalize
-- 
2.55.0


