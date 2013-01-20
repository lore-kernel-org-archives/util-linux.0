Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:65027 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab3ATSFK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 13:05:10 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so919658wgh.7
        for <util-linux@vger.kernel.org>; Sun, 20 Jan 2013 10:05:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/6] nsenter: adjust few error messages
Date: Sun, 20 Jan 2013 18:04:53 +0000
Message-Id: <1358705096-21092-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
References: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The 'neither filename nor target' is changed to use errx() rather than
err(), because the errno is indicating success at the time of fatal error
which is wrong message for an user.

The "cannot open %s" is same string as in other files, making translators
to work less.

Remaining changes aim to ease understanding what went wrong for a
non-programmer audience.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/nsenter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index ce2c64d..ec8600a 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -94,7 +94,7 @@ static void open_target_fd(int *fd, const char *type, const char *path)
 		path = pathbuf;
 	}
 	if (!path)
-		err(EXIT_FAILURE, _("No filename and no target pid supplied for %s"),
+		errx(EXIT_FAILURE, _("neither filename nor target pid supplied for %s"),
 		    type);
 
 	if (*fd >= 0)
@@ -102,7 +102,7 @@ static void open_target_fd(int *fd, const char *type, const char *path)
 
 	*fd = open(path, O_RDONLY);
 	if (*fd < 0)
-		err(EXIT_FAILURE, _("open of '%s' failed"), path);
+		err(EXIT_FAILURE, _("cannot open %s"), path);
 }
 
 static void open_namespace_fd(int nstype, const char *path)
@@ -233,7 +233,7 @@ int main(int argc, char *argv[])
 		if (nsfile->fd < 0)
 			continue;
 		if (setns(nsfile->fd, nsfile->nstype))
-			err(EXIT_FAILURE, _("setns of '%s' failed"),
+			err(EXIT_FAILURE, _("reassociate to namespace '%s' failed"),
 			    nsfile->name);
 		close(nsfile->fd);
 		nsfile->fd = -1;
@@ -243,13 +243,13 @@ int main(int argc, char *argv[])
 	if (root_fd >= 0 && wd_fd < 0) {
 		wd_fd = open(".", O_RDONLY);
 		if (wd_fd < 0)
-			err(EXIT_FAILURE, _("open of . failed"));
+			err(EXIT_FAILURE, _("cannot open current working directory"));
 	}
 
 	/* Change the root directory */
 	if (root_fd >= 0) {
 		if (fchdir(root_fd) < 0)
-			err(EXIT_FAILURE, _("fchdir to root_fd failed"));
+			err(EXIT_FAILURE, _("change directory by root file descriptor failed"));
 
 		if (chroot(".") < 0)
 			err(EXIT_FAILURE, _("chroot failed"));
@@ -261,7 +261,7 @@ int main(int argc, char *argv[])
 	/* Change the working directory */
 	if (wd_fd >= 0) {
 		if (fchdir(wd_fd) < 0)
-			err(EXIT_FAILURE, _("fchdir to wd_fd failed"));
+			err(EXIT_FAILURE, _("change directory by working directory file descriptor failed"));
 
 		close(wd_fd);
 		wd_fd = -1;
-- 
1.8.1.1

