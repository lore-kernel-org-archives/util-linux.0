Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:37309 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaLGKNJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:13:09 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so4077762wgh.37
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:13:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] textual: improve error messages
Date: Sun,  7 Dec 2014 10:13:03 +0000
Message-Id: <1417947184-24178-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947184-24178-1-git-send-email-kerolasa@iki.fi>
References: <1417947184-24178-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use error printing facilities that add command name in front of the error
message, and add explanation that is part of existing translations.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/blockdev.c    |  2 +-
 disk-utils/mkfs.c        |  3 +--
 disk-utils/mkfs.cramfs.c |  2 +-
 text-utils/more.c        | 10 ++++------
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index efaa0ea..43aaef6 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -365,7 +365,7 @@ static void do_commands(int fd, char **argv, int d)
 		}
 
 		if (res == -1) {
-			perror(bdcms[j].iocname);
+			warn(_("ioctl error on %s"), bdcms[j].iocname);
 			if (verbose)
 				printf(_("%s failed.\n"), _(bdcms[j].help));
 			exit(EXIT_FAILURE);
diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index dbc938f..8ad6065 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -147,6 +147,5 @@ int main(int argc, char **argv)
 
 	/* Execute the program */
 	execvp(progname, argv + optind);
-	perror(progname);
-	return EXIT_FAILURE;
+	err(EXIT_FAILURE, _("failed to execute %s"), progname);
 }
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index bae68ec..509b50b 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -328,7 +328,7 @@ static unsigned int parse_directory(struct entry *root_entry, const char *name,
 		memcpy(endpath, dirent->d_name, namelen + 1);
 
 		if (lstat(path, &st) < 0) {
-			perror(endpath);
+			warn(_("stat failed %s"), endpath);
 			warn_skip = 1;
 			continue;
 		}
diff --git a/text-utils/more.c b/text-utils/more.c
index a489953..8c0853c 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -591,7 +591,7 @@ FILE *checkf(register char *fs, int *clearfirst)
 		fflush(stdout);
 		if (clreol)
 			cleareol();
-		perror(fs);
+		warn(_("stat failed %s"), fs);
 		return ((FILE *)NULL);
 	}
 	if ((stbuf.st_mode & S_IFMT) == S_IFDIR) {
@@ -600,7 +600,7 @@ FILE *checkf(register char *fs, int *clearfirst)
 	}
 	if ((f = Fopen(fs, "r")) == NULL) {
 		fflush(stdout);
-		perror(fs);
+		warn(_("cannot open %s"), fs);
 		return ((FILE *)NULL);
 	}
 	if (magic(f, fs)) {
@@ -1781,10 +1781,8 @@ void initterm(void)
 			int tgrp;
 			/* Wait until we're in the foreground before we
 			 * save the terminal modes. */
-			if ((tgrp = tcgetpgrp(fileno(stdout))) < 0) {
-				perror("tcgetpgrp");
-				exit(EXIT_FAILURE);
-			}
+			if ((tgrp = tcgetpgrp(fileno(stdout))) < 0)
+				err(EXIT_FAILURE, "tcgetpgrp");
 			if (tgrp != getpgrp(0)) {
 				kill(0, SIGTTOU);
 				goto retry;
-- 
2.1.3

