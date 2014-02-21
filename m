Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:55270 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaBUTZm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Feb 2014 14:25:42 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm4so1194461wib.14
        for <util-linux@vger.kernel.org>; Fri, 21 Feb 2014 11:25:40 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] logger: allow user to send structured journald messages
Date: Fri, 21 Feb 2014 19:25:30 +0000
Message-Id: <1393010730-25126-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This feature is hopefully mostly used to give MESSAGE_ID labels for
messages coming from scripts, making search of messages easy.  The
logger(1) manual page update should give enough information how to use
--journald option.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/logger   |  4 +--
 configure.ac             | 16 ++++++++++++
 misc-utils/Makemodule.am |  4 +++
 misc-utils/logger.1      | 29 ++++++++++++++++++++-
 misc-utils/logger.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/bash-completion/logger b/bash-completion/logger
index 963abc7..6b4c7df 100644
--- a/bash-completion/logger
+++ b/bash-completion/logger
@@ -5,7 +5,7 @@ _logger_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'-f'|'--file')
+		'-f'|'--file'|'--journald')
 			local IFS=$'\n'
 			compopt -o filenames
 			COMPREPLY=( $(compgen -f -- $cur) )
@@ -37,7 +37,7 @@ _logger_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="--udp --id --file --help --server --port --priority --stderr --tag --socket --version"
+			OPTS="--journald --udp --id --file --help --server --port --priority --stderr --tag --socket --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/configure.ac b/configure.ac
index e742801..2e47bac 100644
--- a/configure.ac
+++ b/configure.ac
@@ -716,6 +716,7 @@ AS_IF([test "x$enable_most_builds" = xyes], [
   enable_newgrp=yes
   enable_reset=yes
   enable_socket_activation=yes
+  enable_journald=yes
   enable_tunelp=yes
   enable_vipw=yes
   enable_write=yes
@@ -1414,6 +1415,21 @@ AS_IF([test "x$with_systemdsystemunitdir" != "xno"], [
 ])
 
 
+AC_ARG_ENABLE([journald],
+  AS_HELP_STRING([--enable-journald], [add journald support to logger]),
+  [], [enable_journald=no]
+)
+have_journald=no
+AS_IF([test "x$enable_journald" = xyes], [
+  PKG_CHECK_MODULES([SYSTEMD_JOURNAL], [libsystemd-journal], [], [
+    AC_MSG_ERROR([cannot find libsystemd-journal support])
+  ])
+  have_journald=yes
+  AC_DEFINE([HAVE_JOURNALD], [1], [Define if journald is available])
+])
+AM_CONDITIONAL([HAVE_JOURNALD], [test "x$have_journald" = xyes])
+
+
 AC_ARG_WITH([smack],
   AS_HELP_STRING([--with-smack], [build with SMACK support]),
   [], [with_smack=no]
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index d30229d..05407de 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -20,6 +20,10 @@ endif
 usrbin_exec_PROGRAMS += logger
 dist_man_MANS += misc-utils/logger.1
 logger_SOURCES = misc-utils/logger.c lib/strutils.c
+if HAVE_JOURNALD
+logger_LDADD = $(SYSTEMD_JOURNAL_LIBS)
+logger_CFLAGS = $(SYSTEMD_JOURNAL_CFLAGS)
+endif
 
 usrbin_exec_PROGRAMS += look
 dist_man_MANS += misc-utils/look.1
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index c7c3de0..08cf907 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -122,6 +122,31 @@ Write to the specified
 .I socket
 instead of to the builtin syslog routines.
 .TP
+\fB\-\-journald\fR [\fIfile\fR]
+Write systemd journal entry.  The entry is read from
+.I stdin
+or input
+.IR file .
+Each new line must begin with a field that is accepted by journald, see
+.IR systemd.journal-fields (7)
+for details.  Use of MESSAGE_ID field is generally good idea, as they
+make finding entries easy.
+.IP
+.nf
+$ printf "%s\\n%s\\n%s\\n" MESSAGE_ID=86184c3b1aa444f58ebe7b30fec1438b DOGS=bark "CARAVAN=goes on" | logger --journald
+$ logger --journald=entry.txt
+.fi
+.IP
+Notice that
+.B \-\-journald
+will ignore values of other options, such as priority.  If priority is
+needed it must be within input, and use PRIORITY field.  The simple
+execution of
+.B journalctl
+will display MESSAGE field.  Use
+.B journalctl --output json-pretty
+to see rest of the fields.
+.TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .TP
@@ -169,7 +194,9 @@ logger \-p local0.notice \-t HOSTIDM \-f /dev/idmc
 logger \-n loghost.example.com System rebooted
 .SH SEE ALSO
 .BR syslog (3),
-.BR syslogd (8)
+.BR syslogd (8),
+.BR journalctl (1),
+.BR systemd.journal-fields (7)
 .SH STANDARDS
 The
 .B logger
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 0717647..b4a25ce 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -58,6 +58,10 @@
 #define	SYSLOG_NAMES
 #include <syslog.h>
 
+#ifdef HAVE_JOURNALD
+# include <systemd/sd-journal.h>
+#endif
+
 enum {
 	TYPE_UDP = (1 << 1),
 	TYPE_TCP = (1 << 2),
@@ -65,7 +69,8 @@ enum {
 };
 
 enum {
-	OPT_PRIO_PREFIX = CHAR_MAX + 1
+	OPT_PRIO_PREFIX = CHAR_MAX + 1,
+	OPT_JOURNALD
 };
 
 
@@ -204,6 +209,40 @@ static int inet_socket(const char *servername, const char *port,
 	return fd;
 }
 
+#ifdef HAVE_JOURNALD
+static int journald_entry(FILE *fp)
+{
+	struct iovec *iovec;
+	char *buf = NULL;
+	ssize_t sz;
+	int n, lines, vectors = 8, ret;
+	size_t dummy = 0;
+
+	iovec = malloc(vectors * sizeof(struct iovec));
+	for (lines = 0; /* nothing */ ; lines++) {
+		buf = NULL;
+		sz = getline(&buf, &dummy, fp);
+		if (sz == -1)
+			break;
+		if (0 < sz && buf[sz - 1] == '\n') {
+			sz--;
+			buf[sz] = '\0';
+		}
+		if (lines == vectors) {
+			vectors *= 2;
+			iovec = realloc(iovec, vectors * sizeof(struct iovec));
+		}
+		iovec[lines].iov_base = buf;
+		iovec[lines].iov_len = sz;
+	}
+	ret = sd_journal_sendv(iovec, lines);
+	for (n = 0; n < lines; n++)
+		free(iovec[n].iov_base);
+	free(iovec);
+	return ret;
+}
+#endif
+
 static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
 {
        char buf[1000], pid[30], *cp, *tp;
@@ -249,6 +288,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_(" -s, --stderr          output message to standard error as well\n"), out);
 	fputs(_(" -t, --tag <tag>       mark every line with this tag\n"), out);
 	fputs(_(" -u, --socket <socket> write to this Unix socket\n"), out);
+#ifdef HAVE_JOURNALD
+	fputs(_("     --journald[=<file>]  write journald entry\n"), out);
+#endif
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -272,6 +314,7 @@ int main(int argc, char **argv)
 	char *server = NULL;
 	char *port = NULL;
 	int LogSock = -1, socket_type = ALL_TYPES;
+	FILE *jfd = NULL;
 
 	static const struct option longopts[] = {
 		{ "id",		no_argument,	    0, 'i' },
@@ -287,6 +330,9 @@ int main(int argc, char **argv)
 		{ "version",	no_argument,	    0, 'V' },
 		{ "help",	no_argument,	    0, 'h' },
 		{ "prio-prefix", no_argument, 0, OPT_PRIO_PREFIX },
+#ifdef HAVE_JOURNALD
+		{ "journald",   optional_argument,  0, OPT_JOURNALD },
+#endif
 		{ NULL,		0, 0, 0 }
 	};
 
@@ -342,6 +388,16 @@ int main(int argc, char **argv)
 		case OPT_PRIO_PREFIX:
 			prio_prefix = 1;
 			break;
+		case OPT_JOURNALD:
+			if (optarg) {
+				jfd = fopen(optarg, "r");
+				if (!jfd)
+					err(EXIT_FAILURE, _("cannot open %s"),
+					    optarg);
+			} else {
+				jfd = stdin;
+			}
+			break;
 		case '?':
 		default:
 			usage(stderr);
@@ -351,6 +407,14 @@ int main(int argc, char **argv)
 	argv += optind;
 
 	/* setup for logging */
+	if (jfd) {
+		int ret = journald_entry(jfd);
+		if (stdin != jfd)
+			fclose(jfd);
+		if (ret == 0)
+			return EXIT_SUCCESS;
+		return EXIT_FAILURE;
+	}
 	if (server)
 		LogSock = inet_socket(server, port, socket_type);
 	else if (usock)
-- 
1.9.0

