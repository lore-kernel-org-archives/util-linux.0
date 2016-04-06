Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:54170 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916AbcDFKaW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 06:30:22 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0M0y47-1bgH3M22r1-00v7xA for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 12:30:19 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] tests: don't depend on GNU md5sum
Date: Wed,  6 Apr 2016 12:30:18 +0200
Message-Id: <1459938618-20153-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de>
References: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 .travis-functions.sh            | 2 +-
 tests/expected/misc/rev         | 4 ++--
 tests/functions.sh              | 2 +-
 tests/ts/cramfs/fsck-endianness | 3 ++-
 tests/ts/cramfs/mkfs            | 3 ++-
 tests/ts/fdisk/mbr-dos-mode     | 1 +
 tests/ts/fdisk/mbr-nondos-mode  | 1 +
 tests/ts/fdisk/oddinput         | 1 +
 tests/ts/fdisk/sunlabel         | 1 +
 tests/ts/misc/rev               | 5 +++--
 tests/ts/mount/rlimit           | 3 ++-
 tests/ts/sfdisk/movedata        | 5 +++--
 12 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/.travis-functions.sh b/.travis-functions.sh
index fb58df2..2b369f1 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -129,7 +129,7 @@ function osx_prepare_check
 
 	# symlink minimally needed gnu commands into PATH
 	mkdir ~/bin
-	for cmd in md5sum readlink seq truncate find xargs tar sed; do
+	for cmd in readlink seq truncate find xargs tar sed; do
 		ln -s /usr/local/bin/g$cmd $HOME/bin/$cmd
 	done
 	hash -r
diff --git a/tests/expected/misc/rev b/tests/expected/misc/rev
index 41fdf4c..6387476 100644
--- a/tests/expected/misc/rev
+++ b/tests/expected/misc/rev
@@ -1,4 +1,4 @@
-53bbf0d98205319cee2ba589e205c68b  -
-35484965b7a2fd45a471c0d80cb9752c  -
+53bbf0d98205319cee2ba589e205c68b
+35484965b7a2fd45a471c0d80cb9752c
 cba
 321
