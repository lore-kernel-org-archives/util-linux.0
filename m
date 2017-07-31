Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38480 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdGaTz0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id y206so72452wmd.5
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 8/9] agetty: add --compile-time option
Date: Mon, 31 Jul 2017 20:55:07 +0100
Message-Id: <20170731195508.11661-9-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This command has the most compile time #ifdef code.  It is time to add an
option to print what was defined when the command was compiled, so that
debugging is easier.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.8 |   3 +
 term-utils/agetty.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 254 insertions(+)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 23adff3b1..230c47cd5 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -281,6 +281,9 @@ if the user has not yet commenced logging in.  After doing so the command will
 exit.  This feature might be unsupported on systems without Linux
 .BR inotify (7).
 .TP
+\-\-compile\-time
+Display compile time definitions.
+.TP
 \-\-version
 Display version information and exit.
 .TP
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index a95da6f3d..f06b9fc6e 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -309,6 +309,7 @@ static void termio_final(struct options *op,
 static int caps_lock(char *s);
 static speed_t bcode(char *s);
 static void usage(void) __attribute__((__noreturn__));
+static void compile_time(void) __attribute__((__noreturn__));
 static void log_err(const char *, ...) __attribute__((__noreturn__))
 			       __attribute__((__format__(printf, 1, 2)));
 static void log_warn (const char *, ...)
@@ -632,6 +633,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 		ERASE_CHARS_OPTION,
 		KILL_CHARS_OPTION,
 		RELOAD_OPTION,
+		COMPILE_TIME_OPTION,
 	};
 	const struct option longopts[] = {
 		{  "8bits",	     no_argument,	 NULL,  '8'  },
@@ -668,6 +670,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 		{  "help",	     no_argument,	 NULL,  HELP_OPTION     },
 		{  "erase-chars",    required_argument,  NULL,  ERASE_CHARS_OPTION },
 		{  "kill-chars",     required_argument,  NULL,  KILL_CHARS_OPTION },
+		{  "compile-time",   no_argument,	 NULL,	COMPILE_TIME_OPTION },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -784,6 +787,8 @@ static void parse_args(int argc, char **argv, struct options *op)
 		case RELOAD_OPTION:
 			reload_agettys();
 			exit(EXIT_SUCCESS);
+		case COMPILE_TIME_OPTION:
+			compile_time();
 		case VERSION_OPTION:
 			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
@@ -2073,6 +2078,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("     --delay <number>       sleep seconds before prompt\n"), out);
 	fputs(_("     --nice <number>        run login with this priority\n"), out);
 	fputs(_("     --reload               reload prompts on running agetty instances\n"), out);
+	printf( "     --compile-time         display what was defined during compile time\n");
 	printf( "     --help                 %s\n", USAGE_OPTSTR_HELP);
 	printf( "     --version              %s\n", USAGE_OPTSTR_VERSION);
 	printf(USAGE_MAN_TAIL("agetty(8)"));
@@ -2080,6 +2086,251 @@ static void __attribute__((__noreturn__)) usage(void)
 	exit(EXIT_SUCCESS);
 }
 
