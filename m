Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:56763 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965454AbcCPI5F (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 04:57:05 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/8] mount, umount, swapon, fsck, lsblk, findmnt: harmonize six error messages
Date: Wed, 16 Mar 2016 09:55:53 +0100
Message-Id: <1458118555-4691-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
References: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/fsck.c         |    2 +-
 misc-utils/findmnt.c      |    2 +-
 misc-utils/lsblk.c        |    3 +--
 sys-utils/mount.c         |    3 +--
 sys-utils/swapon-common.c |    3 +--
 sys-utils/umount.c        |    3 +--
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 6f9e78b..05cfbc4 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -470,7 +470,7 @@ static void fs_interpret_type(struct libmnt_fs *fs)
 static int parser_errcb(struct libmnt_table *tb __attribute__ ((__unused__)),
 			const char *filename, int line)
 {
-	warnx(_("%s: parse error at line %d -- ignore"), filename, line);
+	warnx(_("%s: parse error at line %d -- ignored"), filename, line);
 	return 1;
 }
 
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index f72be14..904a09d 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -804,7 +804,7 @@ leave:
 static int parser_errcb(struct libmnt_table *tb __attribute__ ((__unused__)),
 			const char *filename, int line)
 {
-	warnx(_("%s: parse error at line %d"), filename, line);
+	warnx(_("%s: parse error at line %d -- ignored"), filename, line);
 	return 1;
 }
 
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index c9a39b3..0e76f43 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -430,8 +430,7 @@ static int table_parser_errcb(struct libmnt_table *tb __attribute__((__unused__)
 			const char *filename, int line)
 {
 	if (filename)
-		warnx(_("%s: parse error: ignore entry at line %d."),
-							filename, line);
+		warnx(_("%s: parse error at line %d -- ignored"), filename, line);
 	return 1;
 }
 
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 01eaccb..abc7a3e 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -99,8 +99,7 @@ static int table_parser_errcb(struct libmnt_table *tb __attribute__((__unused__)
 			const char *filename, int line)
 {
 	if (filename)
-		warnx(_("%s: parse error: ignore entry at line %d."),
-							filename, line);
+		warnx(_("%s: parse error at line %d -- ignored"), filename, line);
 	return 1;
 }
 
diff --git a/sys-utils/swapon-common.c b/sys-utils/swapon-common.c
index 8b686c0..dd1593d 100644
--- a/sys-utils/swapon-common.c
+++ b/sys-utils/swapon-common.c
@@ -16,8 +16,7 @@ static int table_parser_errcb(struct libmnt_table *tb __attribute__((__unused__)
 			const char *filename, int line)
 {
 	if (filename)
-		warnx(_("%s: parse error: ignore entry at line %d."),
-							filename, line);
+		warnx(_("%s: parse error at line %d -- ignored"), filename, line);
 	return 1;
 }
 
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index 1d866fa..8e3ef4e 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -43,8 +43,7 @@ static int table_parser_errcb(struct libmnt_table *tb __attribute__((__unused__)
 			const char *filename, int line)
 {
 	if (filename)
-		warnx(_("%s: parse error: ignore entry at line %d."),
-							filename, line);
+		warnx(_("%s: parse error at line %d -- ignored"), filename, line);
 	return 1;
 }
 
-- 
1.7.0.4

