Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdFVUnr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jun 2017 16:43:47 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzYY2-1dtgRf1S2E-014kxe for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 22:43:45 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/5] misc: fix more strutils related exit codes
Date: Thu, 22 Jun 2017 22:43:42 +0200
Message-Id: <1498164224-13549-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Found by grep:

grep -l "\bEXIT_\|exit *( *[0-9][0-9] *)\|strutils\.h" $(grep -L \
    strutils_set_exitcode  $(git grep -l "_EX_\|FINDFS_\|BLKID_EXIT\|EX_USAGE" -- "*.c"))

The Command shows also some false positives (fstrim.c,
context_mount.c, ...)

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.cramfs.c | 2 ++
 disk-utils/fsck.minix.c  | 2 ++
 disk-utils/mkfs.cramfs.c | 2 ++
 disk-utils/mkfs.minix.c  | 2 ++
 sys-utils/flock.c        | 2 ++
 sys-utils/hwclock.c      | 2 ++
 sys-utils/mount.c        | 2 ++
 7 files changed, 14 insertions(+)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 952f153..1dba95e 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -660,6 +660,8 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(FSCK_EX_USAGE);
+
 	/* command line options */
 	while ((c = getopt_long(argc, argv, "ayvVhb:", longopts, NULL)) != EOF)
 		switch (c) {
diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index dea3436..bff810e 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -1293,6 +1293,8 @@ main(int argc, char **argv) {
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(FSCK_EX_USAGE);
+
 	if (INODE_SIZE * MINIX_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
 		die(_("bad inode size"));
 	if (INODE2_SIZE * MINIX2_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 041c6d7..6a6d9a1 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -717,6 +717,8 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(MKFS_EX_USAGE);
+
 	/* command line options */
 	while ((c = getopt(argc, argv, "hb:Ee:i:n:N:psVvz")) != EOF) {
 		switch (c) {
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 47a155c..96d36b0 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -758,6 +758,8 @@ int main(int argc, char ** argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(MKFS_EX_USAGE);
+
 	while ((i = getopt_long(argc, argv, "1v23n:i:cl:Vh", longopts, NULL)) != -1)
 		switch (i) {
 		case '1':
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 50194bd..003a126 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -170,6 +170,8 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(EX_USAGE);
+
 	if (argc < 2)
 		usage(EX_USAGE);
 
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 5433cd0..325106a 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1326,6 +1326,8 @@ int main(int argc, char **argv)
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
+	strutils_set_exitcode(EX_USAGE);
+
 	/* Remember what time we were invoked */
 	gettimeofday(&startup_time, NULL);
 
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 4d7a5fc..0f7fa90 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -534,6 +534,8 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(MNT_EX_USAGE);
+
 	mnt_init_debug(0);
 	cxt = mnt_new_context();
 	if (!cxt)
-- 
1.8.5.6

