Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35961 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdBJLGd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 10 Feb 2017 06:06:33 -0500
Received: by mail-lf0-f66.google.com with SMTP id h65so2624366lfi.3
        for <util-linux@vger.kernel.org>; Fri, 10 Feb 2017 03:05:15 -0800 (PST)
From: Yuri Chornoivan <yurchor@gmail.com>
To: util-linux@vger.kernel.org
Cc: Yuri Chornoivan <yurchor@gmail.com>
Subject: [PATCH] Fix word repetitions
Date: Fri, 10 Feb 2017 13:05:04 +0200
Message-Id: <1486724704-8127-1-git-send-email-yurchor@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 Documentation/howto-pull-request.txt | 2 +-
 disk-utils/partx.c                   | 2 +-
 lib/sysfs.c                          | 2 +-
 libmount/src/cache.c                 | 2 +-
 libmount/src/fs.c                    | 2 +-
 libmount/src/tab.c                   | 2 +-
 libsmartcols/samples/fromfile.c      | 2 +-
 login-utils/last.c                   | 2 +-
 misc-utils/blkid.c                   | 2 +-
 misc-utils/cal.c                     | 2 +-
 misc-utils/findmnt.c                 | 2 +-
 misc-utils/look.c                    | 2 +-
 misc-utils/lsblk.c                   | 2 +-
 misc-utils/test_uuidd.c              | 2 +-
 misc-utils/wipefs.c                  | 2 +-
 sys-utils/chcpu.c                    | 2 +-
 sys-utils/dmesg.c                    | 2 +-
 sys-utils/fallocate.c                | 2 +-
 sys-utils/fsfreeze.c                 | 2 +-
 sys-utils/hwclock.c                  | 4 ++--
 sys-utils/mount.c                    | 2 +-
 sys-utils/swapon.c                   | 2 +-
 sys-utils/umount.c                   | 2 +-
 sys-utils/wdctl.c                    | 2 +-
 term-utils/agetty.c                  | 2 +-
 25 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/howto-pull-request.txt b/Documentation/howto-pull-request.txt
index dfa3977..7cae722 100644
--- a/Documentation/howto-pull-request.txt
+++ b/Documentation/howto-pull-request.txt
@@ -29,7 +29,7 @@ Branches
 --------
 
 1. Use the name of the subsystem, such as blkid, libmount, misc-utils,
-that is the common thing for changes in in the change set.
+that is the common thing for changes in the change set.
 
 2. If the changes do not have anything in common use some random name,
 such as YYYY-MM-DD of the first patch in the branch.  Name of the branch
diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 46224a3..50f76b0 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -812,7 +812,7 @@ int main(int argc, char **argv)
 		{ NULL, 0, NULL, 0 }
 	};
 
-	static const ul_excl_t excl[] = {	/* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'P','a','d','l','r','s','u' },
 		{ 0 }
 	};
diff --git a/lib/sysfs.c b/lib/sysfs.c
index b52446c..085afd3 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -623,7 +623,7 @@ static char *get_subsystem(char *chain, char *buf, size_t bufsz)
 }
 
 /*
- * Returns complete path to the device, the patch contains all all subsystems
+ * Returns complete path to the device, the patch contains all subsystems
  * used for the device.
  */
 char *sysfs_get_devchain(struct sysfs_cxt *cxt, char *buf, size_t bufsz)
diff --git a/libmount/src/cache.c b/libmount/src/cache.c
index 04dcb7f..6ff9971 100644
--- a/libmount/src/cache.c
+++ b/libmount/src/cache.c
@@ -85,7 +85,7 @@ struct libmnt_cache *mnt_new_cache(void)
  * @cache: pointer to struct libmnt_cache instance
  *
  * Deallocates the cache. This function does not care about reference count. Don't
- * use this function directly -- it's better to use use mnt_unref_cache().
+ * use this function directly -- it's better to use mnt_unref_cache().
  */
 void mnt_free_cache(struct libmnt_cache *cache)
 {
diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index d143eb5..1c4ba1a 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -43,7 +43,7 @@ struct libmnt_fs *mnt_new_fs(void)
  * @fs: fs pointer
  *
  * Deallocates the fs. This function does not care about reference count. Don't
- * use this function directly -- it's better to use use mnt_unref_fs().
+ * use this function directly -- it's better to use mnt_unref_fs().
  *
  * The reference counting is supported since util-linux v2.24.
  */
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index f72dcf1..fa791c3 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -150,7 +150,7 @@ void mnt_unref_table(struct libmnt_table *tb)
  * @tb: tab pointer
  *
  * Deallocates the table. This function does not care about reference count. Don't
- * use this function directly -- it's better to use use mnt_unref_table().
+ * use this function directly -- it's better to use mnt_unref_table().
  *
  * The table entries (filesystems) are unreferenced by mnt_reset_table() and
  * cache by mnt_unref_cache().
diff --git a/libsmartcols/samples/fromfile.c b/libsmartcols/samples/fromfile.c
index fcf01c7..3918aad 100644
--- a/libsmartcols/samples/fromfile.c
+++ b/libsmartcols/samples/fromfile.c
@@ -236,7 +236,7 @@ int main(int argc, char *argv[])
 		{ NULL, 0, 0, 0 },
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'E', 'J', 'r' },
 		{ 0 }
 	};
