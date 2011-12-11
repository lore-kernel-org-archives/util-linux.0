Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49208 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab1LKS6L (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 Dec 2011 13:58:11 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so3142322qcq.19
        for <util-linux@vger.kernel.org>; Sun, 11 Dec 2011 10:58:11 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/2] findmnt: support alternative location of fstab
Date: Sun, 11 Dec 2011 13:58:05 -0500
Message-Id: <1323629885-17940-3-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1323629885-17940-1-git-send-email-dreisner@archlinux.org>
References: <1323629885-17940-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.8 |    6 ++++--
 misc-utils/findmnt.c |    6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 24e3a52..7f3dc6c 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -36,12 +36,14 @@ The command prints all mounted filesystems in the tree-like format by default.
 .SH OPTIONS
 .IP "\fB\-h, \-\-help\fP"
 Print help and exit.
-.IP "\fB\-s, \-\-fstab\fP"
+.IP "\fB\-s, \-\-fstab\fR[\fI=fstab\fR]\fP"
 Search in
 .IR /etc/fstab
 and
 .IR /etc/fstab.d .
-The output is in the list format (see --list).
+The output is in the list format (see --list). Optionally, search the file
+specified by
+.IR fstab .
 .IP "\fB\-m, \-\-mtab\fP"
 Search in
 .IR /etc/mtab .
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 4577dc6..a23a432 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -770,7 +770,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 	fprintf(out, _(
 	"\nOptions:\n"
-	" -s, --fstab            search in static table of filesystems\n"
+	" -s, --fstab[=<fstab>]  search in static table of filesystems\n"
 	" -m, --mtab             search in table of mounted filesystems\n"
 	" -k, --kernel           search in kernel table of mounted\n"
         "                          filesystems (default)\n\n"));
@@ -839,7 +839,7 @@ int main(int argc, char *argv[])
 	    { "direction",    1, 0, 'd' },
 	    { "evaluate",     0, 0, 'e' },
 	    { "first-only",   0, 0, 'f' },
-	    { "fstab",        0, 0, 's' },
+	    { "fstab",        2, 0, 's' },
 	    { "help",         0, 0, 'h' },
 	    { "invert",       0, 0, 'i' },
 	    { "kernel",       0, 0, 'k' },
@@ -938,7 +938,7 @@ int main(int argc, char *argv[])
 		case 's':		/* fstab */
 			if (tabfile)
 				errx_mutually_exclusive("--{fstab,mtab,kernel}");
-			tabfile = _PATH_MNTTAB;
+			tabfile = optarg ? optarg : _PATH_MNTTAB;
 			tt_flags &= ~TT_FL_TREE;
 			break;
 		case 'k':		/* kernel (mountinfo) */
-- 
1.7.8

