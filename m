Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57736 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbdFYVsQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 25 Jun 2017 17:48:16 -0400
Subject: [PATCH 1/4] include/c.h: add USAGE_COMMANDS and USAGE_COLUMNS
To: Karel Zak <kzak@redhat.com>
References: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <4e72850c-9936-96a0-1d91-d487b8bd7e41@gmx.com>
Date: Sun, 25 Jun 2017 17:47:59 -0400
MIME-Version: 1.0
In-Reply-To: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* login-utils/lslogins.c: all uses changed
* misc-utils/findmnt.c: likewise
* sys-utils/blkzone.c: likewise
* disk-utils/sfdisk.c: likewise
* sys-utils/lscpu.c: likewise
* sys-utils/lsmem.c: likewise
* sys-utils/wdctl.c: likewise

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 disk-utils/sfdisk.c    | 2 +-
 include/c.h            | 4 +++-
 login-utils/lslogins.c | 6 ++----
 misc-utils/findmnt.c   | 3 +--
 sys-utils/blkzone.c    | 2 +-
 sys-utils/lscpu.c      | 3 +--
 sys-utils/lsmem.c      | 5 ++---
 sys-utils/wdctl.c      | 3 +--
 8 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 2ac8cef..2a75190 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1850,7 +1850,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Display or manipulate a disk partition table.\n"), out);
 
-	fputs(_("\nCommands:\n"), out);
+	fputs(USAGE_COMMANDS, out);
 	fputs(_(" -A, --activate <dev> [<part> ...] list or set bootable MBR partitions\n"), out);
 	fputs(_(" -d, --dump <dev>                  dump partition table (usable for later input)\n"), out);
 	fputs(_(" -J, --json <dev>                  dump partition table in JSON format\n"), out);
diff --git a/include/c.h b/include/c.h
index 2bcdcea..f89e065 100644
--- a/include/c.h
+++ b/include/c.h
@@ -313,11 +313,13 @@ static inline int xusleep(useconds_t usec)
 
 /*
  * Constant strings for usage() functions. For more info see
- * Documentation/howto-usage-function.txt and disk-utils/delpart.c
+ * Documentation/{howto-usage-function.txt,boilerplate.c}
  */
 #define USAGE_HEADER     _("\nUsage:\n")
 #define USAGE_OPTIONS    _("\nOptions:\n")
 #define USAGE_FUNCTIONS  _("\nFunctions:\n")
+#define USAGE_COMMANDS   _("\nCommands:\n")
+#define USAGE_COLUMNS    _("\nAvailable columns:\n")
 #define USAGE_SEPARATOR    "\n"
 #define USAGE_HELP       _(" -h, --help     display help information and exit\n")
 #define USAGE_VERSION    _(" -V, --version  display version information and exit\n")
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index ab04c10..9cbf0b3 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1255,11 +1255,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 
-	fprintf(out, _("\nAvailable columns:\n"));
-
+	fputs(USAGE_COLUMNS, out);
 	for (i = 0; i < ARRAY_SIZE(coldescs); i++)
-		fprintf(out, " %14s  %s\n", coldescs[i].name,
-				_(coldescs[i].help));
+		fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
 
 	fprintf(out, USAGE_MAN_TAIL("lslogins(1)"));
 
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 93c0e90..7acc60a 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1248,8 +1248,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 
-	fprintf(out, _("\nAvailable columns:\n"));
-
+	fputs(USAGE_COLUMNS, out);
 	for (i = 0; i < ARRAY_SIZE(infos); i++)
 		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
 
diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index 7713ff3..8fd55c0 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -300,7 +300,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Run zone command on the given block device.\n"), out);
 
-	fputs(_("\nCommands:\n"), out);
+	fputs(USAGE_COMMANDS, out);
 	for (i = 0; i < ARRAY_SIZE(commands); i++)
 		fprintf(out, " %-11s  %s\n", commands[i].name, _(commands[i].help));
 
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 3b549a7..2871f71 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -2068,8 +2068,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 
-	fprintf(out, _("\nAvailable columns:\n"));
-
+	fputs(USAGE_COLUMNS, out);
 	for (i = 0; i < ARRAY_SIZE(coldescs); i++)
 		fprintf(out, " %13s  %s\n", coldescs[i].name, _(coldescs[i].help));
 
diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index 0c8adb8..891be36 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -388,10 +388,9 @@ static void __attribute__((__noreturn__)) lsmem_usage(FILE *out)
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 
-	fputs(_("\nAvailable columns:\n"), out);
-
+	fputs(USAGE_COLUMNS, out);
 	for (i = 0; i < ARRAY_SIZE(coldescs); i++)
-		fprintf(out, " %10s  %s\n", coldescs[i].name, coldescs[i].help);
+		fprintf(out, " %10s  %s\n", coldescs[i].name, _(coldescs[i].help));
 
 	fprintf(out, USAGE_MAN_TAIL("lsmem(1)"));
 
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index e47fc70..1790e89 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -194,9 +194,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_SEPARATOR, out);
 
 	fprintf(out, _("The default device is %s.\n"), _PATH_WATCHDOG_DEV);
-	fputs(USAGE_SEPARATOR, out);
 
-	fputs(_("Available columns:\n"), out);
+	fputs(USAGE_COLUMNS, out);
 	for (i = 0; i < ARRAY_SIZE(infos); i++)
 		fprintf(out, " %13s  %s\n", infos[i].name, _(infos[i].help));
 
