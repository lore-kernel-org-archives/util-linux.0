Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:40364 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbbBOJu2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Feb 2015 04:50:28 -0500
Received: by mail-we0-f174.google.com with SMTP id w55so24201273wes.5
        for <util-linux@vger.kernel.org>; Sun, 15 Feb 2015 01:50:27 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Gabriele Balducci <balducci@units.it>
Subject: [PATCH] logger: add --socket-errors compatibility option
Date: Sun, 15 Feb 2015 09:50:23 +0000
Message-Id: <1423993823-13551-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Depending viewpoint this change is either regression fix, or
re-regression in context of none-systemd init.  I ack the change is sent
very late to be part of v2.26, but then again the excess noise was found
only because of -rc1 was tested in sysvinit environment.  IMHO it would
contradict purpose of having rc's if faults will not lead to fixes.

I also want to point out the sysvinit scripts are broken, not the
logger(1), but getting them corrected is practically impossible. 
Assuming sysvinit script are further developed by various teams and
distributions who maintain them they should use --socket-error=on in
future, and write scripts that pass without noise.  Meanwhile trying to
be clever when to silence errors seems like a reasonable thing to do.


--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 14 Feb 2015 19:05:55 +0000
Subject: [PATCH] logger: add --socket-errors compatibility option

Now when logger(1) has stopped using openlog() for Unix sockets, in
commit mentioned in reference, the lack of /dev/log detected will report
error accordingly.  According to Gabriele Balducci this makes sysvinit
style boot scripts to print a lot of errors.  So make the logger to
detect whether it should be in compatibility mode, and not report errors
if logging device is missing.  That imitates behavior of glibc openlog().

To allow full control to users the /dev/log error messages can be forced
to on or off.  The automatic error messaging is explained in manual page.

Reference: 1d57503378bdcd838365d625f6d2d0a09da9c29d
Reported-by: Gabriele Balducci <balducci@units.it>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.1 | 17 ++++++++++++
 misc-utils/logger.c | 75 ++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 46ddbcf..a855cdf 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -160,6 +160,23 @@ Write to the specified
 .I socket
 instead of to the builtin syslog routines.
 .TP
+.BR \-\-socket\-errors [ =\fImode ]
+Print errors about Unix socket connections.  The \fImode\fR can be a value of
+\fBoff\fR, \fBon\fR, or \fBauto\fR.  When the mode is auto logger will detect
+if the init process is systemd, and if so assumption is made /dev/log can be
+used early at boot.  Other init systems lack of /dev/log will not cause errors
+that is identical with messaging using
+.BR openlog (3)
+system call.  The
+.BR logger (1)
+before version 2.26 used openlog, and hence was inable to detected loss of
+messages sent to Unix sockets.
+.IP
+The default mode is \fBauto\fR.  When errors are not enabled lost messages are
+not communicated and will result to successful return value of
+.BR logger (1)
+invocation.
+.TP
 .B \-\-
 End the argument list.  This allows the \fImessage\fR
 to start with a hyphen (\-).
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 21b56bf..a3af7f1 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -63,6 +63,7 @@
 #include <syslog.h>
 
 #ifdef HAVE_LIBSYSTEMD
+# include <systemd/sd-daemon.h>
 # include <systemd/sd-journal.h>
 #endif
 
@@ -77,10 +78,17 @@ enum {
 };
 
 enum {
+	AF_UNIX_ERRORS_OFF = 0,
+	AF_UNIX_ERRORS_ON,
+	AF_UNIX_ERRORS_AUTO
+};
+
+enum {
 	OPT_PRIO_PREFIX = CHAR_MAX + 1,
 	OPT_JOURNALD,
 	OPT_RFC3164,
-	OPT_RFC5424
+	OPT_RFC5424,
+	OPT_SOCKET_ERRORS
 };
 
 struct logger_ctl {
@@ -94,11 +102,12 @@ struct logger_ctl {
 	int socket_type;
 	void (*syslogfp)(const struct logger_ctl *ctl, const char *msg);
 	unsigned int
-			prio_prefix:1,	/* read priority from intput */
-			stderr_printout:1, /* output message to stderr */
-			rfc5424_time:1,	/* include time stamp */
-			rfc5424_tq:1,	/* include time quality markup */
-			rfc5424_host:1;	/* include hostname */
+			unix_socket_errors:1,	/* whether to report or not errors */
+			prio_prefix:1,		/* read priority from intput */
+			stderr_printout:1,	/* output message to stderr */
+			rfc5424_time:1,		/* include time stamp */
+			rfc5424_tq:1,		/* include time quality markup */
+			rfc5424_host:1;		/* include hostname */
 };
 
 static char *get_prio_prefix(char *msg, int *prio)
@@ -165,7 +174,7 @@ static int pencode(char *s)
 	return ((level & LOG_PRIMASK) | (facility & LOG_FACMASK));
 }
 
