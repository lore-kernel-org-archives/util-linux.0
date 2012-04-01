Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62944 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab2DASUd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Apr 2012 14:20:33 -0400
Received: by mail-ee0-f46.google.com with SMTP id c41so638975eek.19
        for <util-linux@vger.kernel.org>; Sun, 01 Apr 2012 11:20:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] chkdupexe: reimplement command in C
Date: Sun,  1 Apr 2012 20:19:32 +0200
Message-Id: <1333304372-25944-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
References: <20120330150457.GE23437@x2.net.home>
 <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The new version of the command is nearly identical to old.  Major
differences are:

* New output is a little rough what comes to alignment.  This is
  flagged as FIXME item in source.
* The command is much quicker than perl implementation which used
  to exec ls -ldU.
* Size of chkdupexe binary is about five times bigger than perl
  script.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac            |    4 -
 include/pathnames.h     |    2 +
 misc-utils/Makefile.am  |    6 +-
 misc-utils/chkdupexe.1  |   43 ++++++-
 misc-utils/chkdupexe.c  |  307 +++++++++++++++++++++++++++++++++++++++++++++++
 misc-utils/chkdupexe.pl |  120 ------------------
 6 files changed, 351 insertions(+), 131 deletions(-)
 create mode 100644 misc-utils/chkdupexe.c
 delete mode 100755 misc-utils/chkdupexe.pl

diff --git a/configure.ac b/configure.ac
index 2140bc5..2abf214 100644
--- a/configure.ac
+++ b/configure.ac
@@ -114,9 +114,6 @@ UL_SET_ARCH(M68K, m68*)
 UL_SET_ARCH(MIPS, mips*)
 UL_SET_ARCH(HPPA, hppa*)
 
-dnl script chkdupexe requires perl
-AC_PATH_PROG(PERL, perl)
-
 AC_SYS_LARGEFILE
 
 AM_GNU_GETTEXT_VERSION([0.14.1])
@@ -1223,7 +1220,6 @@ libuuid/uuid.pc
 login-utils/Makefile
 man/ru/Makefile
 misc-utils/Makefile
-misc-utils/chkdupexe:misc-utils/chkdupexe.pl
 mount/Makefile
 partx/Makefile
 po/Makefile.in
diff --git a/include/pathnames.h b/include/pathnames.h
index 299d922..a3d05ec 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -25,6 +25,8 @@
 #undef _PATH_DEFPATH_ROOT
 #define	_PATH_DEFPATH_ROOT	"/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
 
+#define _PATH_CHKDUPEXE		"/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11/bin:/usr/bin/X11:/usr/local/X11/bin:/usr/TeX/bin:/usr/tex/bin:/usr/games:/usr/local/games"
+
 #define _PATH_SECURETTY		"/etc/securetty"
 #define _PATH_WTMPLOCK		"/etc/wtmplock"
 
diff --git a/misc-utils/Makefile.am b/misc-utils/Makefile.am
index acf2c9d..200b1da 100644
--- a/misc-utils/Makefile.am
+++ b/misc-utils/Makefile.am
@@ -8,19 +8,17 @@ usrsbin_exec_PROGRAMS =
 
 usrbin_exec_PROGRAMS = \
 	cal \
+	chkdupexe \
 	logger \
 	look \
 	mcookie \
 	namei \
 	whereis
 
+chkdupexe_SOURCES = chkdupexe.c $(top_srcdir)/lib/strutils.c
 logger_SOURCES = logger.c $(top_srcdir)/lib/strutils.c
 mcookie_SOURCES = mcookie.c $(top_srcdir)/lib/md5.c
 
-usrbin_exec_SCRIPTS = chkdupexe
-
-CLEANFILES = chkdupexe
-
 dist_man_MANS = \
 	cal.1 \
 	chkdupexe.1 \