\ No newline at end of file
diff --git a/tests/functions.sh b/tests/functions.sh
index 5246605..fe7ce6d 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -460,7 +460,7 @@ function ts_cleanup_on_exit {
 
 function ts_image_md5sum {
 	local img=${1:-"$TS_OUTDIR/${TS_TESTNAME}.img"}
-	echo $(md5sum "$img" | awk '{printf $1}') $(basename "$img")
+	echo $("$TS_HELPER_MD5" < "$img") $(basename "$img")
 }
 
 function ts_image_init {
diff --git a/tests/ts/cramfs/fsck-endianness b/tests/ts/cramfs/fsck-endianness
index d6d2ae3..db287f9 100755
--- a/tests/ts/cramfs/fsck-endianness
+++ b/tests/ts/cramfs/fsck-endianness
@@ -23,6 +23,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_MKCRAMFS"
 ts_check_test_command "$TS_CMD_FSCKCRAMFS"
+ts_check_test_command "$TS_HELPER_MD5"
 
 ts_skip_nonroot
 
@@ -45,7 +46,7 @@ test_image() {
 	$TS_CMD_MKCRAMFS -N "$TO_ENDIANNESS" -b 4096 "$IMAGE_DATA" \
 		"$IMAGE_CREATED" >> $TS_OUTPUT 2>&1
 
-	md5sum $IMAGE_CREATED | cut -d" " -f1 >> $TS_OUTPUT
+	"$TS_HELPER_MD5" < "$IMAGE_CREATED" >> $TS_OUTPUT
 
 	rm "$IMAGE_CREATED"
 }
diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index cf6bcd6..d24b418 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -24,6 +24,7 @@ ts_init "$*"
 ts_check_test_command "$TS_CMD_MKCRAMFS"
 ts_check_test_command "$TS_CMD_MOUNT"
 ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_HELPER_MD5"
 
 ts_skip_nonroot
 ts_check_losetup
@@ -75,7 +76,7 @@ $TS_CMD_MKCRAMFS -n $LABEL $IMAGE_SRC $IMAGE_PATH >> $TS_OUTPUT 2>&1
 ts_cd "$TS_OUTDIR"
 
 ts_log "count MD5 from the image"
-MD5_OUT=$(md5sum "$IMAGE_NAME" | awk '{printf $1}') >> $TS_OUTPUT 2>&1
+MD5_OUT=$("$TS_HELPER_MD5" < "$IMAGE_NAME") >> $TS_OUTPUT 2>&1
 if [ "$MD5_EXP" != "$MD5_OUT" -a "$MD5_EXP" != "unknown" ]; then
 	ts_log "is $MD5_OUT, should be $MD5_EXP"
 fi
diff --git a/tests/ts/fdisk/mbr-dos-mode b/tests/ts/fdisk/mbr-dos-mode
index 4fad8da..219df2f 100755
--- a/tests/ts/fdisk/mbr-dos-mode
+++ b/tests/ts/fdisk/mbr-dos-mode
@@ -23,6 +23,7 @@ TS_DESC="MBR - dos mode"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_HELPER_MD5"
 
 FDISK_CMD_INIT="x\ni\n0x1\nr\n"
 FDISK_CMD_WRITE_CLOSE="w\nq\n"
diff --git a/tests/ts/fdisk/mbr-nondos-mode b/tests/ts/fdisk/mbr-nondos-mode
index f39b5e0..e01b060 100755
--- a/tests/ts/fdisk/mbr-nondos-mode
+++ b/tests/ts/fdisk/mbr-nondos-mode
@@ -21,6 +21,7 @@ TS_DESC="MBR - non-dos mode"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_HELPER_MD5"
 
 # cmd to changes system id to 0x1
 FDISK_CMD_INIT="x\ni\n0x1\nr\n"
diff --git a/tests/ts/fdisk/oddinput b/tests/ts/fdisk/oddinput
index 6625d25..0679242 100755
--- a/tests/ts/fdisk/oddinput
+++ b/tests/ts/fdisk/oddinput
@@ -21,6 +21,7 @@ TS_DESC="invalid input tests"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_HELPER_MD5"
 
 #set -x
 
diff --git a/tests/ts/fdisk/sunlabel b/tests/ts/fdisk/sunlabel
index 5bfbb4f..d6b1033 100755
--- a/tests/ts/fdisk/sunlabel
+++ b/tests/ts/fdisk/sunlabel
@@ -21,6 +21,7 @@ TS_DESC="sunlabel tests"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_HELPER_MD5"
 
 FDISK_CMD_INIT="s\n" # create new sunlabel
 FDISK_CMD_WRITE_CLOSE="w\nq\n"
diff --git a/tests/ts/misc/rev b/tests/ts/misc/rev
index a3d45e6..3a541ac 100755
--- a/tests/ts/misc/rev
+++ b/tests/ts/misc/rev
@@ -19,11 +19,12 @@ TS_DESC="rev"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_REV"
+ts_check_test_command "$TS_HELPER_MD5"
 
-for I in {0..512}; do printf "%s " {a..z}; done | md5sum >> $TS_OUTPUT 2>&1
+for I in {0..512}; do printf "%s " {a..z}; done | "$TS_HELPER_MD5" >> $TS_OUTPUT 2>&1
 
 for I in {0..512}; do printf "%s " {a..z}; done | \
-				    $TS_CMD_REV | md5sum >> $TS_OUTPUT 2>&1
+				    $TS_CMD_REV | "$TS_HELPER_MD5" >> $TS_OUTPUT 2>&1
 
 printf "abc\n123" | $TS_CMD_REV >> $TS_OUTPUT 2>&1
 
diff --git a/tests/ts/mount/rlimit b/tests/ts/mount/rlimit
index 8469084..d6a64ec 100755
--- a/tests/ts/mount/rlimit
+++ b/tests/ts/mount/rlimit
@@ -31,6 +31,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_MOUNT"
 ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_HELPER_MD5"
 
 ts_skip_nonroot
 ts_check_losetup
@@ -41,7 +42,7 @@ ts_check_prog "mkfs.ext3"
 
 function mtab_checksum()
 {
-	md5sum /etc/mtab | awk '{printf $1}'
+	"$TS_HELPER_MD5" < /etc/mtab
 }
 
 ts_device_init
diff --git a/tests/ts/sfdisk/movedata b/tests/ts/sfdisk/movedata
index d37f72a..64c7371 100755
--- a/tests/ts/sfdisk/movedata
+++ b/tests/ts/sfdisk/movedata
@@ -22,6 +22,7 @@ TS_DESC="movedata"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_SFDISK"
+ts_check_test_command "$TS_HELPER_MD5"
 
 ts_skip_nonroot
 ts_check_prog "mkfs.ext4"
@@ -35,11 +36,11 @@ udevadm settle
 
 mkfs.ext4 ${TS_DEVICE}1 &> /dev/null
 udevadm settle
-CHECKSUM=$(md5sum ${TS_DEVICE}1 | awk '{print $1}')
+CHECKSUM=$("$TS_HELPER_MD5" < "${TS_DEVICE}1")
 
 function checksum() {
 	local dev="$1"
-	CHECK=$(md5sum ${dev} | awk '{print $1}')
+	CHECK=$("$TS_HELPER_MD5" < "${dev}")
 	if [ "$CHECKSUM" != "$CHECK" ]; then
 		echo "Checksum does not match!" >> $TS_OUTPUT
 	fi
-- 
1.8.4.5

