Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35753 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753449AbcKPV7i (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 16 Nov 2016 16:59:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so15576847wme.2
        for <util-linux@vger.kernel.org>; Wed, 16 Nov 2016 13:59:37 -0800 (PST)
Date: Wed, 16 Nov 2016 21:59:28 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Jim Patterson <jimp@wegrok.net>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] wall: add --group option
In-Reply-To: <1479316934-1578-1-git-send-email-jimp@wegrok.net>
Message-ID: <alpine.LNX.2.20.1611162155200.7871@imuri>
References: <1479316934-1578-1-git-send-email-jimp@wegrok.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 16 Nov 2016, Jim Patterson wrote:

> The wall command on AIX supports a "-g" option to limit the message
> to a group of users by gid.  Add compatibility to the Linux version.

A bit more work to this change: 1) numeric gid is no checked to be valid, 
2) gid is checked to be withing range of gid_t and 3) --group option is 
added to bash completion hints 4) add Reviewed-by line.

This change is also available from here:
git://github.com/kerolasa/lelux-utiliteetit.git wall-group

--->8----
From: Jim Patterson <jimp@wegrok.net>
Date: Wed, 16 Nov 2016 12:22:14 -0500
Subject: [PATCH] wall: add --group option

The wall command on AIX supports a "-g" option to limit the message
to a group of users by gid.  Add compatibility to the Linux version.

Thanks to Sami Kerola <kerolasa@iki.fi> for an initial skeleton
implementation.

Reference: http://www.ibm.com/support/knowledgecenter/ssw_aix_61/com.ibm.aix.cmds6/wall.htm
Reviewed-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Jim Patterson <jimp@wegrok.net>
---
 bash-completion/wall |  6 ++++-
 term-utils/wall.1    |  7 +++++
 term-utils/wall.c    | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/bash-completion/wall b/bash-completion/wall
index e3145ff..d2fba9a 100644
--- a/bash-completion/wall
+++ b/bash-completion/wall
@@ -9,13 +9,17 @@ _wall_module()
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
 	esac
 	case $cur in
 		-*)
-			OPTS="--nobanner --timeout --version --help"
+			OPTS="--group --nobanner --timeout --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
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
index 4ad94d8..9c89f3e 100644
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
@@ -71,6 +74,7 @@
 
 #define	TERM_WIDTH	79
 #define	WRITE_TIME_OUT	300		/* in seconds */
+#define GID_T_MAX (~(gid_t)0)
 
 /* Function prototypes */
 static char *makemsg(char *fname, char **mvec, int mvecsz,
@@ -86,6 +90,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_("Write a message to all users.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -g, --group <group>     only send message to group\n"), out);
 	fputs(_(" -n, --nobanner          do not print banner, works only for root\n"), out);
 	fputs(_(" -t, --timeout <timeout> write timeout in seconds\n"), out);
 	fputs(USAGE_SEPARATOR, out);
@@ -96,6 +101,63 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
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
+	uint64_t gid;
+
+	if ((gr = getgrnam(optarg)))
+		return gr->gr_gid;
+	gid = strtou64_or_err(optarg, _("invalid group argument"));
+	if (GID_T_MAX < gid)
+		errx(EXIT_FAILURE, "%s: %s", _("gid out of range"), optarg);
+	if (!getgrgid(gid))
+		errx(EXIT_FAILURE, "%s: %s", _("unknown gid"), optarg);
+	return gid;
+}
+
+static struct group_workspace *init_group_workspace(const char *optarg)
+{
+	struct group_workspace *buf = xmalloc(sizeof(struct group_workspace));
+
+	buf->requested_group = get_group_gid(optarg);
+	buf->max = sysconf(_SC_NGROUPS_MAX) + 1;	/* room for the primary gid */
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
@@ -104,6 +166,7 @@ int main(int argc, char **argv)
 	char *p;
 	char line[sizeof(utmpptr->ut_line) + 1];
 	int print_banner = TRUE;
+	struct group_workspace *group_buf = NULL;
 	char *mbuf, *fname = NULL;
 	size_t mbufsize;
 	unsigned timeout = WRITE_TIME_OUT;
@@ -113,6 +176,7 @@ int main(int argc, char **argv)
 	static const struct option longopts[] = {
 		{ "nobanner",	no_argument,		0, 'n' },
 		{ "timeout",	required_argument,	0, 't' },
+		{ "group",	required_argument,	0, 'g' },
 		{ "version",	no_argument,		0, 'V' },
 		{ "help",	no_argument,		0, 'h' },
 		{ NULL,	0, 0, 0 }
@@ -123,7 +187,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((ch = getopt_long(argc, argv, "nt:Vh", longopts, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "nt:g:Vh", longopts, NULL)) != -1) {
 		switch (ch) {
 		case 'n':
 			if (geteuid() == 0)
@@ -136,6 +200,9 @@ int main(int argc, char **argv)
 			if (timeout < 1)
 				errx(EXIT_FAILURE, _("invalid timeout argument: %s"), optarg);
 			break;
+		case 'g':
+			group_buf = init_group_workspace(optarg);
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
@@ -172,12 +239,19 @@ int main(int argc, char **argv)
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
2.10.2

