Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yb0-f169.google.com ([209.85.213.169]:34990 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbcKPQjX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 16 Nov 2016 11:39:23 -0500
Received: by mail-yb0-f169.google.com with SMTP id d128so44682468ybh.2
        for <util-linux@vger.kernel.org>; Wed, 16 Nov 2016 08:39:22 -0800 (PST)
From: Jim Patterson <jimp@wegrok.net>
To: util-linux@vger.kernel.org
Cc: Jim Patterson <jimp@wegrok.net>
Subject: [PATCH] wall: add --group option
Date: Wed, 16 Nov 2016 11:32:16 -0500
Message-Id: <1479313936-10018-1-git-send-email-jimp@wegrok.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The wall command on AIX supports a "-g" option to limit the message
to a group of users by gid.  Add compatibility to the Linux version.

Thanks to Sami Kerola <kerolasa@iki.fi> for an initial skeleton
implementation.

Reference: http://www.ibm.com/support/knowledgecenter/ssw_aix_61/com.ibm.aix.cmds6/wall.htm
Signed-off-by: Jim Patterson <jimp@wegrok.net>
---
 bash-completion/wall |  4 ++++
 term-utils/wall.1    |  7 ++++++
 term-utils/wall.c    | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/bash-completion/wall b/bash-completion/wall
index e3145ff..1331e6a 100644
--- a/bash-completion/wall
+++ b/bash-completion/wall
@@ -9,6 +9,10 @@ _wall_module()
 			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
 			return 0
 			;;
+		'-g'|'--group')
+			COMPREPLY=( $(compgen -A 'group' -- $cur) )
+			return 0
+			;;
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
diff --git a/term-utils/wall.1 b/term-utils/wall.1
index 33cd352..a7da195 100644
--- a/term-utils/wall.1
+++ b/term-utils/wall.1
@@ -39,6 +39,8 @@ wall \- write a message to all users
 .RB [ \-n ]
 .RB [ \-t
 .IR timeout ]
+.RB [ \-g
+.IR group ]
 .RI [ message " | " file ]
 .SH DESCRIPTION
 .B wall
@@ -68,6 +70,11 @@ This \fItimeout\fR must be a positive integer.  The default value
 is 300 seconds, which is a legacy from the time when people ran terminals over
 modem lines.
 .TP
+.BR \-g , " \-\-group " \fIgroup\fR
+Limit printing message to members of group defined as a
+.I group
+argument.  The argument can be group name or gid.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .TP
diff --git a/term-utils/wall.c b/term-utils/wall.c
index 4ad94d8..d4b46ba 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -58,6 +58,9 @@
 #include <unistd.h>
 #include <utmp.h>
 #include <getopt.h>
+#include <sys/types.h>
+#include <grp.h>
+#include <linux/sysctl.h>
 
 #include "nls.h"
 #include "xalloc.h"
@@ -96,6 +99,57 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+struct group_workspace {
+	gid_t	requested_group;
+	int	max;
+	gid_t	*groups;
+};
+
+static gid_t get_group_gid(const char *optarg)
+{
+	struct group *gr;
+
+	if ((gr = getgrnam(optarg)))
+		return gr->gr_gid;
+	return strtou64_or_err(optarg, _("invalid group argument"));
+}
+
+static struct group_workspace *init_group_workspace(const char *optarg)
+{
+	struct group_workspace *buf = xmalloc(sizeof(struct group_workspace));
+
+	buf->requested_group = get_group_gid(optarg);
+	buf->max = sysconf(_SC_NGROUPS_MAX) + 1;  // room for the primary gid
+	buf->groups = xcalloc(sizeof(gid_t), buf->max);
+
+	return buf;
+}
+
+static int is_gr_member(const char *login, const struct group_workspace *buf)
+{
+	struct passwd *pw;
+	int max_groups = buf->max;
+	int rc;
+
+	pw = getpwnam(login);
+	if (buf->requested_group == pw->pw_gid)
+		return TRUE;
+
+	rc = getgrouplist(login, pw->pw_gid, buf->groups, &max_groups);
+	if (rc < 0) {
+		/* buffer too small, not sure how this can happen, since
+		   we used sysconf to get the size... */
+		errx(EXIT_FAILURE,
+			_("getgrouplist found more groups than sysconf allows"));
+	}
+	while (max_groups >= 0) {
+		if (buf->requested_group == buf->groups[max_groups])
+			return TRUE;
+		max_groups--;
+	}
+	return FALSE;
+}
+
 int main(int argc, char **argv)
 {
 	int ch;
@@ -104,6 +158,7 @@ int main(int argc, char **argv)
 	char *p;
 	char line[sizeof(utmpptr->ut_line) + 1];
 	int print_banner = TRUE;
+	struct group_workspace *group_buf = NULL;
 	char *mbuf, *fname = NULL;
 	size_t mbufsize;
 	unsigned timeout = WRITE_TIME_OUT;
@@ -113,6 +168,7 @@ int main(int argc, char **argv)
 	static const struct option longopts[] = {
 		{ "nobanner",	no_argument,		0, 'n' },
 		{ "timeout",	required_argument,	0, 't' },
+		{ "group",	required_argument,	0, 'g' },
 		{ "version",	no_argument,		0, 'V' },
 		{ "help",	no_argument,		0, 'h' },
 		{ NULL,	0, 0, 0 }
@@ -123,7 +179,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((ch = getopt_long(argc, argv, "nt:Vh", longopts, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "nt:g:Vh", longopts, NULL)) != -1) {
 		switch (ch) {
 		case 'n':
 			if (geteuid() == 0)
@@ -136,6 +192,9 @@ int main(int argc, char **argv)
 			if (timeout < 1)
 				errx(EXIT_FAILURE, _("invalid timeout argument: %s"), optarg);
 			break;
+		case 'g':
+			group_buf = init_group_workspace(optarg);
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
@@ -172,12 +231,19 @@ int main(int argc, char **argv)
 		if (utmpptr->ut_line[0] == ':')
 			continue;
 
+		if (group_buf && !is_gr_member(utmpptr->ut_user, group_buf))
+			continue;
+
 		xstrncpy(line, utmpptr->ut_line, sizeof(utmpptr->ut_line));
 		if ((p = ttymsg(&iov, 1, line, timeout)) != NULL)
 			warnx("%s", p);
 	}
 	endutent();
 	free(mbuf);
+	if (group_buf) {
+		free(group_buf->groups);
+		free(group_buf);
+	}
 	exit(EXIT_SUCCESS);
 }
 
-- 
2.7.4

