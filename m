Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:42972 "EHLO
	homiemail-a60.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757521Ab2FQQKS (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 17 Jun 2012 12:10:18 -0400
Subject: [PATCH 4/9] fdisk: tests: update oddinput test
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:10:11 +0200
Message-ID: <1339949411.2668.16.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Adding mbr to the API breaks this test, specifically when reading the first 512 bytes
of the MBR, update the expected output for oddinput.toosmall. Also let the test create
and remove the test file instead of having it in the expected directory.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 tests/expected/fdisk/oddinput |    1 +
 tests/ts/fdisk/oddinput       |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
index c812caa..d90866b 100644
--- a/tests/expected/fdisk/oddinput
+++ b/tests/expected/fdisk/oddinput
@@ -11,3 +11,4 @@ I/O size (minimum/optimal): 512 bytes / 512 bytes
 Nonexistant file
 lt-fdisk: unable to open _a_file_that_does_not_exist_: No such file or directory
 Too small file
+lt-fdisk: unable to open oddinput.toosmall: Success
diff --git a/tests/ts/fdisk/oddinput b/tests/ts/fdisk/oddinput
index f250c91..799eca0 100755
--- a/tests/ts/fdisk/oddinput
+++ b/tests/ts/fdisk/oddinput
@@ -34,6 +34,7 @@ ts_log "Nonexistant file" # this originally does absolutely nothing
 $TS_CMD_FDISK -c=dos -u=cylinders -l _a_file_that_does_not_exist_ >> $TS_OUTPUT 2>&1
 
 ts_log "Too small file" # same here
-$TS_CMD_FDISK -c=dos -u=cylinders -l $TS_TOPDIR/expected/fdisk/oddinput.toosmall >> $TS_OUTPUT 2>&1
-
+echo  "This file is too small" >> oddinput.toosmall
+$TS_CMD_FDISK -c=dos -u=cylinders -l oddinput.toosmall >> $TS_OUTPUT 2>&1
+rm oddinput.toosmall
 ts_finalize
-- 
1.7.4.1




