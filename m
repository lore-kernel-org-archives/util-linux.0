Return-Path: util-linux-owner@vger.kernel.org
Received: from aserp1040.oracle.com ([141.146.126.69]:41604 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab3LDWcA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 Dec 2013 17:32:00 -0500
From: Daniel Kiper <daniel.kiper@oracle.com>
To: kzak@redhat.com, util-linux@vger.kernel.org, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [RFC PATCH] sgetty: Smart serial console getty
Date: Wed,  4 Dec 2013 23:31:37 +0100
Message-Id: <1386196297-2398-1-git-send-email-daniel.kiper@oracle.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Very often when I was switching from Xen to Linux I was forced
to change /etc/inittab to make serial console working. It was
boring so I thought how to solve that problem. I was not able
to find sensible solution. So I decided to write something.
Here it is.

I posted this patch earlier to Xen-devel list but Ian Campbell
stated that it is more generic and maybe I should try to include
this in util-linux. I am posting sgetty here with minor changes.
Maybe this solution should be merged with agetty but I am not
sure right now. If you think that it is good idea then
I will do that.

Anyway, I am looking for your comments.

I am not subscribed to util-linux list so please
include my email address in your reply.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 term-utils/Makemodule.am |    2 +
 term-utils/sgetty.c      |  243 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 245 insertions(+)
 create mode 100644 term-utils/sgetty.c

diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index e53471f..e9055fc 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -21,6 +21,8 @@ sbin_PROGRAMS += agetty
 dist_man_MANS += term-utils/agetty.8
 agetty_SOURCES = term-utils/agetty.c
 agetty_LDADD = $(LDADD) libcommon.la
+sbin_PROGRAMS += sgetty
+sgetty_SOURCES = term-utils/sgetty.c
 endif # BUILD_AGETTY
 
 
diff --git a/term-utils/sgetty.c b/term-utils/sgetty.c
new file mode 100644
index 0000000..2bd3500
--- /dev/null
+++ b/term-utils/sgetty.c
@@ -0,0 +1,243 @@
+/*
+ * Copyright (c) 2013 Daniel Kiper, Oracle Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <errno.h>
+#include <libgen.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syslog.h>
+#include <unistd.h>
+
+#define BOOT_CMDLINE	"/proc/cmdline"
+
+#define GETTY		"/sbin/getty"
+
+static char *sgetty_file = "sgetty";
+
+static char *opt_b = NULL;
+static int opt_c = 1;
+static char *opt_g = GETTY;
+static char *opt_t = NULL;
+
+static void usage(int status)
+{
+	FILE *stream;
+
+	stream = (status == EXIT_SUCCESS) ? stdout : stderr;
+
+	fprintf(stream, "\nsgetty Ver. 1.0.0\n\n"
+			"sgetty establishes serial console name from system boot command\n"
+			"line (%s) and then runs getty. This is very useful if e.g.\n"
+			"someone switches very often between Linux and Xen and uses serial\n"
+			"console. sgetty does boring things and runs getty on relevant line.\n"
+			"This way nobody needs to worry about /etc/inittab changes anymore.\n\n"
+			"Usage: sgetty [<options>] [-- [<getty_options>]]\n\n"
+			"Options:\n"
+			"  -b <baud_rate> - baud rate (required),\n"
+			"  -c <console> - serial console number in system boot\n"
+			"                 command line (default: 1),\n"
+			"  -g <getty> - path to getty (default: %s),\n"
+			"  -h - display this help,\n"
+			"  -t <term> - terminal type.\n\n"
+			"<getty_options> are passed without any changes to getty.\n\n"
+			"Warning: do not pass a line name, baud rate and terminal type\n"
+			"in <getty_options>. The line name is established by sgetty.\n"
+			"Baud rate and terminal type (if needed) must be\n"
+			"passed via relevant sgetty options.\n\n"
+			"sgetty takes into account and counts console arguments with ttyS*,\n"
+			"hvc* and xvc* only in system boot command line.\n\n"
+			"Example: sgetty -g /sbin/agetty -b 115200 -c 2 -- -i\n\n",
+			BOOT_CMDLINE, GETTY);
+	exit(status);
+}
+
+static void do_log(int priority, const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	openlog(sgetty_file, LOG_PID, LOG_AUTHPRIV);
+	vsyslog(priority, format, ap);
+	closelog();
+
+	va_end(ap);
+}
+
+static void init(int argc, char *const argv[])
+{
+	char *endptr, *s;
+	int c;
+
+	s = basename(argv[0]);
+
+	if (strcmp(s, ".") && strcmp(s, "/"))
+		sgetty_file = s;
+
+	opterr = 0;
+
+	while ((c = getopt(argc, argv, "+b:c:g:ht:")) != -1)
+		switch (c) {
+			case 'b':
+				opt_b = optarg;
+				break;
+
+			case 'c':
+				errno = 0;
+				opt_c = strtol(optarg, &endptr, 10);
+
+				if (errno || *endptr || opt_c < 1) {
+					fprintf(stderr, "Wrong serial console number\n");
+					do_log(LOG_WARNING, "Wrong serial console number");
+					usage(EXIT_FAILURE);
+				}
+
+				break;
+
+			case 'g':
+				opt_g = optarg;
+				break;
+
+			case 'h':
+				usage(EXIT_SUCCESS);
+
+			case 't':
+				opt_t = optarg;
+				break;
+
+			default:
+				fprintf(stderr, "Wrong arguments\n");
+				do_log(LOG_WARNING, "Wrong arguments");
+				usage(EXIT_FAILURE);
+		}
+
+	if (!opt_b) {
+		fprintf(stderr, "Baud rate is not specified\n");
+		do_log(LOG_ERR, "Baud rate is not specified");
+		usage(EXIT_FAILURE);
+	}
+}
+
+static char *get_console_name(void)
+{
+	FILE *stream;
+	char *boot_cmdline = NULL, *tok;
+	int i = 1;
+	size_t n;
+	ssize_t rc;
+
+	stream = fopen(BOOT_CMDLINE, "r");
+
+	if (!stream) {
+		do_log(LOG_ERR, "Cannot open file: %s: %m", BOOT_CMDLINE);
+		exit(EXIT_FAILURE);
+	}
+
+	rc = getline(&boot_cmdline, &n, stream);
+
+	if (rc == -1) {
+		do_log(LOG_ERR, "Cannot read file: %s: %m", BOOT_CMDLINE);
+		exit(EXIT_FAILURE);
+	}
+
+	fclose(stream);
+
+	tok = strtok(boot_cmdline, " \n\r\t");
+
+	while (tok) {
+		if (strstr(tok, "console=ttyS") == tok ||
+		    strstr(tok, "console=hvc") == tok ||
+		    strstr(tok, "console=xvc") == tok) {
+			if (i == opt_c) {
+				tok += strlen("console=");
+				return strtok(tok, ", \n\r\t");
+			}
+
+			if (++i > opt_c)
+				return NULL;
+		}
+
+		tok = strtok(NULL, " \n\r\t");
+	}
+
+	return NULL;
+}
+
+static void exec_getty(int argc, char *const argv[], char *console)
+{
+	char **g_argv;
+	/* Path to getty, console name, baud rate and final NULL. */
+	int g_argc = 4;
+	int i = 0, j = optind;
+
+	if (!console) {
+		do_log(LOG_INFO, "Serial console not found. Nothing to do. "
+				 "I am going sleep... Yawn...");
+		sleep(86400); /* Sleep one day... */
+		exit(EXIT_SUCCESS);
+	}
+
+	/* How many plain getty options do we have? */
+	g_argc += argc - optind;
+
+	/* Add space for terminal type if needed. */
+	if (opt_t)
+		++g_argc;
+
+	g_argv = calloc(g_argc, sizeof(char *));
+
+	if (!g_argv) {
+		do_log(LOG_ERR, "Cannot allocate memory for getty args: %m");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Path to getty. */
+	g_argv[i++] = opt_g;
+
+	/* Plain options to getty. */
+	while (j < argc)
+		g_argv[i++] = argv[j++];
+
+	/* Console name. */
+	g_argv[i++] = console;
+
+	/* Baud rate. */
+	g_argv[i++] = opt_b;
+
+	/* Terminal type if available. */
+	if (opt_t)
+		g_argv[i] = opt_t;
+
+	/* Run getty. */
+	execv(opt_g, g_argv);
+
+	/* Ugh... Something went wrong... Dying... */
+	do_log(LOG_ERR, "Cannot execute %s: %m", opt_g);
+}
+
+int main(int argc, char *const argv[])
+{
+	char *console;
+
+	init(argc, argv);
+	console = get_console_name();
+	exec_getty(argc, argv, console);
+
+	return EXIT_FAILURE;
+}
-- 
1.7.10.4

