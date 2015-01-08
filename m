Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38629 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630AbbAHLOA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Jan 2015 06:14:00 -0500
Date: Thu, 8 Jan 2015 12:13:54 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [RFC][PATCH] unshare: Fix --map-root-user to work on new kernels
Message-ID: <20150108111354.GJ15715@x2.net.home>
References: <87zjalkhb8.fsf@x220.int.ebiederm.org>
 <87sigdkglg.fsf@x220.int.ebiederm.org>
 <20141219100749.GJ19904@x2.net.home>
 <87a92j4yde.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a92j4yde.fsf@x220.int.ebiederm.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 19, 2014 at 06:28:45AM -0600, Eric W. Biederman wrote:
> >  IMHO it's good idea to make it possible to control this feature by
> >  unshare util.
> 
> Fair enough.  A general control is reasonable, and not hard to support.
> Call it --setgroups=[allow|deny].

Implemented. Please, review. 

Note that I'm not sure if the description in the man page is good enough for 
end users (it's mostly copy & past from previous Eric's email:-).

    Karel


>From 0226ca0734065fe29cb9dbc4a48ed6a9b5640995 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Thu, 8 Jan 2015 11:51:58 +0100
Subject: [PATCH] unshare: add --setgroups=deny|allow

Since Linux 3.19 the file /proc/self/setgroups controls setgroups(2)
syscall usage in user namespaces. This patch provides command line knob
for this feature.

The new --setgroups does not automatically implies --user to avoid
complexity, it's user's responsibility to use it in right context. The
exception is --map-root-user which is mutually exclusive to
--setgroups=allow.

CC: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/unshare.1 | 17 ++++++++++++++++-
 sys-utils/unshare.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 1aa9bcb..f9626fc 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -83,8 +83,23 @@ Run the program only after the current effective user and group IDs have been ma
 the superuser UID and GID in the newly created user namespace.  This makes it possible to
 conveniently gain capabilities needed to manage various aspects of the newly created
 namespaces (such as configuring interfaces in the network namespace or mounting filesystems in
-the mount namespace) even when run unprivileged.  As a mere convenience feature, it does not support
+the mount namespace) even when run unprivileged.  As a more convenience feature, it does not support
 more sophisticated use cases, such as mapping multiple ranges of UIDs and GIDs.
+This option implies --setgroups=deny.
+.TP
+.BR \-s , " \-\-setgroups \fIallow|deny\fP"
+Allow or deny
+.BR setgroups (2)
+syscall in user namespaces.
+
+.BR setgroups(2)
+is only callable with CAP_SETGID and CAP_SETGID in a user
+namespace (since Linux 3.19) does not give you permission to call setgroups(2)
+until after GID map has been set. The GID map is writable by root when
+.BR setgroups(2)
+is enabled and GID map becomes writable by unprivileged processes when
+.BR setgroups(2)
+is permamently disabled.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 9fdce93..11e2e6b 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -39,12 +39,39 @@
 #include "pathnames.h"
 #include "all-io.h"
 
-static void disable_setgroups(void)
+enum {
+	SETGROUPS_NONE = -1,
+	SETGROUPS_DENY = 0,
+	SETGROUPS_ALLOW = 1,
+};
+
+static const char *setgroups_strings[] =
+{
+	[SETGROUPS_DENY] = "deny",
+	[SETGROUPS_ALLOW] = "allow"
+};
+
+static int setgroups_str2id(const char *str)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(setgroups_strings); i++)
+		if (strcmp(str, setgroups_strings[i]) == 0)
+			return i;
+
+	errx(EXIT_FAILURE, _("unsupported --setgroups argument '%s'"), str);
+}
+
+static void setgroups_control(int action)
 {
 	const char *file = _PATH_PROC_SETGROUPS;
-	const char *deny = "deny";
+	const char *cmd;
 	int fd;
 
+	if (action < 0 || (size_t) action >= ARRAY_SIZE(setgroups_strings))
+		return;
+	cmd = setgroups_strings[action];
+
 	fd = open(file, O_WRONLY);
 	if (fd < 0) {
 		if (errno == ENOENT)
@@ -52,7 +79,7 @@ static void disable_setgroups(void)
 		 err(EXIT_FAILURE, _("cannot open %s"), file);
 	}
 
-	if (write_all(fd, deny, strlen(deny)))
+	if (write_all(fd, cmd, strlen(cmd)))
 		err(EXIT_FAILURE, _("write failed %s"), file);
 	close(fd);
 }
@@ -94,6 +121,7 @@ static void usage(int status)
 	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
 	fputs(_("     --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
+	fputs(_(" -s, --setgroups <allow|deny>  control setgroups syscall in user namespaces\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -120,9 +148,11 @@ int main(int argc, char *argv[])
 		{ "fork", no_argument, 0, 'f' },
 		{ "mount-proc", optional_argument, 0, OPT_MOUNTPROC },
 		{ "map-root-user", no_argument, 0, 'r' },
+		{ "setgroups", required_argument, 0, 's' },
 		{ NULL, 0, 0, 0 }
 	};
 
+	int setgrpcmd = SETGROUPS_NONE;
 	int unshare_flags = 0;
 	int c, forkit = 0, maproot = 0;
 	const char *procmnt = NULL;
@@ -134,7 +164,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "+fhVmuinpUr", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "+fhVmuinpUrs:", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'f':
 			forkit = 1;
@@ -170,6 +200,9 @@ int main(int argc, char *argv[])
 			unshare_flags |= CLONE_NEWUSER;
 			maproot = 1;
 			break;
+		case 's':
+			setgrpcmd = setgroups_str2id(optarg);
+			break;
 		default:
 			usage(EXIT_FAILURE);
 		}
@@ -199,10 +232,20 @@ int main(int argc, char *argv[])
 	}
 
 	if (maproot) {
-		disable_setgroups();
+		if (setgrpcmd == SETGROUPS_ALLOW)
+			errx(EXIT_FAILURE, _("options --setgroups=allow and "
+					"--map-root-user are mutually exclusive."));
+
+		/* since Linux 3.19 unprivileged writing of /proc/self/gid_map
+		 * has s been disabled unless /proc/self/setgroups is written
+		 * first to permanently disable the ability to call setgroups
+		 * in that user namespace. */
+		setgroups_control(SETGROUPS_DENY);
 		map_id(_PATH_PROC_UIDMAP, 0, real_euid);
 		map_id(_PATH_PROC_GIDMAP, 0, real_egid);
-	}
+
+	} else if (setgrpcmd != SETGROUPS_NONE)
+		setgroups_control(setgrpcmd);
 
 	if (procmnt &&
 	    (mount("none", procmnt, NULL, MS_PRIVATE|MS_REC, NULL) != 0 ||
-- 
1.9.3


