Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56520 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933254AbbA1U3t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 Jan 2015 15:29:49 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: test fdisk/bsd on exotic archs
Date: Wed, 28 Jan 2015 11:45:20 +0100
Cc: Aurelien Jarno <aurelien@aurel32.net>,
        Andreas Henriksson <andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201501281145.21775.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

the fdisk/bsd test fails on ppc64le:
 Create default BSD
-2e1cee529cb59c9341afef0443f196a1 bsd.img
+6d760d7a8ef33b27cc6e27f1e8807d48 bsd.img
[...]

Actually Aurelien's patch a80886e9 should already address this because
it's the case little endian, BSD_LABELSECTOR = 0, BSD_LABELOFFSET = 64.

Aurelien or Andreas, do you still have such a system for this case? I
guess it was little endian alpha. Maybe you could send us the hexdump
output when running the test with the following debug patch (current
HEAD master):

diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -115,6 +115,8 @@ ts_log "Create default BSD"
 echo -e "${FDISK_CMD_BSD_CREATE}${FDISK_CMD_WRITE_CLOSE}" | \
 	$TS_CMD_FDISK ${TEST_IMAGE_NAME} &> /dev/null
 ts_image_md5sum >> $TS_OUTPUT 2>&1
+echo -e "\nhexdump default BSD"
+$TS_CMD_HEXDUMP -C ${TEST_IMAGE_NAME}
 
 print_bsd_layout
 
-- 


My ppc64le hexdump output looks like this one below. It seems to be ok
I think. It's the same like x86 except other offsets. But md5sum is
6d760d7a8ef33b27cc6e27f1e8807d48:

hexdump default BSD
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000001b0  00 00 00 00 00 00 00 00  01 00 00 00 00 00 00 20  |............... |
000001c0  21 00 83 41 01 00 00 08  00 00 00 08 00 00 00 04  |!..A............|
000001d0  01 3e a5 13 41 36 00 10  00 00 00 40 00 00 00 00  |.>..A6.....@....|
000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
00000200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00200040  57 45 56 82 06 00 00 00  00 00 00 00 00 00 00 00  |WEV.............|
00200050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00200060  00 00 00 00 00 00 00 00  00 02 00 00 3f 00 00 00  |............?...|
00200070  ff 00 00 00 01 00 00 00  c1 3e 00 00 c1 3e 00 00  |.........>...>..|
00200080  00 00 00 00 00 00 00 00  10 0e 01 00 00 00 00 00  |................|
00200090  00 00 00 00 00 00 00 00  20 00 00 00 00 00 00 00  |........ .......|
002000a0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
002000c0  00 00 00 00 57 45 56 82  33 62 04 00 00 20 00 00  |....WEV.3b... ..|
002000d0  00 20 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |. ..............|
002000e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
002000f0  00 00 00 00 00 40 00 00  00 10 00 00 00 00 00 00  |.....@..........|
00200100  00 00 00 00 c1 3e 00 00  00 00 00 00 00 00 00 00  |.....>..........|
00200110  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00a00000

cu,
Rudi
