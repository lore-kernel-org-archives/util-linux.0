Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35212 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbbCVXFj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Mar 2015 19:05:39 -0400
Received: by wgdm6 with SMTP id m6so132623237wgd.2
        for <util-linux@vger.kernel.org>; Sun, 22 Mar 2015 16:05:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/5] tests: add test_dmesg that has fixed boot time
Date: Sun, 22 Mar 2015 23:05:28 +0000
Message-Id: <1427065530-10695-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
References: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows testing time stamp formats.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/Makemodule.am       |  4 ++++
 sys-utils/dmesg.c             |  5 +++++
 tests/commands.sh             |  2 +-
 tests/ts/dmesg/console-levels |  4 ++--
 tests/ts/dmesg/decode         |  4 ++--
 tests/ts/dmesg/delta          |  4 ++--
 tests/ts/dmesg/facilities     |  4 ++--
 tests/ts/dmesg/indentation    | 10 +++++-----
 8 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index c1d587a..3177e7c 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -75,6 +75,10 @@ dist_man_MANS += sys-utils/dmesg.1
 dmesg_SOURCES = sys-utils/dmesg.c lib/monotonic.c
 dmesg_LDADD = $(LDADD) libcommon.la libtcolors.la $(REALTIME_LIBS)
 dmesg_CFLAGS = $(AM_CFLAGS)
+check_PROGRAMS += test_dmesg
+test_dmesg_SOURCES = $(dmesg_SOURCES)
+test_dmesg_LDADD = $(dmesg_LDADD)
+test_dmesg_CFLAGS = -DTEST_DMESG $(dmesg_CFLAGS)
 endif
 
 if BUILD_CTRLALTDEL
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index b56199f..a17cc70 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1378,8 +1378,13 @@ int main(int argc, char *argv[])
 	    is_timefmt(&ctl, CTIME) ||
 	    is_timefmt(&ctl, ISO8601)) {
 
+#ifdef TEST_DMESG
+		ctl.boot_time.tv_sec = 1234567890;
+		ctl.boot_time.tv_usec = 123456;
+#else
 		if (get_boot_time(&ctl.boot_time) != 0)
 			ctl.time_fmt = DMESG_TIMEFTM_NONE;
+#endif
 	}
 
 	if (delta)
diff --git a/tests/commands.sh b/tests/commands.sh
index 420feb9..e3ac433 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -4,6 +4,7 @@ TS_TESTUSER=${TS_TESTUSER:-"nobody"}
 # helpers
 TS_HELPER_BYTESWAP="$top_builddir/test_byteswap"
 TS_HELPER_CPUSET="$top_builddir/test_cpuset"
+TS_HELPER_DMESG="$top_builddir/test_dmesg"
 TS_HELPER_ISLOCAL="$top_builddir/test_islocal"
 TS_HELPER_ISMOUNTED="$top_builddir/test_ismounted"
 TS_HELPER_LIBMOUNT_CONTEXT="$top_builddir/test_mount_context"
@@ -36,7 +37,6 @@ TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/cal"}
 TS_CMD_COLRM=${TS_CMD_COLRM:-"$top_builddir/colrm"}
 TS_CMD_COL=${TS_CMD_COL:-"$top_builddir/col"}
 TS_CMD_COLUMN=${TS_CMD_COLUMN:-"$top_builddir/column"}
-TS_CMD_DMESG=${TS_CMD_DMESG-"$top_builddir/dmesg"}
 TS_CMD_EJECT=${TS_CMD_EJECT-"$top_builddir/eject"}
 TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
 TS_CMD_FDISK=${TS_CMD_FDISK-"$top_builddir/fdisk"}
diff --git a/tests/ts/dmesg/console-levels b/tests/ts/dmesg/console-levels
index 14c69c9..9abd5b2 100755
--- a/tests/ts/dmesg/console-levels
+++ b/tests/ts/dmesg/console-levels
@@ -18,10 +18,10 @@ TS_DESC="levels"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-ts_check_test_command "$TS_CMD_DMESG"
+ts_check_test_command "$TS_HELPER_DMESG"
 
 for I in {-1..8}; do
-	$TS_CMD_DMESG -F $TS_SELF/input -l $I >> $TS_OUTPUT 2>/dev/null
+	$TS_HELPER_DMESG -F $TS_SELF/input -l $I >> $TS_OUTPUT 2>/dev/null
 done
 
 ts_finalize
diff --git a/tests/ts/dmesg/decode b/tests/ts/dmesg/decode
index 63f3c5c..4725208 100755
--- a/tests/ts/dmesg/decode
+++ b/tests/ts/dmesg/decode
@@ -18,8 +18,8 @@ TS_DESC="decode"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-ts_check_test_command "$TS_CMD_DMESG"
+ts_check_test_command "$TS_HELPER_DMESG"
 
-$TS_CMD_DMESG -x -F $TS_SELF/input >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -x -F $TS_SELF/input >> $TS_OUTPUT 2>/dev/null
 
 ts_finalize
diff --git a/tests/ts/dmesg/delta b/tests/ts/dmesg/delta
index da48042..4b55bf6 100755
--- a/tests/ts/dmesg/delta
+++ b/tests/ts/dmesg/delta
@@ -18,8 +18,8 @@ TS_DESC="delta"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-ts_check_test_command "$TS_CMD_DMESG"
+ts_check_test_command "$TS_HELPER_DMESG"
 
-$TS_CMD_DMESG -d -F $TS_SELF/input >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -d -F $TS_SELF/input >> $TS_OUTPUT 2>/dev/null
 
 ts_finalize
diff --git a/tests/ts/dmesg/facilities b/tests/ts/dmesg/facilities
index 7066ae5..bc44c25 100755
--- a/tests/ts/dmesg/facilities
+++ b/tests/ts/dmesg/facilities
@@ -18,10 +18,10 @@ TS_DESC="facilities"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-ts_check_test_command "$TS_CMD_DMESG"
+ts_check_test_command "$TS_HELPER_DMESG"
 
 for I in {-1..12}; do
-	$TS_CMD_DMESG -F $TS_SELF/input -f $I >> $TS_OUTPUT 2>/dev/null
+	$TS_HELPER_DMESG -F $TS_SELF/input -f $I >> $TS_OUTPUT 2>/dev/null
 done
 
 ts_finalize
diff --git a/tests/ts/dmesg/indentation b/tests/ts/dmesg/indentation
index 7419888..624dd9b 100755
--- a/tests/ts/dmesg/indentation
+++ b/tests/ts/dmesg/indentation
@@ -18,14 +18,14 @@ TS_DESC="indentation"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-ts_check_test_command "$TS_CMD_DMESG"
+ts_check_test_command "$TS_HELPER_DMESG"
 
-$TS_CMD_DMESG -F $TS_SELF/newlines > $TS_OUTPUT 2>&1
+$TS_HELPER_DMESG -F $TS_SELF/newlines > $TS_OUTPUT 2>&1
 
-$TS_CMD_DMESG -F $TS_SELF/newlines -x >> $TS_OUTPUT 2>&1
+$TS_HELPER_DMESG -F $TS_SELF/newlines -x >> $TS_OUTPUT 2>&1
 
-$TS_CMD_DMESG --time-format=delta --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
+$TS_HELPER_DMESG --time-format=delta --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
 
-$TS_CMD_DMESG --time-format=notime --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
+$TS_HELPER_DMESG --time-format=notime --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
 
 ts_finalize
-- 
2.3.3

