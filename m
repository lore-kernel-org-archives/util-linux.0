Return-Path: util-linux-owner@vger.kernel.org
Received: from hosting.adsl24.co.uk ([84.234.17.171]:47289 "EHLO
	hosting.adsl24.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066Ab2LGLJ5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Dec 2012 06:09:57 -0500
Date: Fri, 7 Dec 2012 10:14:00 +0000
From: Alun <alun.linux@ty-penguin.org.uk>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: [PATCH] Add option to fsfreeze to call syncfs() prior to freezing.
Message-ID: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I've recently been looking into a problem on a heavily loaded fileserver.
Running fsfreeze on the filesystem causes the load average to go sky high.
Looking at the kernel sources, I discovered that the FIFREEZE ioctl suspends
writes, then syncs the filesystem. With a large amount of dirty data, this
can leave writes suspended for a significant time, even if your intent is to
have the filesystem frozen for a short time. I raised this on the kernel
list, suggesting an extra call to sync the filesystem prior to suspending
writes, but it was pointed out to me that this would change the semantics
of the ioctl.

Adding a call to syncfs() prior to freezing the filesystem will achieve
the same result, so I'm proposing the following patch which adds a "-s"
option to fsfreeze which, when specified, will cause it to call syncfs
on the filesystem. You can use it by itself to cause a filesystem sync,
or in combination with -f to sync, then freeze the filesystem.

Signed-off-by: Alun Jones <alun.linux@ty-penguin.org.uk>

diff --git a/sys-utils/fsfreeze.8 b/sys-utils/fsfreeze.8
index 7693861..0d73afe 100644
--- a/sys-utils/fsfreeze.8
+++ b/sys-utils/fsfreeze.8
@@ -1,5 +1,5 @@
 .\" -*- nroff -*-
-.TH FSFREEZE 8 "May 2010" "util-linux" "System Administration"
+.TH FSFREEZE 8 "December 2012" "util-linux" "System Administration"
 .SH NAME
 fsfreeze \- suspend access to a filesystem (Linux Ext3/4, ReiserFS, JFS, XFS)
 .SH SYNOPSIS
@@ -9,6 +9,9 @@ fsfreeze \- suspend access to a filesystem (Linux Ext3/4, ReiserFS, JFS, XFS)
 .B fsfreeze \-u
 .I mountpoint
 
+.B fsfreeze \-s
+.I mountpoint
+
 .SH DESCRIPTION
 .B fsfreeze
 suspends and resumes access to an filesystem
@@ -53,6 +56,14 @@ or a clean mount of the snapshot is complete.
 This option is used to un-freeze the filesystem and allow operations to
 continue.  Any filesystem modifications that were blocked by the freeze are
 unblocked and allowed to complete.
+.IP "\fB\-s, \-\-sync\fP
+This option, if specified, will cause fsfreeze to call syncfs() on the 
+filesystem. It can be combined with -f to force dirty data to be written prior
+to the freeze operation. On a filesystem with heavy write load, adding this
+option will very likely reduce the time during which writes are suspended,
+at the cost of a delay before suspending writes. Therefore, if it's critical
+to reduce the time for which the filesystem is frozen, use this option; if 
+it's critical to freeze the filesystem at a specific moment, don't use it.
 .SH AUTHOR
 .PP
 Written by Hajime Taira.
diff --git a/sys-utils/fsfreeze.c b/sys-utils/fsfreeze.c
index 7161442..5a473fd 100644
--- a/sys-utils/fsfreeze.c
+++ b/sys-utils/fsfreeze.c
@@ -44,6 +44,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 	fputs(_("\nOptions:\n"), out);
 	fputs(_(" -h, --help        this help\n"
+		" -s, --sync        sync the filesystem\n"
 		" -f, --freeze      freeze the filesystem\n"
 		" -u, --unfreeze    unfreeze the filesystem\n"), out);
 
@@ -56,6 +57,7 @@ int main(int argc, char **argv)
 {
 	int fd = -1, c;
 	int freeze = -1, rc = EXIT_FAILURE;
+	int dosync = -1;
 	char *path;
 	struct stat sb;
 
@@ -63,6 +65,7 @@ int main(int argc, char **argv)
 	    { "help",      0, 0, 'h' },
 	    { "freeze",    0, 0, 'f' },
 	    { "unfreeze",  0, 0, 'u' },
+	    { "sync",      0, 0, 's' },
 	    { NULL,        0, 0, 0 }
 	};
 
@@ -71,7 +74,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "hfu", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "hfus", longopts, NULL)) != -1) {
 		switch(c) {
 		case 'h':
 			usage(stdout);
@@ -82,13 +85,16 @@ int main(int argc, char **argv)
 		case 'u':
 			freeze = FALSE;
 			break;
+		case 's':
+			dosync = TRUE;
+			break;
 		default:
 			usage(stderr);
 			break;
 		}
 	}
 
-	if (freeze == -1)
+	if (freeze == -1 && dosync == -1)
 		errx(EXIT_FAILURE, _("no action specified"));
 	if (optind == argc)
 		errx(EXIT_FAILURE, _("no filename specified"));
@@ -113,12 +119,19 @@ int main(int argc, char **argv)
 		goto done;
 	}
 
-	if (freeze) {
+	if (dosync) {
+		if (syncfs(fd)) {
+			warn(_("%s: syncfs failed"), path);
+			goto done;
+		}
+	}
+
+	if (freeze == TRUE) {
 		if (freeze_f(fd)) {
 			warn(_("%s: freeze failed"), path);
 			goto done;
 		}
-	} else {
+	} else if (freeze == FALSE) {
 		if (unfreeze_f(fd)) {
 			warn(_("%s: unfreeze failed"), path);
 			goto done;
