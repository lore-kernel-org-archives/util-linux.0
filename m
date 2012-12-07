Return-Path: alun.linux@ty-penguin.org.uk
Date: Fri, 7 Dec 2012 11:17:23 +0000
From: Alun <alun.linux@ty-penguin.org.uk>
To: Alun <alun.linux@ty-penguin.org.uk>
Cc: kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH] Add option to fsfreeze to call syncfs() prior to
 freezing.
Message-ID: <20121207111723.7cd3f1f8@pcebbj.staff.aber.ac.uk>
In-Reply-To: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
References: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

Dear all,

Very sorry - I made a small mistake in the previous patch, which
resulted in syncfs() always being called rather than only when -s
was specified.

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
index 7161442..6e8fc82 100644
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
+	if (dosync == TRUE) {
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