+static void __attribute__((__noreturn__)) compile_time(void)
+{
+#ifdef B19200
+printf("%-30s: defined\n", "B19200");
+#else
+printf("%-30s: not in use\n", "B19200");
+#endif
+
+#ifdef B38400
+printf("%-30s: defined\n", "B38400");
+#else
+printf("%-30s: not in use\n", "B38400");
+#endif
+
+#ifdef B57600
+printf("%-30s: defined\n", "B57600");
+#else
+printf("%-30s: not in use\n", "B57600");
+#endif
+
+#ifdef B115200
+printf("%-30s: defined\n", "B115200");
+#else
+printf("%-30s: not in use\n", "B115200");
+#endif
+
+#ifdef B230400
+printf("%-30s: defined\n", "B230400");
+#else
+printf("%-30s: not in use\n", "B230400");
+#endif
+
+#ifdef B460800
+printf("%-30s: defined\n", "B460800");
+#else
+printf("%-30s: not in use\n", "B460800");
+#endif
+
+#ifdef B500000
+printf("%-30s: defined\n", "B500000");
+#else
+printf("%-30s: not in use\n", "B500000");
+#endif
+
+#ifdef B576000
+printf("%-30s: defined\n", "B576000");
+#else
+printf("%-30s: not in use\n", "B576000");
+#endif
+
+#ifdef B921600
+printf("%-30s: defined\n", "B921600");
+#else
+printf("%-30s: not in use\n", "B921600");
+#endif
+
+#ifdef B1000000
+printf("%-30s: defined\n", "B1000000");
+#else
+printf("%-30s: not in use\n", "B1000000");
+#endif
+
+#ifdef B1152000
+printf("%-30s: defined\n", "B1152000");
+#else
+printf("%-30s: not in use\n", "B1152000");
+#endif
+
+#ifdef B1500000
+printf("%-30s: defined\n", "B1500000");
+#else
+printf("%-30s: not in use\n", "B1500000");
+#endif
+
+#ifdef B2000000
+printf("%-30s: defined\n", "B2000000");
+#else
+printf("%-30s: not in use\n", "B2000000");
+#endif
+
+#ifdef B2500000
+printf("%-30s: defined\n", "B2500000");
+#else
+printf("%-30s: not in use\n", "B2500000");
+#endif
+
+#ifdef B3000000
+printf("%-30s: defined\n", "B3000000");
+#else
+printf("%-30s: not in use\n", "B3000000");
+#endif
+
+#ifdef B3500000
+printf("%-30s: defined\n", "B3500000");
+#else
+printf("%-30s: not in use\n", "B3500000");
+#endif
+
+#ifdef B4000000
+printf("%-30s: defined\n", "B4000000");
+#else
+printf("%-30s: not in use\n", "B4000000");
+#endif
+
+#ifdef AGETTY_RELOAD
+printf("%-30s: defined\n", "AGETTY_RELOAD");
+#else
+printf("%-30s: not in use\n", "AGETTY_RELOAD");
+#endif
+
+#ifdef CRTSCTS
+printf("%-30s: defined\n", "CRTSCTS");
+#else
+printf("%-30s: not in use\n", "CRTSCTS");
+#endif
+
+#ifdef DEBUGGING
+printf("%-30s: defined\n", "DEBUGGING");
+#else
+printf("%-30s: not in use\n", "DEBUGGING");
+#endif
+
+#ifdef HAVE_GETDOMAINNAME
+printf("%-30s: defined\n", "HAVE_GETDOMAINNAME");
+#else
+printf("%-30s: not in use\n", "HAVE_GETDOMAINNAME");
+#endif
+
+#ifdef HAVE_LIBUTIL_H
+printf("%-30s: defined\n", "HAVE_LIBUTIL_H");
+#else
+printf("%-30s: not in use\n", "HAVE_LIBUTIL_H");
+#endif
+
+#ifdef HAVE_STRUCT_TERMIOS_C_LINE
+printf("%-30s: defined\n", "HAVE_STRUCT_TERMIOS_C_LINE");
+#else
+printf("%-30s: not in use\n", "HAVE_STRUCT_TERMIOS_C_LINE");
+#endif
+
+#ifdef HAVE_SYS_PARAM_H
+printf("%-30s: defined\n", "HAVE_SYS_PARAM_H");
+#else
+printf("%-30s: not in use\n", "HAVE_SYS_PARAM_H");
+#endif
+
+#ifdef HAVE_UTMP_H
+printf("%-30s: defined\n", "HAVE_UTMP_H");
+#else
+printf("%-30s: not in use\n", "HAVE_UTMP_H");
+#endif
+
+#ifdef HAVE_WIDECHAR
+printf("%-30s: defined\n", "HAVE_WIDECHAR");
+#else
+printf("%-30s: not in use\n", "HAVE_WIDECHAR");
+#endif
+
+#ifdef ISSUE
+printf("%-30s: defined\n", "ISSUE");
+#else
+printf("%-30s: not in use\n", "ISSUE");
+#endif
+
+#ifdef IUCLC
+printf("%-30s: defined\n", "IUCLC");
+#else
+printf("%-30s: not in use\n", "IUCLC");
+#endif
+
+#ifdef IUTF8
+printf("%-30s: defined\n", "IUTF8");
+#else
+printf("%-30s: not in use\n", "IUTF8");
+#endif
+
+#ifdef KDGKBLED
+printf("%-30s: defined\n", "KDGKBLED");
+#else
+printf("%-30s: not in use\n", "KDGKBLED");
+#endif
+
+#ifdef KDGKBMODE
+printf("%-30s: defined\n", "KDGKBMODE");
+#else
+printf("%-30s: not in use\n", "KDGKBMODE");
+#endif
+
+#ifdef K_RAW
+printf("%-30s: defined\n", "K_RAW");
+#else
+printf("%-30s: not in use\n", "K_RAW");
+#endif
+
+#ifdef LOGIN_PROCESS
+printf("%-30s: defined\n", "LOGIN_PROCESS");
+#else
+printf("%-30s: not in use\n", "LOGIN_PROCESS");
+#endif
+
+#ifdef OLCUC
+printf("%-30s: defined\n", "OLCUC");
+#else
+printf("%-30s: not in use\n", "OLCUC");
+#endif
+
+#ifdef SYSV_STYLE
+printf("%-30s: defined\n", "SYSV_STYLE");
+#else
+printf("%-30s: not in use\n", "SYSV_STYLE");
+#endif
+
+#ifdef USE_PLYMOUTH_SUPPORT
+printf("%-30s: defined\n", "USE_PLYMOUTH_SUPPORT");
+#else
+printf("%-30s: not in use\n", "USE_PLYMOUTH_SUPPORT");
+#endif
+
+#ifdef USE_SYSLOG
+printf("%-30s: defined\n", "USE_SYSLOG");
+#else
+printf("%-30s: not in use\n", "USE_SYSLOG");
+#endif
+
+#ifdef XCASE
+printf("%-30s: defined\n", "XCASE");
+#else
+printf("%-30s: not in use\n", "XCASE");
+#endif
+
+#ifdef __FreeBSD_kernel__
+printf("%-30s: defined\n", "__FreeBSD_kernel__");
+#else
+printf("%-30s: not in use\n", "__FreeBSD_kernel__");
+#endif
+
+#ifdef __linux__
+printf("%-30s: defined\n", "__linux__");
+#else
+printf("%-30s: not in use\n", "__linux__");
+#endif
+
+	exit(EXIT_SUCCESS);
+}
+
 /*
  * Helper function reports errors to console or syslog.
  * Will be used by log_err() and log_warn() therefore
-- 
2.13.3