-static int unix_socket(const char *path, const int socket_type)
+static int unix_socket(struct logger_ctl *ctl, const char *path, const int socket_type)
 {
 	int fd, i;
 	static struct sockaddr_un s_addr;	/* AF_UNIX address of local logger */
@@ -192,9 +201,14 @@ static int unix_socket(const char *path, const int socket_type)
 		break;
 	}
 
-	if (i == 0)
-		err(EXIT_FAILURE, _("socket %s"), path);
-
+	if (i == 0) {
+		if (ctl->unix_socket_errors)
+			err(EXIT_FAILURE, _("socket %s"), path);
+		else
+			/* See --socket-errors manual page entry for
+			 * explanation of this strange exit.  */
+			exit(EXIT_SUCCESS);
+	}
 	return fd;
 }
 
@@ -414,6 +428,18 @@ static void parse_rfc5424_flags(struct logger_ctl *ctl, char *optarg)
 	}
 }
 
+static int parse_unix_socket_errors_flags(char *optarg)
+{
+	if (!strcmp(optarg, "off"))
+		return AF_UNIX_ERRORS_OFF;
+	if (!strcmp(optarg, "on"))
+		return AF_UNIX_ERRORS_ON;
+	if (!strcmp(optarg, "auto"))
+		return AF_UNIX_ERRORS_AUTO;
+	warnx(_("invalid argument: %s: using automatic errors"), optarg);
+	return AF_UNIX_ERRORS_AUTO;
+}
+
 static void syslog_local(const struct logger_ctl *ctl, const char *msg)
 {
 	char *buf, *tag;
@@ -450,12 +476,12 @@ static void logger_open(struct logger_ctl *ctl)
 		return;
 	}
 	if (ctl->unix_socket) {
-		ctl->fd = unix_socket(ctl->unix_socket, ctl->socket_type);
+		ctl->fd = unix_socket(ctl, ctl->unix_socket, ctl->socket_type);
 		if (!ctl->syslogfp)
 			ctl->syslogfp = syslog_rfc5424;
 		return;
 	}
-	ctl->fd = unix_socket("/dev/log", ctl->socket_type);
+	ctl->fd = unix_socket(ctl, "/dev/log", ctl->socket_type);
 	ctl->syslogfp = syslog_local;
 }
 
@@ -535,6 +561,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_("     --rfc5424[=<snip>]   use the syslog protocol (the default);\n"
 		"                            <snip> can be notime, or notq, and/or nohost\n"), out);
 	fputs(_(" -u, --socket <socket>    write to this Unix socket\n"), out);
+	fputs(_("     --socket-errors[=<on|off|auto>]\n"
+		"                          print connection errors when using Unix sockets\n"), out);
 #ifdef HAVE_LIBSYSTEMD
 	fputs(_("     --journald[=<file>]  write journald entry\n"), out);
 #endif
@@ -562,6 +590,7 @@ int main(int argc, char **argv)
 		.prio_prefix = 0,
 		.tag = NULL,
 		.unix_socket = NULL,
+		.unix_socket_errors = 0,
 		.server = NULL,
 		.port = NULL,
 		.socket_type = ALL_TYPES,
@@ -571,6 +600,7 @@ int main(int argc, char **argv)
 	};
 	int ch;
 	int stdout_reopened = 0;
+	int unix_socket_errors_mode = AF_UNIX_ERRORS_AUTO;
 #ifdef HAVE_LIBSYSTEMD
 	FILE *jfd = NULL;
 #endif
@@ -581,6 +611,7 @@ int main(int argc, char **argv)
 		{ "priority",	required_argument,  0, 'p' },
 		{ "tag",	required_argument,  0, 't' },
 		{ "socket",	required_argument,  0, 'u' },
+		{ "socket-errors", required_argument, 0, OPT_SOCKET_ERRORS },
 		{ "udp",	no_argument,	    0, 'd' },
 		{ "tcp",	no_argument,	    0, 'T' },
 		{ "server",	required_argument,  0, 'n' },
@@ -670,6 +701,9 @@ int main(int argc, char **argv)
 				jfd = stdin;
 			break;
 #endif
+		case OPT_SOCKET_ERRORS:
+			unix_socket_errors_mode = parse_unix_socket_errors_flags(optarg);
+			break;
 		case '?':
 		default:
 			usage(stderr);
@@ -689,6 +723,23 @@ int main(int argc, char **argv)
 		return EXIT_SUCCESS;
 	}
 #endif
+	switch (unix_socket_errors_mode) {
+	case AF_UNIX_ERRORS_OFF:
+		ctl.unix_socket_errors = 0;
+		break;
+	case AF_UNIX_ERRORS_ON:
+		ctl.unix_socket_errors = 1;
+		break;
+	case AF_UNIX_ERRORS_AUTO:
+#ifdef HAVE_LIBSYSTEMD
+		ctl.unix_socket_errors = sd_booted();
+#else
+		ctl.unix_socket_errors = 0;
+#endif
+		break;
+	default:
+		abort();
+	}
 	logger_open(&ctl);
 	if (0 < argc)
 		logger_command_line(&ctl, argv);
-- 
2.3.0

