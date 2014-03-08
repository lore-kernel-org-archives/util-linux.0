Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f171.google.com ([209.85.214.171]:52417 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbaCHRCZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 12:02:25 -0500
Received: by mail-ob0-f171.google.com with SMTP id wn1so5460822obc.2
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 09:02:24 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/5] docs: add a new command boilerplate code
Date: Sat,  8 Mar 2014 11:01:56 -0600
Message-Id: <1394298117-16531-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
References: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Having howtos is good, having an working code that can be used as-is to
kickstart a write of a new command is better.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/boilerplate.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/boilerplate.c

diff --git a/Documentation/boilerplate.c b/Documentation/boilerplate.c
new file mode 100644
index 0000000..3ee7d7b
--- /dev/null
+++ b/Documentation/boilerplate.c
@@ -0,0 +1,100 @@
+/* Please use this file as a template when introducing new command to
+ * util-linux package.
+ * -- remove above */
+/*
+ * fixme-command-name - purpose of it
+ *
+ * Copyright (c) 20nn  Example Commercial, Inc
+ * Written by Your Name <you@example.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <getopt.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "c.h"
+#include "closestream.h"
+#include "nls.h"
+
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] file...\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -n, --no-argument       option does not use argument\n"), out);
+	fputs(_(" -o, --optional[=<arg>]  option argument is optional\n"), out);
+	fputs(_(" -r, --required <arg>    option requires an argument\n"), out);
+	fputs(_(" -z                      no long option\n"), out);
+	fputs(_("     --xyzzy             a long option only\n"), out);
+	fputs(_(" -e, --extremely-long-long-option\n"), out);
+	fputs(_("                         use next line for description when needed\n"), out);
+	fputs(_(" -l, --long-explanation  an example of very verbose, and chatty option\n"), out);
+	fputs(_("                           description on two, or multiple lines, where the\n"), out);
+	fputs(_("                           consecutive lines are intended by two spaces\n"), out);
+	fputs(_(" -f, --foobar            next option description resets indent\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("fixme-command-name(1)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+int main(int argc, char **argv)
+{
+	int c;
+
+	enum {
+		OPT_XYZZY = CHAR_MAX + 1
+	};
+	static const struct option longopts[] = {
+		{"no-argument", no_argument, NULL, 'n'},
+		{"optional", optional_argument, NULL, 'o'},
+		{"required", required_argument, NULL, 'r'},
+		{"xyzzy", no_argument, NULL, OPT_XYZZY},
+		{"extremely-long-long-option", no_argument, NULL, 'e'},
+		{"long-explanation", no_argument, NULL, 'l'},
+		{"foobar", no_argument, NULL, 'f'},
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long(argc, argv, "no::r:elfVh", longopts, NULL)) != -1)
+		switch (c) {
+		case 'n':
+		case 'o':
+		case 'r':
+		case OPT_XYZZY:
+		case 'e':
+		case 'l':
+		case 'f':
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
+
+	return EXIT_SUCCESS;
+}
-- 
1.9.0

