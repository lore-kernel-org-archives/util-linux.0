Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:65026 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M3S2C-1ZmTfJ1dk8-00r1UU for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:05 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/12] tests: cramfs, fix root group
Date: Tue,  8 Mar 2016 00:11:58 +0100
Message-Id: <1457392322-4974-9-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Sudo may login as group wheel or may use user's original group.
Note that group 0 is not named "root" on all Unix systems.

We have some more tests with similar issues but they are Linux-only
(losetup, scsi_debug). We don't fix them unless somebody complains.

BTW we use hexdump instead of md5sum.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/cramfs/mkfs-endianness | 80 ++++++++++++++++++++++++++++++++++-
 tests/ts/cramfs/mkfs                  | 19 ++++-----
 tests/ts/cramfs/mkfs-endianness       |  5 ++-
 3 files changed, 91 insertions(+), 13 deletions(-)

diff --git a/tests/expected/cramfs/mkfs-endianness b/tests/expected/cramfs/mkfs-endianness
index ef935a7..9cf394b 100644
--- a/tests/expected/cramfs/mkfs-endianness
+++ b/tests/expected/cramfs/mkfs-endianness
@@ -1,4 +1,80 @@
 create little endian
-4666f0d2b661f9f3962877edabadb210
+00000000  45 3d cd 28 00 10 00 00  03 00 00 00 00 00 00 00  |E=.(............|
+00000010  43 6f 6d 70 72 65 73 73  65 64 20 52 4f 4d 46 53  |Compressed ROMFS|
+00000020  9b d3 39 ca 00 00 00 00  05 00 00 00 05 00 00 00  |..9.............|
+00000030  43 6f 6d 70 72 65 73 73  65 64 00 00 00 00 00 00  |Compressed......|
+00000040  ed 41 00 00 10 00 00 00  c0 04 00 00 ed 41 00 00  |.A...........A..|
+00000050  10 00 00 00 c1 05 00 00  64 69 72 41 ed 41 00 00  |........dirA.A..|
+00000060  20 00 00 00 c1 06 00 00  64 69 72 42 a4 81 00 00  | .......dirB....|
+00000070  00 02 00 00 c1 08 00 00  61 00 00 00 a4 81 00 00  |........a.......|
+00000080  00 3c 00 00 c1 0c 00 00  62 00 00 00 cb 00 00 00  |.<......b.......|
+00000090  78 9c 0b 49 2d 2e c9 cc  4b 57 48 2e 4a cc 4d 2b  |x..I-...KWH.J.M+|
+000000a0  56 30 34 32 36 31 35 33  b7 b0 34 50 70 cd 4b c9  |V0426153..4Pp.K.|
+000000b0  4c cc cb 4b 2d 2e 56 48  ce 48 4d ce c6 27 c7 15  |L..K-.VH.HM..'..|
+000000c0  32 6a cc d0 34 06 00 37  c8 a2 81 00 33 01 00 00  |2j..4..7....3...|
+000000d0  8d 01 00 00 e7 01 00 00  38 02 00 00 78 9c ed cc  |........8...x...|
+000000e0  bb 0d 80 30 0c 40 c1 9e  29 3c 02 ff cf 00 6c 90  |...0.@..)<....l.|
+000000f0  05 22 27 40 84 70 81 d9  5f 6c 40 4d f1 ea 93 2e  |."'@.p.._l@M....|
+00000100  64 7f 8a ed a2 77 bc 36  97 a6 ed fa 61 9c e6 a5  |d....w.6....a...|
+00000110  96 d5 52 89 66 d9 5d f4  c8 7a 7e 59 15 68 68 68  |..R.f.]..z~Y.hhh|
+00000120  68 68 68 68 68 68 68 68  68 68 68 68 fe db bc 1f  |hhhhhhhhhhhh....|
+00000130  dd 0d 28 78 9c ed cc bb  0d 80 30 0c 00 d1 9e 29  |..(x......0....)|
+00000140  3c 02 ff c0 00 6c c0 02  51 30 10 21 5c 60 f6 17  |<....l..Q0.!\`..|
+00000150  0b 20 6a 8a ab ef f4 c2  30 96 32 d9 92 a3 99 ba  |. j.....0.2.....|
+00000160  4b da 35 1d c5 ac 7e 67  db 24 5d f1 5c 5d aa ba  |K.5...~g.$].\]..|
+00000170  69 bb 3e bc ad 5f 0d 06  06 06 06 06 06 06 06 06  |i.>.._..........|
+00000180  06 06 06 06 06 e6 1f cc  03 76 3d 0d 1a 78 9c ed  |.........v=..x..|
+00000190  cc bb 0d 80 30 0c 00 d1  9e 29 3c 02 ff cf 00 6c  |....0....)<....l|
+000001a0  c0 02 91 09 10 21 5c 60  f6 17 35 0d 75 8a ab ef  |.....!\`..5.u...|
+000001b0  f4 6c 4d c1 2c ba 8b 1e  51 4f a9 ea a6 ed fa 61  |.lM.,...QO.....a|
+000001c0  9c 4a 99 ed db 8a 25 fa  93 6c 17 bd c3 b5 f9 df  |.J....%..l......|
+000001d0  0a 03 03 03 03 03 03 03  03 03 03 03 03 03 03 93  |................|
+000001e0  13 f3 02 b1 b2 0e 4d 78  9c cb 4b 57 48 2e 4a cc  |......Mx..KWH.J.|
+000001f0  4d 2b 56 30 34 32 36 31  35 33 b7 b0 34 50 70 cd  |M+V0426153..4Pp.|
+00000200  4b c9 4c cc cb 4b 2d 2e  56 48 ce 48 4d ce c6 27  |K.L..K-.VH.HM..'|
+00000210  c7 15 92 5a 5c 92 99 37  6a cc a8 31 a3 c6 8c 1a  |...Z\..7j..1....|
+00000220  33 6a cc a8 31 a3 c6 8c  1a 33 6a cc a8 31 a3 c6  |3j..1....3j..1..|
+00000230  0c 7e 63 00 d1 5c c9 6a  00 00 00 00 00 00 00 00  |.~c..\.j........|
+00000240  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001000
 create big endian
-bc0b7bbef02765d32e07faa735d2e0c6
+00000000  28 cd 3d 45 00 00 10 00  00 00 00 03 00 00 00 00  |(.=E............|
+00000010  43 6f 6d 70 72 65 73 73  65 64 20 52 4f 4d 46 53  |Compressed ROMFS|
+00000020  d3 50 cc 02 00 00 00 00  00 00 00 05 00 00 00 05  |.P..............|
+00000030  43 6f 6d 70 72 65 73 73  65 64 00 00 00 00 00 00  |Compressed......|
+00000040  41 ed 00 00 00 00 10 00  00 00 00 13 41 ed 00 00  |A...........A...|
+00000050  00 00 10 00 04 00 00 17  64 69 72 41 41 ed 00 00  |........dirAA...|
+00000060  00 00 20 00 04 00 00 1b  64 69 72 42 81 a4 00 00  |.. .....dirB....|
+00000070  00 02 00 00 04 00 00 23  61 00 00 00 81 a4 00 00  |.......#a.......|
+00000080  00 3c 00 00 04 00 00 33  62 00 00 00 00 00 00 cb  |.<.....3b.......|
+00000090  78 9c 0b 49 2d 2e c9 cc  4b 57 48 2e 4a cc 4d 2b  |x..I-...KWH.J.M+|
+000000a0  56 30 34 32 36 31 35 33  b7 b0 34 50 70 cd 4b c9  |V0426153..4Pp.K.|
+000000b0  4c cc cb 4b 2d 2e 56 48  ce 48 4d ce c6 27 c7 15  |L..K-.VH.HM..'..|
+000000c0  32 6a cc d0 34 06 00 37  c8 a2 81 00 00 00 01 33  |2j..4..7.......3|
+000000d0  00 00 01 8d 00 00 01 e7  00 00 02 38 78 9c ed cc  |...........8x...|
+000000e0  bb 0d 80 30 0c 40 c1 9e  29 3c 02 ff cf 00 6c 90  |...0.@..)<....l.|
+000000f0  05 22 27 40 84 70 81 d9  5f 6c 40 4d f1 ea 93 2e  |."'@.p.._l@M....|
+00000100  64 7f 8a ed a2 77 bc 36  97 a6 ed fa 61 9c e6 a5  |d....w.6....a...|
+00000110  96 d5 52 89 66 d9 5d f4  c8 7a 7e 59 15 68 68 68  |..R.f.]..z~Y.hhh|
+00000120  68 68 68 68 68 68 68 68  68 68 68 68 fe db bc 1f  |hhhhhhhhhhhh....|
+00000130  dd 0d 28 78 9c ed cc bb  0d 80 30 0c 00 d1 9e 29  |..(x......0....)|
+00000140  3c 02 ff c0 00 6c c0 02  51 30 10 21 5c 60 f6 17  |<....l..Q0.!\`..|
+00000150  0b 20 6a 8a ab ef f4 c2  30 96 32 d9 92 a3 99 ba  |. j.....0.2.....|
+00000160  4b da 35 1d c5 ac 7e 67  db 24 5d f1 5c 5d aa ba  |K.5...~g.$].\]..|
+00000170  69 bb 3e bc ad 5f 0d 06  06 06 06 06 06 06 06 06  |i.>.._..........|
+00000180  06 06 06 06 06 e6 1f cc  03 76 3d 0d 1a 78 9c ed  |.........v=..x..|
+00000190  cc bb 0d 80 30 0c 00 d1  9e 29 3c 02 ff cf 00 6c  |....0....)<....l|
+000001a0  c0 02 91 09 10 21 5c 60  f6 17 35 0d 75 8a ab ef  |.....!\`..5.u...|
+000001b0  f4 6c 4d c1 2c ba 8b 1e  51 4f a9 ea a6 ed fa 61  |.lM.,...QO.....a|
+000001c0  9c 4a 99 ed db 8a 25 fa  93 6c 17 bd c3 b5 f9 df  |.J....%..l......|
+000001d0  0a 03 03 03 03 03 03 03  03 03 03 03 03 03 03 93  |................|
+000001e0  13 f3 02 b1 b2 0e 4d 78  9c cb 4b 57 48 2e 4a cc  |......Mx..KWH.J.|
+000001f0  4d 2b 56 30 34 32 36 31  35 33 b7 b0 34 50 70 cd  |M+V0426153..4Pp.|
+00000200  4b c9 4c cc cb 4b 2d 2e  56 48 ce 48 4d ce c6 27  |K.L..K-.VH.HM..'|
+00000210  c7 15 92 5a 5c 92 99 37  6a cc a8 31 a3 c6 8c 1a  |...Z\..7j..1....|
+00000220  33 6a cc a8 31 a3 c6 8c  1a 33 6a cc a8 31 a3 c6  |3j..1....3j..1..|
+00000230  0c 7e 63 00 d1 5c c9 6a  00 00 00 00 00 00 00 00  |.~c..\.j........|
+00000240  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001000
diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index 07f703f..cf6bcd6 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -51,17 +51,16 @@ ts_log "create mountpoint dir"
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
 ts_log "generate data"
-if [ ! -d "$IMAGE_SRC" ]; then
-	mkdir -p $IMAGE_SRC
-	for d in `seq 0 110`; do
-		DIRNAME="$IMAGE_SRC/$(printf "dir-%03d" $d)"
-		mkdir -p $DIRNAME
-		for f in `seq 0 10`; do
-			FILENAME="$DIRNAME/$(printf "data.%03d" $f)"
-			printf "data in %03d-%03d" $d $f >> $FILENAME
-		done
+rm -rf "$IMAGE_SRC"
+mkdir -p $IMAGE_SRC
+for d in `seq 0 110`; do
+	DIRNAME="$IMAGE_SRC/$(printf "dir-%03d" $d)"
+	mkdir -p $DIRNAME
+	for f in `seq 0 10`; do
+		FILENAME="$DIRNAME/$(printf "data.%03d" $f)"
+		printf "data in %03d-%03d" $d $f >> $FILENAME
 	done
-fi
+done
 
 ts_cd "$IMAGE_SRC"
 
diff --git a/tests/ts/cramfs/mkfs-endianness b/tests/ts/cramfs/mkfs-endianness
index e6707ca..c511086 100755
--- a/tests/ts/cramfs/mkfs-endianness
+++ b/tests/ts/cramfs/mkfs-endianness
@@ -22,6 +22,7 @@ TS_DESC="mkfs endianness"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_MKCRAMFS"
+ts_check_test_command "$TS_CMD_HEXDUMP"
 
 ts_skip_nonroot
 
@@ -35,7 +36,7 @@ test_image() {
 	$TS_CMD_MKCRAMFS -N "$TO_ENDIANNESS" -b 4096 "$IMAGE_DATA" \
 		"$IMAGE_CREATED" >> $TS_OUTPUT 2>&1
 
-	md5sum $IMAGE_CREATED | cut -d" " -f1 >> $TS_OUTPUT
+	$TS_CMD_HEXDUMP -C $IMAGE_CREATED >> $TS_OUTPUT
 
 	rm "$IMAGE_CREATED"
 }
@@ -47,6 +48,8 @@ yes "Testing cramfs 1234567890 Endianness check 1234567890 Endianness check" \
 	| dd of=$IMAGE_DATA/dirA/dirB/a bs=512 count=1 &> /dev/null
 yes "Testing cramfs 1234567890 Endianness check 1234567890 Endianness check" \
 	| dd of=$IMAGE_DATA/dirA/dirB/b bs=512 count=30 &> /dev/null
+# sudo may use whatever group
+chgrp -R 0 $IMAGE_DATA
 
 #perform tests for both endians
 test_image "little"
-- 
1.9.1

