Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 35/49] tests: cleanup islocal test
Date: Mon, 17 Oct 2011 13:15:14 +0200
Message-Id: <1318850128-23458-36-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/.gitignore  |    2 +-
 login-utils/Makefile.am |    7 +++----
 login-utils/islocal.c   |    6 +++---
 tests/commands.sh.in    |    3 ++-
 tests/ts/login/islocal  |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/login-utils/.gitignore b/login-utils/.gitignore
index 31af9d4..17b6f09 100644
--- a/login-utils/.gitignore
+++ b/login-utils/.gitignore
@@ -1,4 +1,4 @@
-islocal_test
+test_islocal
 chfn
 chsh
 login
diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index a07279e..a5909a6 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -65,7 +65,6 @@ install-exec-hook::
 
 endif
 
-noinst_PROGRAMS = islocal_test
-islocal_test_SOURCES = islocal.c
-islocal_test_CPPFLAGS = -DMAIN_TEST_ISLOCAL $(AM_CPPFLAGS)
-
+noinst_PROGRAMS = test_islocal
+test_islocal_SOURCES = islocal.c
+test_islocal_CPPFLAGS = -DTEST_PROGRAM $(AM_CPPFLAGS)
diff --git a/login-utils/islocal.c b/login-utils/islocal.c
index 39a74c6..e0a3d76 100644
--- a/login-utils/islocal.c
+++ b/login-utils/islocal.c
@@ -92,12 +92,12 @@ is_local(const char *user)
 	}
 }
 
-#if MAIN_TEST_ISLOCAL
+#ifdef TEST_PROGRAM
 int
 main (int argc, char *argv[])
 {
-	if (argc < 2) {
-		fprintf(stderr, "No test passwd file was specified.\n");
+	if (argc <= 2) {
+		fprintf(stderr, "usage: %s <passwdfile> <username> [...]\n", argv[0]);
 		return 1;
 	} else {
 		int i;
diff --git a/tests/commands.sh.in b/tests/commands.sh.in
index 462a4f5..63c146f 100644
--- a/tests/commands.sh.in
+++ b/tests/commands.sh.in
@@ -24,6 +24,8 @@ TS_HELPER_LIBMOUNT_UPDATE="$top_builddir/libmount/src/test_tab_update"
 TS_HELPER_LIBMOUNT_CONTEXT="$top_builddir/libmount/src/test_context"
 TS_HELPER_LIBMOUNT_TABDIFF="$top_builddir/libmount/src/test_tab_diff"
 
+TS_HELPER_ISLOCAL="$top_builddir/login-utils/test_islocal"
+
 # TODO: use partx
 TS_HELPER_PARTITIONS="$top_builddir/libblkid/samples/partitions"
 
@@ -55,7 +57,6 @@ TS_CMD_LOOK=${TS_CMD_LOOK-"$top_builddir/misc-utils/look"}
 TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/misc-utils/cal"}
 TS_CMD_SCRIPT=${TS_CMD_SCRIPT-"$top_builddir/term-utils/script"}
 
-TS_CMD_ISLOCAL=${TS_CMD_ISLOCAL-"$top_builddir/login-utils/islocal_test"}
 
 TS_CMD_HWCLOCK=${TS_CMD_HWCLOCK-"$top_builddir/hwclock/hwclock"}
 TS_CMD_LSCPU=${TS_CMD_LSCPU-"$top_builddir/sys-utils/lscpu"}
diff --git a/tests/ts/login/islocal b/tests/ts/login/islocal
index ba23857..c25da6a 100755
--- a/tests/ts/login/islocal
+++ b/tests/ts/login/islocal
@@ -21,7 +21,7 @@ TS_DESC="islocal"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-$TS_CMD_ISLOCAL "$TS_SELF/islocal.data" root nobody "" youngman youngman2 \
+$TS_HELPER_ISLOCAL "$TS_SELF/islocal.data" root nobody "" youngman youngman2 \
     abcdefghx nobo long rot al malformed \
     nonl znobody >> $TS_OUTPUT
 ts_finalize
-- 
1.7.6.4