diff --git a/misc-utils/chkdupexe.1 b/misc-utils/chkdupexe.1
index dd3664a..dc2ffb7 100644
--- a/misc-utils/chkdupexe.1
+++ b/misc-utils/chkdupexe.1
@@ -2,6 +2,7 @@
 .\" Created: Sat Mar 11 18:19:44 1995 by faith@cs.unc.edu
 .\" Revised: Sat Mar 11 19:07:05 1995 by faith@cs.unc.edu
 .\" Revised: Wed Jul  5 01:56:26 1995 by shields@tembel.org
+.\" Revised: Wed Mar 14 21:08:59 2012 by kerolasa@iki.fi
 .\" Copyright 1995 Rickard E. Faith (faith@cs.unc.edu)
 .\" 
 .\" Permission is granted to make and distribute verbatim copies of this
@@ -24,15 +25,51 @@
 .\" Formatted or processed versions of this manual, if unaccompanied by
 .\" the source, must acknowledge the copyright and authors of this work.
 .\" 
-.TH CHKDUPEXE 1 "March 1995" "util-linux" "User Commands"
+.TH CHKDUPEXE 1 "March 2012" "util-linux" "User Commands"
 .SH NAME
 chkdupexe \- find duplicate executables
 .SH SYNOPSIS
 .B chkdupexe
+[options]
 .SH DESCRIPTION
 .B chkdupexe
 will scan the union of $PATH and a hardcoded list of common locations
 for binaries.  It will report dangling symlinks and duplicately-named
 binaries.
