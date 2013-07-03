Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15700 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708Ab3GCKgn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Jul 2013 06:36:43 -0400
Date: Wed, 3 Jul 2013 12:36:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org, ebiederm@xmission.com, mtk.manpages@gmail.com
Subject: Re: [PATCH/RFC] unshare: add --fork/--mount-proc options for pid
 namespaces
Message-ID: <20130703103635.GA722@x2.net.home>
References: <1372377898-2602-1-git-send-email-vapier@gentoo.org>
 <20130701114008.GA1946@x2.net.home>
 <201307011047.05595.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201307011047.05595.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 01, 2013 at 10:47:04AM -0400, Mike Frysinger wrote:
> On Monday 01 July 2013 07:40:08 Karel Zak wrote:
> > On Thu, Jun 27, 2013 at 08:04:58PM -0400, Mike Frysinger wrote:
> > > When it comes to pid namespaces, it's also useful for /proc to reflect
> > > the current namespace.  Again, this is easy to pull off, but annoying
> > > to force everyone to do it themselves.  So let's add a --mount-proc to
> > > do the magic for us.
> > 
> >  This is not so easy. For example on Fedora 18 the default is "shared":
> > 
> >  # grep /proc /proc/self/mountinfo
> >  14 33 0:3 / /proc rw,nosuid,nodev,noexec,relatime shared:5 - proc proc rw
> > 
> >  it means that unshare( CLONE_NEWNS ) has no expected effect and the
> >  following mount(/proc) has horrible impact for all system. You have
> >  to use (for example):
> > 
> >     mount --make-rprivate /proc
> >     unshare --fork --mount-proc --pid
> 
> i'm not quite following here.  are you saying that Fedora 18 by default makes 
> it hard to do pid namespaces ?  

 /proc does not have to be private. You have to call

    mount("none", "/proc", NULL, MS_PRIVATE|MS_REC, NULL);

 to be sure that unshare(CLONE_NEWNS) makes any effect. It's mistake
 to blindly call 

    unshare( CLONE_NEWNS );
    mount("proc, "/proc", "proc", 0, NULL);

 If we want to add --mount-proc to unshare(1) than the implementation has to 
 be robust. Your current patch is dangerous on systems where /proc is shared.

 It would be also nice to support optional argument to specify the
 mountpoint --mount-proc[=<mountpoint>].

 See the patch below -- works for me.

    Karel


>From 03719f39f83770af7dc1f6fca38c6c1deb98d84c Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Wed, 3 Jul 2013 12:28:16 +0200
Subject: [PATCH] unshare: add --mount-proc for pid namespaces

Based on patch from Mike Frysinger <vapier@gentoo.org>.

Mike Frysinger wrote:
 When it comes to pid namespaces, it's also useful for /proc to reflect
 the current namespace.  Again, this is easy to pull off, but annoying
 to force everyone to do it themselves.  So let's add a --mount-proc to
 do the magic for us.  The downside is that this also implies creating
 a mount namespace as mounting the new pid namespace /proc over top the
 system one will quickly break all other processes on the system.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/unshare.1 |  8 +++++++-
 sys-utils/unshare.c | 30 +++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index c387ceb..dfd4189 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -56,7 +56,7 @@ Unshare the mount namespace.
 Unshare the network namespace.
 .TP
 .BR \-p , " \-\-pid"
-Unshare the pid namespace. See also \fB--fork\fP option.
+Unshare the pid namespace. See also \fB--fork\fP and \fB--mount-proc\fP options.
 .TP
 .BR \-u , " \-\-uts"
 Unshare the UTS namespace.
@@ -67,6 +67,12 @@ Unshare the user namespace.
 .BR \-f , " \-\-fork"
 Fork the specified process as a child of unshare rather than running it
 directly.  This is useful when creating a new pid namespace.
+.TP
+.BR "\fB\-\-mount-proc\fR [=\fImountpoint\fP]"
+Just before running the program, mount the proc filesystem at the \fImountpoint\fP
+(default is /proc).  This is useful when creating a new pid namespace.  It also
+implies creating a new mount namespace since the /proc mount would otherwise
+mess up existing programs on the system.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2)
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index a889eee..a64b776 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/wait.h>
+#include <sys/mount.h>
 
 #include "nls.h"
 #include "c.h"
@@ -41,13 +42,14 @@ static void usage(int status)
 	      _(" %s [options] <program> [args...]\n"),	program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -m, --mount       unshare mounts namespace\n"), out);
-	fputs(_(" -u, --uts         unshare UTS namespace (hostname etc)\n"), out);
-	fputs(_(" -i, --ipc         unshare System V IPC namespace\n"), out);
-	fputs(_(" -n, --net         unshare network namespace\n"), out);
-	fputs(_(" -p, --pid         unshare pid namespace\n"), out);
-	fputs(_(" -U, --user        unshare user namespace\n"), out);
-	fputs(_(" -f, --fork        fork before launching <program>\n"), out);
+	fputs(_(" -m, --mount               unshare mounts namespace\n"), out);
+	fputs(_(" -u, --uts                 unshare UTS namespace (hostname etc)\n"), out);
+	fputs(_(" -i, --ipc                 unshare System V IPC namespace\n"), out);
+	fputs(_(" -n, --net                 unshare network namespace\n"), out);
+	fputs(_(" -p, --pid                 unshare pid namespace\n"), out);
+	fputs(_(" -U, --user                unshare user namespace\n"), out);
+	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
+	fputs(_("     --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -59,6 +61,9 @@ static void usage(int status)
 
 int main(int argc, char *argv[])
 {
+	enum {
+		OPT_MOUNTPROC = CHAR_MAX + 1
+	};
 	static const struct option longopts[] = {
 		{ "help", no_argument, 0, 'h' },
 		{ "version", no_argument, 0, 'V'},
@@ -69,11 +74,13 @@ int main(int argc, char *argv[])
 		{ "pid", no_argument, 0, 'p' },
 		{ "user", no_argument, 0, 'U' },
 		{ "fork", no_argument, 0, 'f' },
+		{ "mount-proc", optional_argument, 0, OPT_MOUNTPROC },
 		{ NULL, 0, 0, 0 }
 	};
 
 	int unshare_flags = 0;
 	int c, forkit = 0;
+	const char *procmnt = NULL;
 
 	setlocale(LC_MESSAGES, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -108,6 +115,10 @@ int main(int argc, char *argv[])
 		case 'U':
 			unshare_flags |= CLONE_NEWUSER;
 			break;
+		case OPT_MOUNTPROC:
+			unshare_flags |= CLONE_NEWNS;
+			procmnt = optarg ? optarg : "/proc";
+			break;
 		default:
 			usage(EXIT_FAILURE);
 		}
@@ -136,6 +147,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (procmnt &&
+	    (mount("none", procmnt, NULL, MS_PRIVATE|MS_REC, NULL) != 0 ||
+	     mount("proc", procmnt, "proc", MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0))
+			err(EXIT_FAILURE, _("mount %s failed"), procmnt);
+
 	if (optind < argc) {
 		execvp(argv[optind], argv + optind);
 		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
-- 
1.8.1.4