diff --git a/login-utils/last.c b/login-utils/last.c
index 6d0e892..b130385 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -920,7 +920,7 @@ int main(int argc, char **argv)
 	      { "time-format", required_argument, NULL, OPT_TIME_FORMAT },
 	      { NULL, 0, NULL, 0 }
 	};
-	static const ul_excl_t excl[] = {	/* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'F', OPT_TIME_FORMAT },	/* fulltime, time-format */
 		{ 0 }
 	};
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 8e86200..b684a56 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -649,7 +649,7 @@ int main(int argc, char **argv)
 	int c;
 	uintmax_t offset = 0, size = 0;
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'n','u' },
 		{ 0 }
 	};
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 5e7b356..d3b9910 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -284,7 +284,7 @@ int main(int argc, char **argv)
 		{NULL, 0, NULL, 0}
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'Y','n','y' },
 		{ 0 }
 	};
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index ea4d23d..5fdae37 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1308,7 +1308,7 @@ int main(int argc, char *argv[])
 	    { NULL,           0, 0, 0 }
 	};
 
-	static const ul_excl_t excl[] = {	/* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'C', 'c'},                    /* [no]canonicalize */
 		{ 'C', 'e' },			/* nocanonicalize, evaluate */
 		{ 'J', 'P', 'r','x' },		/* json,pairs,raw,verify */
diff --git a/misc-utils/look.c b/misc-utils/look.c
index 93c388e..bb0d965 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -171,7 +171,7 @@ look(char *front, char *back)
 	int ch;
 	char *readp, *writep;
 
-	/* Reformat string string to avoid doing it multiple times later. */
+	/* Reformat string to avoid doing it multiple times later. */
 	if (dflag) {
 		for (readp = writep = string; (ch = *readp++) != 0;) {
 			if (isalnum(ch) || isblank(ch))
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 8e6e6c5..7aa9021 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1696,7 +1696,7 @@ int main(int argc, char *argv[])
 		{ NULL, 0, 0, 0 },
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'D','O' },
 		{ 'I','e' },
 		{ 'J', 'P', 'r' },
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index 4a2daf9..ba63c45 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -77,7 +77,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fprintf(out, "\n %s [options]\n", program_invocation_short_name);
 
-	fprintf(out, "  -p <num>     number of of nprocesses (default:%zu)\n", nprocesses);
+	fprintf(out, "  -p <num>     number of nprocesses (default:%zu)\n", nprocesses);
 	fprintf(out, "  -t <num>     number of nthreads (default:%zu)\n", nthreads);
 	fprintf(out, "  -o <num>     number of nobjects (default:%zu)\n", nobjects);
 	fprintf(out, "  -l <level>   log level (default:%zu)\n", loglev);
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 0021e76..fe5edfa 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -497,7 +497,7 @@ main(int argc, char **argv)
 	    { NULL,        0, 0, 0 }
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'a','o' },
 		{ 0 }
 	};
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index 50b834c..1079401 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -273,7 +273,7 @@ int main(int argc, char *argv[])
 		{ NULL,		0, 0, 0 }
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'c','d','e','g','p' },
 		{ 0 }
 	};
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 0056b25..2fd5a90 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1261,7 +1261,7 @@ int main(int argc, char *argv[])
 		{ NULL,	           0, NULL, 0 }
 	};
 
