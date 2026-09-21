Received: from out-2z4y-a165.jellyfish.systems (out-2z4y-a165.jellyfish.systems [198.54.127.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF043F4CF
	for <util-linux@vger.kernel.org>; Mon, 21 Sep 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976534; cv=none; b=F/F12ECywRRtias22wpD/0tohSMNcMcBBMgqnaJV97/l7Wizsbkxz2YTSSwGO905ZSF9PotQgePRZ/VBQu84WezH40lpILGFc8ovSEzZAqD410cnen49IUlMmd0zrykbMH/6m3wQsdrFKtvOWQFWSz0Imp8c+bbaK3pvvsQ5VDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976534; c=relaxed/simple;
	bh=XzJ8iF8t3MCf0L/uTfO4N3YRLx1M5v7vCLlsURNC6YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJBCHceeZAjQB54oXRt3cGAX1VsbTmDX5XR757eYRLFgm/zuZm3dqnst5W+7vPD0M70jPH5PJF/K1Xqa5e1wDrKg4t39yeDeAufsYjsSihRXffmgqOxG4PXdK7DFqv53PKYCBT/8J+CH+tU/j6GtVIxrsatso6Tk3NrwCuOJ3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=gvL/LLoJ; arc=none smtp.client-ip=198.54.127.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="gvL/LLoJ"
Received: from fedora (unknown [117.136.111.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hpFQw2HLqz2x9p;
	Mon, 21 Sep 2026 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789976187;
	bh=jPZDEDV7EteeQzFsXgsAhvavlk6sVjP96keihRbst8E=;
	h=From:To:Cc:Subject:Date:From;
	b=gvL/LLoJTsPRH/+D1kyVMAP2BUPIdBQL646BIeplDP1v7OvjVLm3G6qwCWAWNL3bg
	 NOpyrCE3t4Hc2CveLkcG4tmNmQxEV0uapXwFlV/URj7N+Eo28CA+Cf7t3+YIrXxEN5
	 uIEG2fjDUj7lj3rKBxuJPvmoGfTwlbRvQx8Bh7mhttC38hCPhuPjHTe5OhrnZiXe3f
	 kFG+1ig3AANWynQA3nYNYWUn0r4sEXfS4I1hU2akgyONc7F/e3MYzbHwp6BSrmgMiq
	 Ap+LJPixLEmZjh2Bi9uQy4UwGLCVBorMeOtpENVqWGbSW82HNXGJVuxepvQbB6KYq1
	 h4QiHXNba6jTQ==
From: Tianyi Chen <hi@tychen.cc>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH] libmount: support explicit loop direct I/O requests
Date: Mon, 21 Sep 2026 16:36:13 +0900
Message-ID: <20260921073613.99690-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Allow X-loopdev.direct-io=on|off to select the direct I/O mode when
mounting a file through a loop device. Pass the flag to the existing
loop setup path and require a matching mode when reusing a device.
Omitting the option preserves the current behavior.

Keep reused devices attached if the mount fails; only release the
reference acquired by this mount. Add tests for option parsing, new
devices, reuse, mode conflicts and failure cleanup.

Fixes: https://github.com/util-linux/util-linux/issues/3464
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
Following the RFC discussion, this uses loopcxt_setup_device() without
adding effective-mode readback for new devices:
https://lore.kernel.org/r/zxpnm3dbgy6vv64gockhcl5egfpe2qpld7jlkgg3enr5jbfha2@q27vjqxnocmb

Built with Meson. The new loop-direct-io test and existing regfile and
fstab-loop tests pass in an x86-64 VM with ext4 backing storage.

 libmount/src/hook_loopdev.c         | 27 ++++++++-
 sys-utils/mount.8.adoc              | 10 +++-
 tests/expected/mount/loop-direct-io |  6 ++
 tests/ts/mount/loop-direct-io       | 91 +++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 tests/expected/mount/loop-direct-io
 create mode 100755 tests/ts/mount/loop-direct-io

diff --git a/libmount/src/hook_loopdev.c b/libmount/src/hook_loopdev.c
index b2291340..cfd07fb1 100644
--- a/libmount/src/hook_loopdev.c
+++ b/libmount/src/hook_loopdev.c
@@ -21,6 +21,7 @@
 
 struct hook_data {
 	int loopdev_fd;
+	bool reused;
 };
 
 static int delete_loopdev(struct libmnt_context *cxt, struct hook_data *hd);
@@ -138,7 +139,7 @@ static int setup_loopdev(struct libmnt_context *cxt,
 {
 	const char *backing_file, *loopdev = NULL;
 	struct loopdev_cxt lc;
-	int rc = 0, lo_flags = 0;
+	int rc = 0, lo_flags = 0, direct_io = -1;
 	uint64_t offset = 0, sizelimit = 0;
 	bool reuse = FALSE;
 	struct libmnt_opt *opt, *loopopt = NULL;
@@ -154,6 +155,19 @@ static int setup_loopdev(struct libmnt_context *cxt,
 		lo_flags |= LO_FLAGS_READ_ONLY;
 	}
 
+	opt = mnt_optlist_get_named(ol, "X-loopdev.direct-io", cxt->map_userspace);
+	if (opt) {
+		const char *value = mnt_opt_get_value(opt);
+
+		if (value && strcmp(value, "on") == 0) {
+			direct_io = 1;
+			lo_flags |= LO_FLAGS_DIRECT_IO;
+		} else if (value && strcmp(value, "off") == 0)
+			direct_io = 0;
+		else
+			return -MNT_ERR_MOUNTOPT;
+	}
+
 	/*
 	 * loop=
 	 */
@@ -257,6 +271,13 @@ static int setup_loopdev(struct libmnt_context *cxt,
 				goto done;
 			}
 
+			if (direct_io != -1 && !!loopcxt_is_dio(&lc) != direct_io) {
+				DBG_OBJ(LOOP, cxt, ul_debug("%s has incompatible direct I/O mode",
+						loopcxt_get_device(&lc)));
+				rc = -MNT_ERR_LOOPOVERLAP;
+				goto done;
+			}
+
 			/* This is no more supported, but check to be safe. */
 			if (loopcxt_get_encrypt_type(&lc, &lc_encrypt_type) == 0
 			    && lc_encrypt_type != LO_CRYPT_NONE) {
@@ -350,6 +371,7 @@ static int setup_loopdev(struct libmnt_context *cxt,
 	} while (1);
 
 success:
+	hd->reused = reuse;
 	if (!rc)
 		rc = mnt_fs_set_source(cxt->fs, loopcxt_get_device(&lc));
 
@@ -408,6 +430,9 @@ static int delete_loopdev(struct libmnt_context *cxt, struct hook_data *hd)
 		hd->loopdev_fd = -1;
 	}
 
+	if (hd && hd->reused)
+		return 0;
+
 	rc = loopdev_detach(src);	/* see lib/loopdev.c */
 
 	DBG_OBJ(LOOP, cxt, ul_debug("deleted [rc=%d]", rc));
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 922ecda7..208a1a16 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -796,6 +796,14 @@ ____
 mount -t auto -o'X-mount.auto-fstypes="noext2,ext3"'  /dev/sdc1 /mnt/test
 ____
 
+*X-loopdev.direct-io*=*on*|*off*::
+Enable or disable direct I/O when setting up a loop device. If a loop device
+already exists for the same file, offset and size limit, its direct I/O mode
+must match; otherwise the mount fails without changing the existing device.
+Without this option, new loop devices use buffered I/O and existing devices
+can be reused in either mode. This option does not change an existing mount
+or apply when no loop device is needed. See also *losetup*(8) *--direct-io*.
+
 *X-mount.mkdir*[**=**_mode_]::
 Allow to make a target directory (mountpoint) if it does not exist yet. The optional argument _mode_ specifies the filesystem access mode used for *mkdir*(2) in octal notation. The default mode is 0755. This functionality is supported only for root users or when *mount* is executed without suid permissions. The option is also supported as *x-mount.mkdir*, but this notation is deprecated since v2.30. See also *--mkdir* command line option.
 
@@ -1708,7 +1716,7 @@ ____
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
index 00000000..4f30b2bc
--- /dev/null
+++ b/tests/ts/mount/loop-direct-io
@@ -0,0 +1,91 @@
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
+DEVICE=
+
+cleanup()
+{
+	local device
+
+	$TS_CMD_UMOUNT "$TS_MOUNTPOINT" &> /dev/null
+	for device in $($TS_CMD_LOSETUP -j "$IMAGE" | cut -d: -f1); do
+		$TS_CMD_LOSETUP -d "$device" &> /dev/null
+	done
+}
+trap cleanup EXIT
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
+[ "$(cat "/sys/class/block/${DEVICE##*/}/loop/dio")" = 1 ] ||
+	ts_skip "loop direct I/O not supported"
+$TS_CMD_LOSETUP -d "$DEVICE" || ts_die "Cannot detach probe device"
+DEVICE=
+
+for mode in on off default; do
+	options=loop
+	expected=0
+	[ "$mode" = default ] || options+=",X-loopdev.direct-io=$mode"
+	[ "$mode" != on ] || expected=1
+	$TS_CMD_MOUNT -o "$options" "$IMAGE" "$TS_MOUNTPOINT" >> "$TS_ERRLOG" 2>&1 ||
+		ts_die "Cannot mount with mode $mode"
+	DEVICE=$($TS_CMD_LOSETUP -j "$IMAGE" | cut -d: -f1)
+	[ "$(cat "/sys/class/block/${DEVICE##*/}/loop/dio")" = "$expected" ] ||
+		ts_die "Wrong direct I/O mode: $mode"
+	$TS_CMD_UMOUNT "$TS_MOUNTPOINT" || ts_die "Cannot unmount"
+	DEVICE=
+	$TS_CMD_MOUNT -t ext2 -o "$options,invalid-fs-option" "$IMAGE" "$TS_MOUNTPOINT" &> /dev/null &&
+		ts_die "Accepted invalid filesystem option on new device"
+	[ -z "$($TS_CMD_LOSETUP -j "$IMAGE")" ] || ts_die "Failed mount left a new loop device"
+	ts_log "new device ($mode): OK"
+done
+
+for mode in on off; do
+	DEVICE=$($TS_CMD_LOSETUP --direct-io="$mode" --find --show "$IMAGE") ||
+		ts_die "Cannot set up device"
+	for options in "loop,X-loopdev.direct-io=$mode" loop; do
+		$TS_CMD_MOUNT -o "$options" "$IMAGE" "$TS_MOUNTPOINT" >> "$TS_ERRLOG" 2>&1 ||
+			ts_die "Cannot reuse device: $options"
+		$TS_CMD_UMOUNT "$TS_MOUNTPOINT" || ts_die "Cannot unmount reused device"
+	done
+	other=on
+	[ "$mode" != on ] || other=off
+	$TS_CMD_MOUNT -o "X-loopdev.direct-io=$other" "$IMAGE" "$TS_MOUNTPOINT" &> /dev/null &&
+		ts_die "Reused device with incompatible direct I/O mode"
+	$TS_CMD_MOUNT -t ext2 -o "X-loopdev.direct-io=$mode,invalid-fs-option" \
+		"$IMAGE" "$TS_MOUNTPOINT" &> /dev/null &&
+		ts_die "Accepted invalid filesystem option"
+	[ "$($TS_CMD_LOSETUP -j "$IMAGE" | cut -d: -f1)" = "$DEVICE" ] ||
+		ts_die "Failed mount detached or duplicated reused device"
+	expected=0
+	[ "$mode" != on ] || expected=1
+	[ "$(cat "/sys/class/block/${DEVICE##*/}/loop/dio")" = "$expected" ] ||
+		ts_die "Reuse changed direct I/O mode"
+	$TS_CMD_LOSETUP -d "$DEVICE" || ts_die "Cannot detach reused device"
+	DEVICE=
+	ts_log "reuse and failed mount ($mode): OK"
+done
+
+ts_finalize

base-commit: 55e3c4dba6101a47ecaae71c91edbe10c59b8d56
-- 
2.55.0

