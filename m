Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38337 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbbJML3b (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:31 -0400
Received: by wieq12 with SMTP id q12so27504353wie.1
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 8/8] ctrlaltdel: display setting when ran without arguments
Date: Tue, 13 Oct 2015 12:29:14 +0100
Message-Id: <1444735754-18976-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
References: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is more useful than printing an error.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h    |  3 +++
 sys-utils/ctrlaltdel.8 |  5 +++-
 sys-utils/ctrlaltdel.c | 70 +++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index e68ac7d..81efcfa 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -208,5 +208,8 @@
 /* logger paths */
 #define _PATH_DEVLOG		"/dev/log"
 
+/* ctrlaltdel paths */
+#define _PATH_PROC_CTRL_ALT_DEL	"/proc/sys/kernel/ctrl-alt-del"
+
 #endif /* PATHNAMES_H */
 
diff --git a/sys-utils/ctrlaltdel.8 b/sys-utils/ctrlaltdel.8
index 4be6513..170597f 100644
--- a/sys-utils/ctrlaltdel.8
+++ b/sys-utils/ctrlaltdel.8
@@ -27,8 +27,11 @@ program must support this feature.  Since there are now several
 programs in the Linux community, please consult the documentation for the
 version that you are currently using.
 .PP
+When command is ran without arguments it will display current function in
+use.
+.PP
 .B ctrlaltdel
-is usually used in the
+function is usually set in the
 .I /etc/rc.local
 file.
 .SH OPTIONS
diff --git a/sys-utils/ctrlaltdel.c b/sys-utils/ctrlaltdel.c
index 64de94f..ffdad6a 100644
--- a/sys-utils/ctrlaltdel.c
+++ b/sys-utils/ctrlaltdel.c
@@ -14,6 +14,7 @@
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
+#include "pathnames.h"
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -30,10 +31,59 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-int main(int argc, char **argv)
+static int get_cad(void)
+{
+	FILE *fp;
+	int val;
+
+	if (!(fp = fopen(_PATH_PROC_CTRL_ALT_DEL, "r"))) {
+		warn("%s", _PATH_PROC_CTRL_ALT_DEL);
+		return EXIT_FAILURE;
+	}
+	if (fscanf(fp, "%d", &val) != 1)
+		val = -1;
+	fclose(fp);
+	switch (val) {
+	case 0:
+		fputs("soft\n", stdout);
+		break;
+	case 1:
+		fputs("hard\n", stdout);
+		break;
+	default:
+		printf("%s hard\n", _("implicit"));
+		warnx(_("unexpected value in %s: %d"), _PATH_PROC_CTRL_ALT_DEL, val);
+		return EXIT_FAILURE;
+	}
+	return EXIT_SUCCESS;
+}
+
+static int set_cad(const char *arg)
 {
-	int ch;
 	unsigned int cmd;
+
+	if (geteuid()) {
+		warnx(_("You must be root to set the Ctrl-Alt-Del behavior"));
+		return EXIT_FAILURE;
+	}
+	if (!strcmp("hard", arg))
+		cmd = LINUX_REBOOT_CMD_CAD_ON;
+	else if (!strcmp("soft", arg))
+		cmd = LINUX_REBOOT_CMD_CAD_OFF;
+	else {
+		warnx(_("unknown argument: %s"), arg);
+		return EXIT_FAILURE;
+	}
+	if (my_reboot(cmd) < 0) {
+		warnx("reboot");
+		return EXIT_FAILURE;
+	}
+	return EXIT_SUCCESS;
+}
+
+int main(int argc, char **argv)
+{
+	int ch, ret;
 	static const struct option longopts[] = {
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
@@ -56,19 +106,9 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	if (geteuid())
-		errx(EXIT_FAILURE,
-		     _("You must be root to set the Ctrl-Alt-Del behavior"));
-
 	if (argc < 2)
-		errx(EXIT_FAILURE, _("not enough arguments"));
-	if (!strcmp("hard", argv[1]))
-		cmd = LINUX_REBOOT_CMD_CAD_ON;
-	else if (!strcmp("soft", argv[1]))
-		cmd = LINUX_REBOOT_CMD_CAD_OFF;
+		ret = get_cad();
 	else
-		errx(EXIT_FAILURE, _("unknown argument: %s"), argv[1]);
-	if (my_reboot(cmd) < 0)
-		err(EXIT_FAILURE, "reboot");
-	return EXIT_SUCCESS;
+		ret = set_cad(argv[1]);
+	return ret;
 }
-- 
2.6.1

