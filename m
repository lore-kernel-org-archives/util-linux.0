Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41328 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbaG2LXO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 07:23:14 -0400
Date: Tue, 29 Jul 2014 13:23:00 +0200
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: bobtfish@bobtfish.net, util-linux@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] Setting uid / gid is generally useful in nseneter
Message-ID: <20140729112300.GV8533@x2.net.home>
References: <1406406174-20938-1-git-send-email-bobtfish@bobtfish.net>
 <20140728115630.GJ8533@x2.net.home>
 <874my1xp4l.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874my1xp4l.fsf@x220.int.ebiederm.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 28, 2014 at 12:24:58PM -0700, Eric W. Biederman wrote:
> Thinking out loud.  Calling setuid(0) and setgid(0) in nsenter solves a
> very practical problem of losing all capabilities on exec (because your
> uid != 0).  Adding --setuid and --setgid is necessary because some
> user namespaces do not have uid 0 or gid 0 mapped so switching to
> those uids and gids would fail.

 OK, I have improved --setuid and --setguid, so now it's usable for
 all namespaces (originally it was only for user namespaces). The
 default is still 0 for user namepaces..
 
 The patch is below.

> So the direction I could see this nsenter evolving is reading the
> default uid and gid from the target process (A pain when in the case of

 That's nice idea, added to TODO.

> user namespaces because the value uid and gid will need to be mapped
> into the target user namespace).

 yep

    Karel

>From 47f42c1d14901b8bc2eb477fb0082bcbdd5e79af Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Tue, 29 Jul 2014 13:07:44 +0200
Subject: [PATCH] nsenter: allow to use --set{uid,gid} for all namespaces

Now it's possible to set UID and GID for user namespaces only. This
patch removes this restriction and allow to use --set{uid,gid} in all
cases. The default for user namespaces is still GID=0, UID=0.

Reported-by: Tomas Doran <bobtfish@bobtfish.net>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/nsenter.1 |  9 +++++++--
 sys-utils/nsenter.c | 20 +++++++++++++-------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 998fd0c..487f731 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -126,10 +126,15 @@ the target process.  If file is specified, enter the user namespace specified by
 file.  See also the \fB\-\-setuid\fR and \fB\-\-setgid\fR options.
 .TP
 \fB\-G\fR, \fB\-\-setgid\fR \fIgid\fR
-Set the group ID which will be used in the entered user namespace.
+Set the group ID which will be used in the entered namespace and drop
+supplementary groups.
+.BR nsenter (1)
+always sets GID for user namespaces, the default is 0.
 .TP
 \fB\-S\fR, \fB\-\-setuid\fR \fIuid\fR
-Set the user ID which will be used in the entered user namespace.
+Set the user ID which will be used in the entered namespace.
+.BR nsenter (1)
+always sets UID for user namespaces, the default is 0.
 .TP
 \fB\-r\fR, \fB\-\-root\fR[=\fIdirectory\fR]
 Set the root directory.  If no directory is specified, set the root directory to
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index d57edc8..87c6549 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -73,8 +73,8 @@ static void usage(int status)
 	fputs(_(" -n, --net   [=<file>]  enter network namespace\n"), out);
 	fputs(_(" -p, --pid   [=<file>]  enter pid namespace\n"), out);
 	fputs(_(" -U, --user  [=<file>]  enter user namespace\n"), out);
-	fputs(_(" -S, --setuid <uid>     set uid in user namespace\n"), out);
-	fputs(_(" -G, --setgid <gid>     set gid in user namespace\n"), out);
+	fputs(_(" -S, --setuid <uid>     set uid in entered namespace\n"), out);
+	fputs(_(" -G, --setgid <gid>     set gid in entered namespace\n"), out);
 	fputs(_(" -r, --root  [=<dir>]   set the root directory\n"), out);
 	fputs(_(" -w, --wd    [=<dir>]   set the working directory\n"), out);
 	fputs(_(" -F, --no-fork          do not fork before exec'ing <program>\n"), out);
@@ -182,7 +182,7 @@ int main(int argc, char *argv[])
 
 	struct namespace_file *nsfile;
 	int c, namespaces = 0;
-	bool do_rd = false, do_wd = false;
+	bool do_rd = false, do_wd = false, force_uid = false, force_gid = false;
 	int do_fork = -1; /* unknown yet */
 	uid_t uid = 0;
 	gid_t gid = 0;
@@ -243,9 +243,11 @@ int main(int argc, char *argv[])
 			break;
 		case 'S':
 			uid = strtoul_or_err(optarg, _("failed to parse uid"));
+			force_uid = true;
 			break;
 		case 'G':
 			gid = strtoul_or_err(optarg, _("failed to parse gid"));
+			force_gid = true;
 			break;
 		case 'F':
 			do_fork = 0;
@@ -328,12 +330,16 @@ int main(int argc, char *argv[])
 	if (do_fork == 1)
 		continue_as_child();
 
-	if (namespaces & CLONE_NEWUSER) {
-		if (setgroups(0, NULL))		/* drop supplementary groups */
+	/* for user namespaces we always set UID and GID (default is 0) */
+	if (namespaces & CLONE_NEWUSER)
+		force_uid = true, force_gid = true;
+
+	if (force_uid || force_gid) {
+		if (force_gid && setgroups(0, NULL))		/* drop supplementary groups */
 			err(EXIT_FAILURE, _("setgroups failed"));
-		if (setgid(gid) < 0)
+		if (force_gid && setgid(gid) < 0)		/* change GID */
 			err(EXIT_FAILURE, _("setgid failed"));
-		if (setuid(uid) < 0)
+		if (force_uid && setuid(uid) < 0)		/* change UID */
 			err(EXIT_FAILURE, _("setuid failed"));
 	}
 
-- 
1.9.3