-	static const ul_excl_t excl[] = {	/* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'C','D','E','c','n','r' },	/* clear,off,on,read-clear,level,raw*/
 		{ 'H','r' },			/* human, raw */
 		{ 'L','r' },			/* color, raw */
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 4f2f74e..8df82f2 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -288,7 +288,7 @@ int main(int argc, char **argv)
 	    { NULL,             0, 0, 0 }
 	};
 
-	static const ul_excl_t excl[] = {	/* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'c', 'd', 'p', 'z' },
 		{ 'c', 'n' },
 		{ 0 }
diff --git a/sys-utils/fsfreeze.c b/sys-utils/fsfreeze.c
index d4d5bd3..72ccdd1 100644
--- a/sys-utils/fsfreeze.c
+++ b/sys-utils/fsfreeze.c
@@ -78,7 +78,7 @@ int main(int argc, char **argv)
 	    { NULL,        0, 0, 0 }
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'f','u' },			/* freeze, unfreeze */
 		{ 0 }
 	};
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 21caeb2..e561859 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -712,7 +712,7 @@ display_time(const bool hclock_valid, struct timeval hwctime)
  * runnable by issuing the command "date" to the /bin/sh shell. That means
  * in must be in the current PATH.
  *
- * If anything goes wrong (and many things can), we return return code 10
+ * If anything goes wrong (and many things can), we return code 10
  * and arbitrary *time_p. Otherwise, return code is 0 and *time_p is valid.
  */
 static int interpret_date_string(const char *date_opt, time_t * const time_p)
@@ -1703,7 +1703,7 @@ int main(int argc, char **argv)
 		{NULL,		0, NULL, 0}
 	};
 
-	static const ul_excl_t excl[] = {	/* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'a','r','s','w',
 		  OPT_GET, OPT_GETEPOCH, OPT_PREDICT_HC,
 		  OPT_SET, OPT_SETEPOCH, OPT_SYSTZ },
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 92526cf..a991308 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -868,7 +868,7 @@ int main(int argc, char **argv)
 		{ NULL, 0, 0, 0 }
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'B','M','R' },			/* bind,move,rbind */
 		{ 'L','U', MOUNT_OPT_SOURCE },	/* label,uuid,source */
 		{ 0 }
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 0ee5caf..4a4fefa 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -862,7 +862,7 @@ int main(int argc, char *argv[])
 		{ NULL, 0, 0, 0 }
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'a','o','s', SHOW_OPTION },
 		{ 'a','o', BYTES_OPTION },
 		{ 'a','o', NOHEADINGS_OPTION },
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index 0c81970..ae429cf 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -527,7 +527,7 @@ int main(int argc, char **argv)
 		{ NULL, 0, 0, 0 }
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'A','a' },			/* all-targets,all */
 		{ 'R','a' },			/* recursive,all */
 		{ 'O','R','t'},			/* options,recursive,types */
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 761142f..16613d7 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -495,7 +495,7 @@ int main(int argc, char *argv[])
 		{ NULL, 0, NULL, 0 }
 	};
 
-	static const ul_excl_t excl[] = {       /* rows and cols in in ASCII order */
+	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'F','f' },			/* noflags,flags*/
 		{ 0 }
 	};
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index d6cec8f..2b0a104 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -2554,7 +2554,7 @@ static void init_special_char(char* arg, struct options *op)
 }
 
 /*
- * Appends @str to @dest and if @dest is not empty then use use @sep as a
+ * Appends @str to @dest and if @dest is not empty then use @sep as a
  * separator. The maximal final length of the @dest is @len.
  *
  * Returns the final @dest length or -1 in case of error.
-- 
2.7.4

