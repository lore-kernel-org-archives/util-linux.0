Return-Path: samuel.thibault@ens-lyon.org
Date: Wed, 8 Aug 2012 17:19:43 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] Fix non-Linux build
Message-ID: <20120808151943.GR10080@type.famille.thibault.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <util-linux.vger.kernel.org>

loopdev.c, test_pager, and get_max_number_of_cpus() are linux-specific.
get_linux_version will only work on Linux, let's introduce
system_supports_ext4_ext2() which assumes that mounting ext2 with ext4
is not supported on non-Linux systems.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 6a6e9b2..78f6fe4 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -10,7 +10,6 @@ libcommon_la_SOURCES = \
 	lib/env.c \
 	lib/fileutils.c \
 	lib/ismounted.c \
-	lib/loopdev.c \
 	lib/mangle.c \
 	lib/match.c \
 	lib/mbsalign.c \
@@ -27,7 +26,9 @@ libcommon_la_SOURCES = \
 	lib/xgetpass.c
 
 if LINUX
-libcommon_la_SOURCES += lib/linux_version.c
+libcommon_la_SOURCES +=
+	lib/linux_version.c \
+	lib/loopdev.c
 endif
 
 if !HAVE_LANGINFO
@@ -41,7 +42,6 @@ check_PROGRAMS += \
 	test_fileutils \
 	test_ismounted \
 	test_mangle \
-	test_pager \
 	test_procutils \
 	test_randutils \
 	test_strutils \
@@ -54,7 +54,8 @@ check_PROGRAMS += test_cpuset
 endif
 check_PROGRAMS += \
 	test_sysfs \
-	test_loopdev
+	test_loopdev \
+	test_pager
 endif
 
 test_blkdev_SOURCES = lib/blkdev.c
diff --git a/lib/cpuset.c b/lib/cpuset.c
index 78efd53..cb4315a 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -54,6 +54,7 @@ static const char *nexttoken(const char *q,  int sep)
 	return q;
 }
 
+#ifdef __linux__
 /*
  * Number of bits in a CPU bitmask on current system
  */
@@ -85,6 +86,7 @@ int get_max_number_of_cpus(void)
 	}
 	return -1;
 }
+#endif
 
 /*
  * Allocates a new set for ncpus and returns size in bytes and size in bits
diff --git a/libblkid/src/superblocks/ext.c b/libblkid/src/superblocks/ext.c
index 4066347..eff96a0 100644
--- a/libblkid/src/superblocks/ext.c
+++ b/libblkid/src/superblocks/ext.c
@@ -257,6 +257,15 @@ static int system_supports_ext4dev(void)
 	ret = (fs_proc_check("ext4dev") || check_for_modules("ext4dev"));
 	return ret;
 }
+
+static int system_supports_ext4_ext2(void)
+{
+#ifdef __linux__
+	return get_linux_version() >= EXT4_SUPPORTS_EXT2;
+#else
+	return 0;
+#endif
+}
 /*
  * reads superblock and returns:
  *	fc = feature_compat
@@ -352,7 +361,7 @@ static int probe_ext2(blkid_probe pr,
 	 */
 	if (!system_supports_ext2() &&
 	    (system_supports_ext4() || system_supports_ext4dev()) &&
-	    get_linux_version() >= EXT4_SUPPORTS_EXT2)
+	    system_supports_ext4_ext2())
 		return -BLKID_ERR_PARAM;
 
 	ext_get_info(pr, 2, es);
@@ -405,7 +414,7 @@ static int probe_ext4dev(blkid_probe pr,
 	if (!(fc & EXT3_FEATURE_COMPAT_HAS_JOURNAL) &&
 	    !system_supports_ext2() && !system_supports_ext4() &&
 	    system_supports_ext4dev() &&
-	    get_linux_version() >= EXT4_SUPPORTS_EXT2)
+	    system_supports_ext4_ext2())
 		goto force_ext4dev;
 
 	/*
@@ -450,7 +459,7 @@ static int probe_ext4(blkid_probe pr,
 	 */
 	if (!(fc & EXT3_FEATURE_COMPAT_HAS_JOURNAL) &&
 	    !system_supports_ext2() && system_supports_ext4() &&
-	    get_linux_version() >= EXT4_SUPPORTS_EXT2)
+	    system_supports_ext4_ext2())
 		goto force_ext4;
 
 	/* Ext4 has at least one feature which ext3 doesn't understand */
