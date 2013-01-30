Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:53197 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3A3Uda (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Jan 2013 15:33:30 -0500
Received: by mail-wi0-f181.google.com with SMTP id c10so2096590wiw.2
        for <util-linux@vger.kernel.org>; Wed, 30 Jan 2013 12:33:29 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] a pointer should not be compared to zero [coccinelle]
Date: Wed, 30 Jan 2013 20:33:23 +0000
Message-Id: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/ismounted.c          | 2 +-
 libblkid/src/devno.c     | 2 +-
 misc-utils/whereis.c     | 6 +++---
 mount-deprecated/mount.c | 2 +-
 term-utils/agetty.c      | 4 ++--
 text-utils/more.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/ismounted.c b/lib/ismounted.c
index 5611ab3..d9f1f57 100644
--- a/lib/ismounted.c
+++ b/lib/ismounted.c
@@ -91,7 +91,7 @@ static int check_mntent_file(const char *mtab_file, const char *file,
 		}
 	}
 
-	if (mnt == 0) {
+	if (mnt == NULL) {
 #ifndef __GNU__ /* The GNU hurd is broken with respect to stat devices */
 		/*
 		 * Do an extra check to see if this is the root device.  We
diff --git a/libblkid/src/devno.c b/libblkid/src/devno.c
index c549035..906c91f 100644
--- a/libblkid/src/devno.c
+++ b/libblkid/src/devno.c
@@ -115,7 +115,7 @@ void blkid__scan_dir(char *dirname, dev_t devno, struct dir_list **list,
 	if ((dir = opendir(dirname)) == NULL)
 		return;
 
-	while ((dp = readdir(dir)) != 0) {
+	while ((dp = readdir(dir)) != NULL) {
 #ifdef _DIRENT_HAVE_D_TYPE
 		if (dp->d_type != DT_UNKNOWN && dp->d_type != DT_BLK &&
 		    dp->d_type != DT_LNK && dp->d_type != DT_DIR)
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 3528d62..b85320b 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -304,7 +304,7 @@ findv(char **dirv, int dirc, char *cp)
 static void
 looksrc(char *cp)
 {
-	if (Sflag == 0)
+	if (Sflag == NULL)
 		findv(srcdirs, ARRAY_SIZE(srcdirs)-1, cp);
 	else
 		findv(Sflag, Scnt, cp);
@@ -313,7 +313,7 @@ looksrc(char *cp)
 static void
 lookbin(char *cp)
 {
-	if (Bflag == 0) {
+	if (Bflag == NULL) {
 		findv(bindirs, ARRAY_SIZE(bindirs)-1, cp);
 		while (*pathdir_p)
 			findin(*pathdir_p++, cp);		/* look $PATH */
@@ -324,7 +324,7 @@ lookbin(char *cp)
 static void
 lookman(char *cp)
 {
-	if (Mflag == 0)
+	if (Mflag == NULL)
 		findv(mandirs, ARRAY_SIZE(mandirs)-1, cp);
 	else
 		findv(Mflag, Mcnt, cp);
diff --git a/mount-deprecated/mount.c b/mount-deprecated/mount.c
index 3190d2f..5031683 100644
--- a/mount-deprecated/mount.c
+++ b/mount-deprecated/mount.c
@@ -1668,7 +1668,7 @@ try_mount_one (const char *spec0, const char *node0, const char *types0,
 
   /* Mount failed, complain, but don't die.  */
 
-  if (types == 0) {
+  if (types == NULL) {
     if (restricted)
       error (_("mount: I could not determine the filesystem type, "
 	       "and none was specified"));
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index aee853c..104ea18 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -358,7 +358,7 @@ int main(int argc, char **argv)
 			/* Read the login name. */
 			debug("reading login name\n");
 			while ((username =
-				get_logname(&options, &termios, &chardata)) == 0)
+				get_logname(&options, &termios, &chardata)) == NULL)
 				if ((options.flags & F_VCONSOLE) == 0)
 					next_speed(&options, &termios);
 		}
@@ -747,7 +747,7 @@ static void parse_speeds(struct options *op, char *arg)
 	char *cp;
 
 	debug("entered parse_speeds\n");
-	for (cp = strtok(arg, ","); cp != 0; cp = strtok((char *)0, ",")) {
+	for (cp = strtok(arg, ","); cp != NULL; cp = strtok((char *)0, ",")) {
 		if ((op->speeds[op->numspeed++] = bcode(cp)) <= 0)
 			log_err(_("bad speed: %s"), cp);
 		if (op->numspeed >= MAX_SPEED)
diff --git a/text-utils/more.c b/text-utils/more.c
index 2c97950..7d1aeee 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1786,7 +1786,7 @@ void initterm(void)
 			}
 		}
 #endif	/* do_SIGTTOU */
-		if ((term = getenv("TERM")) == 0) {
+		if ((term = getenv("TERM")) == NULL) {
 			dumb++;
 			ul_opt = 0;
 		}
@@ -1857,7 +1857,7 @@ void initterm(void)
 			if ((padstr = my_tgetstr(TERM_PAD_CHAR)) != NULL)
 				PC = *padstr;
 			Home = my_tgetstr(TERM_HOME);
-			if (Home == 0 || *Home == '\0') {
+			if (Home == NULL || *Home == '\0') {
 				if ((cursorm =
 				     my_tgetstr(TERM_CURSOR_ADDRESS)) != NULL) {
 					const char *t =
-- 
1.8.1.2

