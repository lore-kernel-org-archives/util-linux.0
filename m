Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713Ab3GALkS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Jul 2013 07:40:18 -0400
Date: Mon, 1 Jul 2013 13:40:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org, ebiederm@xmission.com, mtk.manpages@gmail.com
Subject: Re: [PATCH/RFC] unshare: add --fork/--mount-proc options for pid
 namespaces
Message-ID: <20130701114008.GA1946@x2.net.home>
References: <1372377898-2602-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372377898-2602-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 27, 2013 at 08:04:58PM -0400, Mike Frysinger wrote:
> When it comes to pid namespaces, it's also useful for /proc to reflect
> the current namespace.  Again, this is easy to pull off, but annoying
> to force everyone to do it themselves.  So let's add a --mount-proc to
> do the magic for us.  

 This is not so easy. For example on Fedora 18 the default is "shared":

 # grep /proc /proc/self/mountinfo
 14 33 0:3 / /proc rw,nosuid,nodev,noexec,relatime shared:5 - proc proc rw
 
 it means that unshare( CLONE_NEWNS ) has no expected effect and the
 following mount(/proc) has horrible impact for all system. You have
 to use (for example):

    mount --make-rprivate /proc
    unshare --fork --mount-proc --pid

 The --fork option makes sense, but I have doubts about --mount-proc.

 It would be better to keep unshare(1) simple and stupid rather than
 expect that we can setup usable container by the util.

 It's easy to call "mount proc /proc -t proc" after "unshare --pid
 --mount --fork".

> -	if (optind < argc) {
> -		execvp(argv[optind], argv + optind);
> -		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> +	pid = forkit ? fork() : 1;
^^^^^^^^^^^^^^^^^^^^^^^^^^
> +	if (pid == 0) {
> +		/* child */
> +		if (mount_proc && mount("proc", "/proc", "proc", 0, NULL))
> +			err(EXIT_FAILURE, _("mount(/proc) failed"));
> +		if (optind < argc) {
> +			execvp(argv[optind], argv + optind);
> +			err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> +		}
> +		exec_shell();
> +	} else {
> +		/* parent */
> +		int status;
> +		if (waitpid(pid, &status, 0) == -1)
> +			err(EXIT_FAILURE, _("waitpid failed"));
> +		if (WIFEXITED(status))
> +			return WEXITSTATUS(status);
> +		else if (WIFSIGNALED(status))
> +			kill(getpid(), WTERMSIG(status));
> +		/* still here !? */
> +		err(EXIT_FAILURE, _("child exit failed"));
>  	}
> -	exec_shell();
>  }

 I guess it's bug that exec_shell() only when forkit is set and
 waitpid() is called always.

 See the patch below. 

    Karel



>From 535b754f0003b60b9d7c0358cc4366fae169dd19 Mon Sep 17 00:00:00 2001
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Jun 2013 20:04:58 -0400
Subject: [PATCH] unshare: add --fork options for pid namespaces

The ability of unshare to launch a new pid namespace is a bit limited.
The first process in the namespace is expected to be the "init" for it.
When it's not, you get bad behavior.

For example, trying to launch a shell in a new pid namespace fails very
quickly:
	$ sudo unshare -p dash
	# uname -r
	3.8.3
	# uname -m
	dash: 2: Cannot fork
	# ls -ld /
	dash: 3: Cannot fork
	# echo $$
	1324

For this to work smoothly, we need an init process to actively watch over
things.  But forcing people to re-use an existing init or write their own
mini init is a bit overkill.  So let's add a --fork option to unshare to
do this common bit of book keeping.  Now we can do:
	$ sudo unshare -p --fork dash
	# uname -r
	3.8.3
	# uname -m
	x86_64
	# ls -ld /
	drwxr-xr-x 22 root root 4096 May  4 14:01 /
	# echo $$
	1

Thanks to Michael Kerrisk for his namespace articles on lwn.net

[kzak@redhat.com: - fix "forkif logic, remove --mount-proc]

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/unshare.1 |  6 +++++-
 sys-utils/unshare.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index bd0f13e..c387ceb 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -56,13 +56,17 @@ Unshare the mount namespace.
 Unshare the network namespace.
 .TP
 .BR \-p , " \-\-pid"
-Unshare the pid namespace.
+Unshare the pid namespace. See also \fB--fork\fP option.
 .TP
 .BR \-u , " \-\-uts"
 Unshare the UTS namespace.
 .TP
 .BR \-U , " \-\-user"
 Unshare the user namespace.
+.TP
+.BR \-f , " \-\-fork"
+Fork the specified process as a child of unshare rather than running it
+directly.  This is useful when creating a new pid namespace.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2)
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 8cc9c46..a889eee 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -24,6 +24,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/wait.h>
 
 #include "nls.h"
 #include "c.h"
@@ -46,6 +47,7 @@ static void usage(int status)
 	fputs(_(" -n, --net         unshare network namespace\n"), out);
 	fputs(_(" -p, --pid         unshare pid namespace\n"), out);
 	fputs(_(" -U, --user        unshare user namespace\n"), out);
+	fputs(_(" -f, --fork        fork before launching <program>\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -66,20 +68,23 @@ int main(int argc, char *argv[])
 		{ "net", no_argument, 0, 'n' },
 		{ "pid", no_argument, 0, 'p' },
 		{ "user", no_argument, 0, 'U' },
+		{ "fork", no_argument, 0, 'f' },
 		{ NULL, 0, 0, 0 }
 	};
 
 	int unshare_flags = 0;
-
-	int c;
+	int c, forkit = 0;
 
 	setlocale(LC_MESSAGES, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "hVmuinpU", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "fhVmuinpU", longopts, NULL)) != -1) {
 		switch (c) {
+		case 'f':
+			forkit = 1;
+			break;
 		case 'h':
 			usage(EXIT_SUCCESS);
 		case 'V':
@@ -111,6 +116,26 @@ int main(int argc, char *argv[])
 	if (-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
+	if (forkit) {
+		int status;
+		pid_t pid = fork();
+
+		switch(pid) {
+		case -1:
+			err(EXIT_FAILURE, _("fork failed"));
+		case 0:	/* child */
+			break;
+		default: /* parent */
+			if (waitpid(pid, &status, 0) == -1)
+				err(EXIT_FAILURE, _("waitpid failed"));
+			if (WIFEXITED(status))
+				return WEXITSTATUS(status);
+			else if (WIFSIGNALED(status))
+				kill(getpid(), WTERMSIG(status));
+			err(EXIT_FAILURE, _("child exit failed"));
+		}
+	}
+
 	if (optind < argc) {
 		execvp(argv[optind], argv + optind);
 		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
-- 
1.8.1.4

