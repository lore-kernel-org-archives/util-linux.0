Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:57622 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab2LZUJv (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 26 Dec 2012 15:09:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 763F433D781
	for <util-linux-ng@vger.kernel.org>; Wed, 26 Dec 2012 20:09:39 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] flock: improve usage strings
Date: Wed, 26 Dec 2012 15:10:29 -0500
Message-Id: <1356552629-17001-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The current examples miss the best usage of all: specifying the command
and its arguments directly on the command line.  Add that to both the
program usage and the man page.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/flock.1 | 15 +++++++++++++--
 sys-utils/flock.c |  6 +++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index b50c619..b28526f 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -29,10 +29,10 @@
 flock \- manage locks from shell scripts
 .SH SYNOPSIS
 .B flock
-[options] <file> -c <command>
+[options] <file|directory> <command> [command args]
 .br
 .B flock
-[options] <directory> -c <command>
+[options] <file|directory> -c <command>
 .br
 .B flock
 [options] <file descriptor number>
@@ -120,6 +120,9 @@ shell2> flock -s -w .007 /tmp -c echo; /bin/echo $?
 Set shared lock to directory /tmp and the second command will not fail.
 Notice that attempting to get exclusive lock with second command would fail.
 .TP
+shell> flock -x local-lock-file echo 'a b c'
+Grab the exclusive lock "local-lock-file" before running echo with 'a b c'.
+.TP
 (
 .TQ
   flock -n 9 || exit 1
@@ -138,6 +141,14 @@ allows the lockfile to be created if it does not already exist, however,
 write permission is required.  Using
 .I <
 requires that the file already exists but only read permission is required.
+.TP
+[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -en "$0" "$0" "$@" || :
+This is useful boilerplate code for shell scripts.  Put it at the top of the
+shell script you want to lock and it'll automatically lock itself on the first
+run.  If the env var $FLOCKER is not set to the shell script that is being run,
+then execute flock and grab an exclusive non-blocking lock (using the script
+itself as the lock file) before re-execing itself with the right arguments.  It
+also sets the FLOCKER env var to the right value so it doesn't run again.
 .SH "EXIT STATUS"
 The command uses
 .B sysexits.h
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index b514155..50435e0 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -48,9 +48,9 @@ static void __attribute__((__noreturn__)) usage(int ex)
 {
 	fprintf(stderr, USAGE_HEADER);
 	fprintf(stderr,
-		_(" %1$s [options] <file descriptor number>\n"
-		  " %1$s [options] <file> -c <command>\n"
-		  " %1$s [options] <directory> -c <command>\n"),
+		_(" %1$s [options] <file|directory> <command> [command args]\n"
+		  " %1$s [options] <file|directory> -c <command>\n"
+		  " %1$s [options] <file descriptor number>\n"),
 		program_invocation_short_name);
 	fputs(USAGE_OPTIONS, stderr);
 	fputs(_(  " -s  --shared             get a shared lock\n"), stderr);
-- 
1.8.0