-.SH AUTHOR
-Nicolai Langfeldt, Michael Shields.
+.SH OPTIONS
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Display help and exit.
+.SH NOTES
+.IP "The hardcoded locations directories are:" 7
+.br
+/bin
+.br
+/sbin
+.br
+/usr/bin
+.br
+/usr/sbin
+.br
+/usr/local/bin
+.br
+/usr/local/sbin
+.br
+/usr/X11/bin
+.br
+/usr/bin/X11
+.br
+/usr/local/X11/bin
+.br
+/usr/TeX/bin
+.br
+/usr/tex/bin
+.br
+/usr/games
+.br
+/usr/local/games
+.SH AUTHORS
+Nicolai Langfeldt, Michael Shields, Sami Kerola.
diff --git a/misc-utils/chkdupexe.c b/misc-utils/chkdupexe.c
new file mode 100644
index 0000000..9dca5e4
--- /dev/null
+++ b/misc-utils/chkdupexe.c
@@ -0,0 +1,307 @@
+/* chkdupexe - find duplicate executables
+ * Copyright 2012 Sami Kerola <kerolasa@iki.fi>
+ *
+ * This is replacement of chkdupexe.pl.  The following persons where
+ * listed as developers of the perl version of the command.
+ *
+ * Copyright 1993 Nicolai Langfeldt. janl@math.uio.no
+ * Modified 1995-07-04 Michael Shields <shields@tembel.org>
+ * Modified 1996-02-16 Nicolai Langfeldt (janl@math.uio.no)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <assert.h>
+#include <dirent.h>
+#include <getopt.h>
+#include <grp.h>
+#include <pwd.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "c.h"
+#include "nls.h"
+#include "pathnames.h"
+#include "strutils.h"
+#include "xalloc.h"
+
+#define INIT_EXEC_NRO 1024
+
+struct search_paths {
+	char *dir;
+	struct search_paths *next;
+};
+struct execs {
+	struct search_paths *path;
+	char *file;
+};
+
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
+{
+	fprintf(out, USAGE_HEADER);
+	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
+	fprintf(out, USAGE_OPTIONS);
+	fprintf(out, USAGE_HELP);
+	fprintf(out, USAGE_VERSION);
+	fprintf(out, USAGE_MAN_TAIL("chkdupexe(1)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+static struct dirent *xreaddir(DIR * dp)
+{
+	struct dirent *d;
+	assert(dp);
+	while ((d = readdir(dp))) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		/* blacklist here? */
+		break;
+	}
+	return d;
+}
+
+static int is_uniq_path(struct search_paths *sp, char *needle)
+{
+	struct search_paths *browse;
+	for (browse = sp; browse->next != NULL; browse = browse->next)
+		if (strcmp(browse->dir, needle) == 0)
+			return 0;
+	return 1;
+}
+
+struct search_paths *add_paths(struct search_paths *sp,
+			       struct search_paths *sp_continue, char *ent)
+{
+	struct search_paths *fill;
+	char *colon;
+
+	if (sp_continue != NULL)
+		fill = sp_continue;
+	else
+		fill = sp;
+	while ((colon = strchr(ent, ':')) != NULL) {
+		*colon = '\0';
+		if (is_uniq_path(sp, ent)) {
+			fill->dir = xstrdup(ent);
+			fill->next = xmalloc(sizeof(struct search_paths));
+			fill = fill->next;
+			fill->next = NULL;
+			fill->dir = NULL;
+		}
+		ent = colon + 1;
+	}
+	return fill;
+}
+
+static void create_paths(struct search_paths *sp)
+{
+	char *ent;
+	struct search_paths *sp_continue = sp;
+
+	ent = getenv("PATH");
+	if (ent != NULL) {
+		ent = xstrdup(ent);
+		sp_continue = add_paths(sp, NULL, ent);
+		free(ent);
+	}
+	ent = xstrdup(_PATH_CHKDUPEXE);
+	add_paths(sp, sp_continue, ent);
+	free(ent);
+	return;
+}
+
+static unsigned long browse_path(struct search_paths *sp,
+				 struct execs ***orig_el)
+{
+	struct search_paths *sp_next;
+	DIR *dir;
+	struct dirent *d;
+	struct execs **el = *orig_el;
+	unsigned long nel = 0, allocated = INIT_EXEC_NRO;
+
+	for (sp_next = sp; sp_next->next != NULL; sp_next = sp_next->next) {
+		dir = opendir(sp_next->dir);
+		while (dir != NULL && (d = xreaddir(dir))) {
+			if (d->d_type == DT_LNK) {
+				struct stat statbuf;
+				int s;
+				char *fp;
+				xasprintf(&fp, "%s/%s", sp_next->dir, d->d_name);
+				s = stat(fp, &statbuf);
+				if (s < 0)
+					printf(_("Dangling symlink: %s\n"), fp);
+				free(fp);
+			}
+			if (d->d_type == DT_REG) {
+				el[nel] = xmalloc(sizeof(struct execs));
+				el[nel]->path = sp_next;
+				el[nel]->file = xstrdup(d->d_name);
+				nel++;
+				if (allocated < nel) {
+					allocated *= 2;
+					el = xrealloc(el,
+						      (sizeof(struct execs *)
+						       * allocated));
+				}
+			}
+		}
+		closedir(dir);
+	}
+	*orig_el = el;
+	return nel;
+}
+
+static int exec_name_cmp(const void *restrict x, const void *restrict y)
+{
+	struct execs *a = *(struct execs * const *)x;
+	struct execs *b = *(struct execs * const *)y;
+	return strcmp(a->file, b->file);
+}
+
+static int found_ent(struct execs *a)
+{
+	/* FIXME: this function should probably use lib/tt.c */
+	char *ap;
+	struct stat as;
+	int ret;
+	char md[11];
+	struct passwd *login;
+	struct group *group;
+	/* lenght ds[13] usually works, but there is hu_HU locale
+	 * which has 4 letters in month abbreviation, so better to
+	 * have few chars extra. */
+	char ds[17];
+	struct timeval now;
+	time_t then, curtime;
+	struct tm *tm;
+
+	gettimeofday(&now, NULL);
+	curtime = now.tv_sec;
+	xasprintf(&ap, "%s/%s", a->path->dir, a->file);
+	ret = stat(ap, &as);
+	if (ret < 0) {
+		warn(_("cannot stat file %s"), ap);
+		return -1;
+	}
+	then = as.st_mtime;
+	tm = localtime(&(as.st_mtime));
+	strmode(as.st_mode, md);
+	/* FIXME: use namei uid/gid caching. Add necessary functions
+	 * to to lib.  */
+	login = getpwuid(as.st_uid);
+	group = getgrgid(as.st_gid);
+
+	printf("%s %zu", md, as.st_nlink);
+	if (login != NULL)
+		printf(" %s", login->pw_name);
+	else
+		printf(" %du", as.st_uid);
+	if (group != NULL)
+		printf(" %s", group->gr_name);
+	else
+		printf(" %du", as.st_gid);
+	printf(" %8zu", as.st_size);
+	/* Just like 'ls -l' print time, if file mtime is newer than
+	 * 6 months.  The 6 x 31 is not quite right, but perhaps
+	 * good enough(?) */
+	if ((curtime - (6 * 31 * 24 * 60 * 60)) < then)
+		strftime(ds, sizeof(ds), "%b %e %H:%M", tm);
+	else
+		strftime(ds, sizeof(ds), "%b %e  %Y", tm);
+	printf(" %s %s\n", ds, ap);
+
+	free(ap);
+	return 0;
+}
+
+static void print_dublicates(struct execs **el, unsigned long nel)
+{
+	unsigned long i;
+
+	qsort(el, (size_t) nel, sizeof(struct execs *), exec_name_cmp);
+	for (i = 1; i < nel; i++) {
+		if (strcmp(el[i - 1]->file, el[i]->file) == 0) {
+			if (found_ent(el[i - 1]) == 0)
+				found_ent(el[i]);
+		}
+	}
+	return;
+}
+
+static void cleanup(struct search_paths *sp_orig, struct execs **el,
+		    unsigned long nel)
+{
+	struct search_paths *sp = sp_orig;
+	struct search_paths *prev = NULL;
+	unsigned long i;
+	do {
+		free(sp->dir);
+		if (prev != NULL)
+			free(prev);
+		prev = sp;
+		sp = sp->next;
+	} while (sp != NULL);
+	free(prev);
+	for (i = 0; i < nel; i++) {
+		free(el[i]->file);
+		free(el[i]);
+	}
+	free(el);
+	return;
+}
+
+int main(int argc, char **argv)
+{
+	struct search_paths *sp;
+	struct execs **el;
+	unsigned long nel;
+	int c;
+	static const struct option longopts[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	while ((c = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
+		switch (c) {
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
+
+	sp = xmalloc(sizeof(struct search_paths));
+	sp->dir = NULL;
+	sp->next = NULL;
+	el = xmalloc(sizeof(struct execs *) * INIT_EXEC_NRO);
+
+	create_paths(sp);
+	nel = browse_path(sp, &el);	/* prints dangling symlinks, if detected */
+	print_dublicates(el, nel);
+	cleanup(sp, el, nel);
+
+	return EXIT_SUCCESS;
+}
diff --git a/misc-utils/chkdupexe.pl b/misc-utils/chkdupexe.pl
deleted file mode 100755
index c2c2384..0000000
--- a/misc-utils/chkdupexe.pl
+++ /dev/null
@@ -1,120 +0,0 @@
-#!@PERL@ -w
-#
-# chkdupexe version 2.1.1
-#
-# Simple script to look for and list duplicate executables and dangling
-# symlinks in the system executable directories.
-#
-# Copyright 1993 Nicolai Langfeldt. janl@math.uio.no
-#  Distribute under gnu copyleft (included in perl package) 
-#
-# Modified 1995-07-04 Michael Shields <shields@tembel.org>
-#     Don't depend on GNU ls.
-#     Cleanups.
-#     Merge together $ENV{'PATH'} and $execdirs.
-#     Don't break if there are duplicates in $PATH.
-#
-# Modified 1996-02-16 Nicolai Langfeldt (janl@math.uio.no).
-#     I was thinking admins would edit the $execdirs list to suit their
-#     machine(s) when I wrote this.  This is ofcourse not the case, thus
-#     Michaels fixes.  And my fixes to his :-)
-#     - Working duplicate dirs detection.
-#     - Added more checks
-#     - Took out $PATH from the list of checked directories and added a
-#	check for $execdirs and $PATH consistency instead
-#     - Made it possible to run with perl -w
-
-$execdirs='/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin '.
-  '/usr/X11/bin /usr/bin/X11 /usr/local/X11/bin '.
-  '/usr/TeX/bin /usr/tex/bin /usr/games '.
-  '/usr/local/games';
-
-# Turn off buffering for the output channel.
-$|=1;
-
-# Values from /usr/include/linux/errno.h.  Existence of linux/errno.ph is not
-# something to count on... :-(
-$ENOENT=2;
-
-%didthis=();
-
-foreach $dir (split(/\s+/, "$execdirs"), "\0", split(/:/, $ENV{PATH})) {
-
-  if ($dir eq "\0") { $checkingpath = 1; next; }
-
-  # It's like this: One directory corresponds to one $device,$inode tuple
-  # If a symlink points to a directory we already checked that directory
-  # will have the same $device,$inode tuple.
-
-  # Does this directory have any real exstence outside the ravings of
-  # symlinks pointing hither and dither?
-  ($device,$inode)=stat($dir); 
-  if (!defined($device)) {
-    # Nonexistant directory, or dangling symlink?
-    ($dum)=lstat($dir);
-    next if $! == $ENOENT;
-    if (!$dum) {
-      print "Dangling symlink: $dir\n";
-      next;
-    }
-    warn "Nonexistent directory: $dir\n" if ($checkingpath);
-    next;
-  }
-
-  if (!-d _) {
-    print "Not a directory: $dir\n";
-    next;
-  }
-
-  next if defined($didthis{$device,$inode});
-
-  $didthis{$device,$inode}=1;
-
-  chdir($dir) || die "Could not chdir $dir: $!\n";
-# This would give us the true directory name, do we want that?
-#  chop($dir=`pwd`);
-  opendir(DIR,".") || 
-    die "NUTS! Personaly I think your perl or filesystem is broken.\n".
-      "I've done all sorts of checks on $dir, and now I can't open it!\n";
-  foreach $_ (readdir(DIR)) {
-    lstat($_);
-    if (-l _) {
-      ($dum)=stat($_);
-      print "Dangling symlink: $dir/$_\n" unless defined($dum);
-      next;
-    }
-    next unless -f _ && -x _;	# Only handle regular executable files
-    if (defined($count{$_})) {
-      $progs{$_}.=" $dir/$_";
-      $count{$_}++;
-    } else {
-      $progs{$_}="$dir/$_";
-      $count{$_}=1;
-    }
-  }
-  closedir(DIR);
-}
-
-open(LS,"| xargs -r ls -ldU");
-while (($prog,$paths)=each %progs) {
-  print LS "$paths\n" if ($count{$prog}>1);
-}
-close(LS);
-
-exit 0;
-
-@unchecked=();
-# Check if the users PATH contains something I've not checked. The site admin
-# might want to know about inconsistencies in user PATHs and chkdupexec 
-# configuration
-foreach $dir (split(/:/,$ENV{'PATH'})) {
-  ($device,$inode)=stat($dir);
-  next unless defined($device);
-  next if defined($didthis{$device,$inode});
-  push(@unchecked,$dir);
-  $didthis{$device,$inode}=1;
-}
-
-print "Warning: Your path contains these directories which chkdupexe has not checked:\n",join(',',@unchecked),
-  ".\nPlease review the execdirs list in chkdupexe.\n"
-    if ($#unchecked>=$[);
-- 
1.7.9.5

