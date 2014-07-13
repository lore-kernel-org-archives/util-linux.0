Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:39095 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbaGMUZG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:06 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so659241wiw.0
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/14] textual: fix some typos
Date: Sun, 13 Jul 2014 21:24:40 +0100
Message-Id: <1405283093-28182-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Found with misspell-check version 2.0d.

Reference: https://github.com/lyda/misspell-check
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/strutils.c             | 2 +-
 libfdisk/src/partition.c   | 2 +-
 libmount/src/tab.c         | 2 +-
 libsmartcols/src/version.c | 2 +-
 login-utils/last.c         | 2 +-
 sys-utils/fstrim.c         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/strutils.c b/lib/strutils.c
index 31bf9e2..9fe9481 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -47,7 +47,7 @@ static int do_scale_by_power (uintmax_t *x, int base, int power)
  * The optinal 'power' variable returns number associated with used suffix
  * {K,M,G,T,P,E,Z,Y}  = {1,2,3,4,5,6,7,8}.
  *
- * The funtion also supports decimal point, for example:
+ * The function also supports decimal point, for example:
  *              0.5MB   = 500000
  *              0.5MiB  = 512000
  *
diff --git a/libfdisk/src/partition.c b/libfdisk/src/partition.c
index 70f707c..32473a3 100644
--- a/libfdisk/src/partition.c
+++ b/libfdisk/src/partition.c
@@ -303,7 +303,7 @@ int fdisk_partition_next_partno(
  *
  * Returns info about partition converted to printable string.
  *
- * For exmaple
+ * For example
  *
  *      struct fdisk_parition *pa;
  *
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index fd6a7d8..4094fb8 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -390,7 +390,7 @@ int mnt_table_append_trailing_comment(struct libmnt_table *tb, const char *comm)
  * same cache between more threads -- currently the cache does not provide any
  * locking method.
  *
- * This function increments cache refrence counter. It's recomented to use
+ * This function increments cache reference counter. It's recomented to use
  * mnt_unref_cache() after mnt_table_set_cache() if you want to keep the cache
  * referenced by @tb only.
  *
diff --git a/libsmartcols/src/version.c b/libsmartcols/src/version.c
index 9aa4e33..e592ccc 100644
--- a/libsmartcols/src/version.c
+++ b/libsmartcols/src/version.c
@@ -11,7 +11,7 @@
  * @title: Version functions
  * @short_description: functions to get the library version.
  *
- * Note that library version is not the same thing as SONAME verison. The
+ * Note that library version is not the same thing as SONAME version. The
  * libsmarcols uses symbols versioning and SONAME is not modified for releases.
  *
  * The library version and symbols version follow util-linux package versioning.
diff --git a/login-utils/last.c b/login-utils/last.c
index ba58c44..4c70eaa 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -401,7 +401,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 		utline[4] = 0;
 
 	/*
-	 *	Is this something we wanna show?
+	 *	Is this something we want to show?
 	 */
 	if (ctl->show) {
 		char **walk;
diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index c51c7a8..d52d831 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -118,7 +118,7 @@ static int has_discard(const char *devname, struct sysfs_cxt *wholedisk)
 	 * This is tricky to read the info from sys/, because the queue
 	 * atrributes are provided for whole devices (disk) only. We're trying
 	 * to reuse the whole-disk sysfs context to optimize this stuff (as
-	 * system usualy have just one disk only).
+	 * system usually have just one disk only).
 	 */
 	if (sysfs_devno_to_wholedisk(dev, NULL, 0, &disk) || !disk)
 		return 1;
-- 
2.0.1

