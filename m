Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:52317 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab2LPKoj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:39 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so1401242wib.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/14] minix: replace magic constants with macro names
Date: Sun, 16 Dec 2012 10:43:59 +0000
Message-Id: <1355654642-22106-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c | 14 +++++++-------
 disk-utils/mkfs.minix.c |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 6189b0b..8e9ee22 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -168,7 +168,7 @@ static char *zone_map;
 static void
 reset(void) {
 	if (termios_set)
-		tcsetattr(0, TCSANOW, &termios);
+		tcsetattr(STDIN_FILENO, TCSANOW, &termios);
 }
 
 static void
@@ -294,7 +294,7 @@ check_mount(void) {
 		return;
 
 	printf(_("%s is mounted.	 "), device_name);
-	if (isatty(0) && isatty(1))
+	if (isatty(STDIN_FILENO) && isatty(STDOUT_FILENO))
 		cont = ask(_("Do you really want to continue"), 0);
 	else
 		cont = 0;
@@ -1238,7 +1238,7 @@ int
 main(int argc, char **argv) {
 	struct termios tmp;
 	int count;
-	int retcode = 0;
+	int retcode = FSCK_EX_OK;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -1297,7 +1297,7 @@ main(int argc, char **argv) {
 		usage();
 	check_mount();		/* trying to check a mounted filesystem? */
 	if (repair && !automatic) {
-		if (!isatty(0) || !isatty(1))
+		if (!isatty(STDIN_FILENO) || !isatty(STDOUT_FILENO))
 			die(_("need terminal for interactive repairs"));
 	}
 	IN = open(device_name, repair ? O_RDWR : O_RDONLY);
@@ -1330,10 +1330,10 @@ main(int argc, char **argv) {
 	signal(SIGTERM, fatalsig);
 
 	if (repair && !automatic) {
-		tcgetattr(0, &termios);
+		tcgetattr(STDIN_FILENO, &termios);
 		tmp = termios;
 		tmp.c_lflag &= ~(ICANON | ECHO);
-		tcsetattr(0, TCSANOW, &tmp);
+		tcsetattr(STDIN_FILENO, TCSANOW, &tmp);
 		termios_set = 1;
 	}
 
@@ -1381,7 +1381,7 @@ main(int argc, char **argv) {
 		write_super_block();
 
 	if (repair && !automatic)
-		tcsetattr(0, TCSANOW, &termios);
+		tcsetattr(STDIN_FILENO, TCSANOW, &termios);
 
 	if (changed)
 		retcode += 3;
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index b445c0c..bbfee32 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -666,7 +666,7 @@ int main(int argc, char ** argv) {
 	if (argc == 2 &&
 	    (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version"))) {
 		printf(_("%s (%s)\n"), program_name, PACKAGE_STRING);
-		exit(0);
+		exit(MKFS_EX_OK);
 	}
 
 	if (INODE_SIZE * MINIX_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
@@ -806,5 +806,5 @@ int main(int argc, char ** argv) {
 	write_tables();
 	close(DEV);
 
-	return 0;
+	return MKFS_EX_OK;
 }
-- 
1.8.0.2

