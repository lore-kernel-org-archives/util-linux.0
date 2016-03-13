Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49648 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754257AbcCMWbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:25 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M0smx-1ZpbKH46Fr-00v9wg for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:23 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/12] misc: fix icc/clang compiler warnings
Date: Sun, 13 Mar 2016 23:31:10 +0100
Message-Id: <1457908280-15588-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

clang warning:
libmount/src/tab.c:1833:6: warning: variable 'rc' is used uninitialized whenever
      'if' condition is true [-Wsometimes-uninitialized]
        if (!mpc)
            ^~~~

icc printf warnings:
    libmount/src/monitor.c(348): warning #2279: printf/scanf format not a string literal and no format arguments
            DBG(MONITOR, ul_debugobj(mn, status == 1 ? " success" : " nothing"));
            ^
    login-utils/vipw.c(348): warning #2279: printf/scanf format not a string literal and no format arguments
                           : _("You are using shadow passwords on this system.\n"));
                                                                                  ^

icc enum warnings:
    disk-utils/fdisk-menu.c(150): warning #188: enumerated type mixed with another type
            .exclude = FDISK_DISKLABEL_GPT | FDISK_DISKLABEL_BSD,
                       ^
    libsmartcols/src/table_print.c(750): warning #188: enumerated type mixed with another type
                            &width, align,
                                    ^

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fdisk-menu.c        | 4 ++--
 libmount/src/monitor.c         | 2 +-
 libmount/src/tab.c             | 5 ++---
 libsmartcols/src/table_print.c | 3 ++-
 login-utils/vipw.c             | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index 84b8fb7..7195844 100644
--- a/disk-utils/fdisk-menu.c
+++ b/disk-utils/fdisk-menu.c
@@ -19,7 +19,7 @@ struct menu_entry {
 						   but don't print it in help */
 
 	enum fdisk_labeltype	label;		/* only for this label */
-	enum fdisk_labeltype	exclude;	/* all labels except this */
+	int                     exclude;    /* all labels except these */
 	enum fdisk_labeltype	parent;		/* for nested PT */
 };
 
@@ -28,7 +28,7 @@ struct menu_entry {
 
 struct menu {
 	enum fdisk_labeltype	label;		/* only for this label */
-	enum fdisk_labeltype	exclude;	/* all labels except this */
+	int                     exclude;    /* all labels except these */
 
 	unsigned int		nonested : 1;	/* don't make this menu active in nested PT */
 
diff --git a/libmount/src/monitor.c b/libmount/src/monitor.c
index a71f2f5..9f9e2ba 100644
--- a/libmount/src/monitor.c
+++ b/libmount/src/monitor.c
@@ -345,7 +345,7 @@ static int userspace_event_verify(struct libmnt_monitor *mn,
 		}
 	} while (1);
 
-	DBG(MONITOR, ul_debugobj(mn, status == 1 ? " success" : " nothing"));
+	DBG(MONITOR, ul_debugobj(mn, "%s", status == 1 ? " success" : " nothing"));
 	return status;
 }
 
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 0570044..a7a1b6b 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1808,7 +1808,7 @@ static int test_is_mounted(struct libmnt_test *ts, int argc, char *argv[])
 	struct libmnt_fs *fs;
 	struct libmnt_iter *itr = NULL;
 	struct libmnt_cache *mpc = NULL;
-	int rc, writable = 0;
+	int writable = 0;
 	const char *path = NULL;
 
 	if (mnt_has_regular_mtab(&path, &writable) == 1 && writable == 0)
@@ -1846,12 +1846,11 @@ static int test_is_mounted(struct libmnt_test *ts, int argc, char *argv[])
 					mnt_fs_get_target(fs));
 	}
 
-	rc = 0;
 done:
 	mnt_unref_table(tb);
 	mnt_unref_table(fstab);
 	mnt_free_iter(itr);
-	return rc;
+	return 0;
 }
 
 /* returns 0 if @a and @b targets are the same */
diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 510386e..d86b068 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -702,7 +702,8 @@ static int print_line(struct libscols_table *tb,
 
 static int print_title(struct libscols_table *tb)
 {
-	int rc, align;
+	int rc;
+	mbs_align_t align;
 	size_t len = 0, width;
 	char *title = NULL, *buf = NULL;
 
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index bb4a8ba..066fee0 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -343,7 +343,7 @@ int main(int argc, char *argv[])
 	if (access(orig_file, F_OK) == 0) {
 		char response[80];
 
-		printf((program == VIGR)
+		printf("%s", (program == VIGR)
 		       ? _("You are using shadow groups on this system.\n")
 		       : _("You are using shadow passwords on this system.\n"));
 		/* TRANSLATORS: this program uses for y and n rpmatch(3),
-- 
1.8.4.5

