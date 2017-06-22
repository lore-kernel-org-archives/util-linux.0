Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdFVChu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:50 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6P5z-1dh3m33DJb-00yTTT for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:48 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/13] login: add --help and --version
Date: Thu, 22 Jun 2017 04:37:42 +0200
Message-Id: <1498099066-24235-10-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Also we don't print the usage text on stderr anymore.

Note, the usage text could be improved, currently it
does not describe any options. I have only added a
pointer to the man page.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/login.1 |  5 ++++-
 login-utils/login.c | 28 ++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 2fc7a50..5d43fdc 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -131,7 +131,10 @@ to tell
 .B login
 that printing the hostname should be suppressed in the login: prompt.
 .TP
-.B \-V
+\fB\-\-help\fR
+Display help text and exit.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .SH CONFIG FILE ITEMS
 .B login
diff --git a/login-utils/login.c b/login-utils/login.c
index 37553ef..ee06d03 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1095,6 +1095,16 @@ static void init_remote_info(struct login_context *cxt, char *remotehost)
 	}
 }
 
+static void __attribute__((__noreturn__)) usage(void)
+{
+	fputs(USAGE_HEADER, stdout);
+	printf(_(" %s [-p] [-h <host>] [-H] [[-f] <username>]\n"), program_invocation_short_name);
+	fputs(USAGE_SEPARATOR, stdout);
+	fputs(_("Begin a session on the system.\n"), stdout);
+	printf(USAGE_MAN_TAIL("login(1)"));
+	exit(EXIT_SUCCESS);
+}
+
 int main(int argc, char **argv)
 {
 	int c;
@@ -1119,6 +1129,14 @@ int main(int argc, char **argv)
 
 	};
 
+	/* the only two longopts to satisfy UL standards */
+	enum { HELP_OPTION = CHAR_MAX + 1 };
+	static const struct option longopts[] = {
+		{"help", no_argument, NULL, HELP_OPTION},
+		{"version", no_argument, NULL, 'V'},
+		{NULL, 0, NULL, 0}
+	};
+
 	timeout = (unsigned int)getlogindefs_num("LOGIN_TIMEOUT", LOGIN_TIMEOUT);
 
 	signal(SIGALRM, timedout);
@@ -1142,7 +1160,7 @@ int main(int argc, char **argv)
 	 * -h is used by other servers to pass the name of the remote
 	 *    host to login so that it may be placed in utmp and wtmp
 	 */
-	while ((c = getopt(argc, argv, "fHh:pV")) != -1)
+	while ((c = getopt_long(argc, argv, "fHh:pV", longopts, NULL)) != -1)
 		switch (c) {
 		case 'f':
 			cxt.noauth = 1;
@@ -1168,12 +1186,10 @@ int main(int argc, char **argv)
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
-		case '?':
+		case HELP_OPTION:
+			usage();
 		default:
-			fprintf(stderr, _("Usage: login [-p] [-h <host>] [-H] [[-f] <username>]\n"));
-			fputs(USAGE_SEPARATOR, stderr);
-			fputs(_("Begin a session on the system.\n"), stderr);
-			exit(EXIT_FAILURE);
+			errtryhelp(EXIT_FAILURE);
 		}
 	argc -= optind;
 	argv += optind;
-- 
1.8.5.6

