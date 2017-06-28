Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbdF1WpE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 18:45:04 -0400
Subject: [PATCH] misc: standardize USAGE_COLUMNS
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1621510c-227f-325b-7867-c305f738174a@gmx.com>
Date: Wed, 28 Jun 2017 18:44:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Move the usage() columns reference from the
header to the option descriptions.

https://marc.info/?l=util-linux-ng&m=149848711620686

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
The following changes since commit 4fb515f90079739771b64dcb6beeb384e3be7cf5:

  setpriv: add --ambient-caps to usage() (2017-06-27 15:10:09 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170626

for you to fetch changes up to 782c9fd5686ad0125d6dedb222ba508da9bdd614:

  misc: standardize USAGE_COLUMNS (2017-06-27 20:58:12 -0400)

----------------------------------------------------------------
J William Piggott (1):
      misc: standardize USAGE_COLUMNS

 disk-utils/fdisk.c     | 2 +-
 disk-utils/partx.c     | 2 +-
 disk-utils/sfdisk.c    | 2 +-
 include/c.h            | 2 +-
 login-utils/lslogins.c | 2 +-
 misc-utils/fincore.c   | 2 +-
 misc-utils/findmnt.c   | 2 +-
 misc-utils/lsblk.c     | 2 +-
 misc-utils/lslocks.c   | 2 +-
 misc-utils/uuidparse.c | 2 +-
 sys-utils/losetup.c    | 2 +-
 sys-utils/lscpu.c      | 4 ++--
 sys-utils/lsmem.c      | 2 +-
 sys-utils/lsns.c       | 2 +-
 sys-utils/prlimit.c    | 2 +-
 sys-utils/swapon.c     | 2 +-
 sys-utils/wdctl.c      | 2 +-
 sys-utils/zramctl.c    | 2 +-
 18 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 937304c..05543f2 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -771,7 +771,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fprintf(out,
 	        "                                 %s\n", USAGE_COLORS_DEFAULT);
 	fputs(_(" -l, --list                    display partitions and exit\n"), out);
-	fputs(_(" -o, --output <list>           output columns\n"), out);
+	fputs(_(" -o, --output <list>           columns to display (see Columns:)\n"), out);
 	fputs(_(" -t, --type <type>             recognize specified partition table type only\n"), out);
 	fputs(_(" -u, --units[=<unit>]          display units: 'cylinders' or 'sectors' (default)\n"), out);
 	fputs(_(" -s, --getsz                   display device size in 512-byte sectors [DEPRECATED]\n"), out);
diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 474c80e..075f99a 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -764,7 +764,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
 	fputs(_(" -g, --noheadings     don't print headings for --show\n"), out);
 	fputs(_(" -n, --nr <n:m>       specify the range of partitions (e.g. --nr 2:4)\n"), out);
-	fputs(_(" -o, --output <list>  define which output columns to use\n"), out);
+	fputs(_(" -o, --output <list>  columns to display in show, pairs, or raw (see Columns:)\n"), out);
 	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), out);
 	fputs(_(" -r, --raw            use raw output format\n"), out);
 	fputs(_(" -S, --sector-size <num>  overwrite sector size\n"), out);
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 8616ee9..accc4c1 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1889,7 +1889,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("     --no-reread           do not check whether the device is in use\n"), out);
 	fputs(_("     --no-tell-kernel      do not tell kernel about changes\n"), out);
 	fputs(_(" -O, --backup-file <path>  override default backup file name\n"), out);
-	fputs(_(" -o, --output <list>       output columns\n"), out);
+	fputs(_(" -o, --output <list>       columns to display (see Columns:)\n"), out);
 	fputs(_(" -q, --quiet               suppress extra info messages\n"), out);
 	fputs(_(" -w, --wipe <mode>         wipe signatures (auto, always or never)\n"), out);
 	fputs(_(" -W, --wipe-partitions <mode>  wipe signatures from new partitions (auto, always or never)\n"), out);
diff --git a/include/c.h b/include/c.h
index fc766e0..6f4eec5 100644
--- a/include/c.h
+++ b/include/c.h
@@ -313,7 +313,7 @@ static inline int xusleep(useconds_t usec)
 #define USAGE_OPTIONS    _("\nOptions:\n")
 #define USAGE_FUNCTIONS  _("\nFunctions:\n")
 #define USAGE_COMMANDS   _("\nCommands:\n")
-#define USAGE_COLUMNS    _("\nAvailable output columns:\n")
+#define USAGE_COLUMNS    _("\nColumns:\n")
 #define USAGE_SEPARATOR    "\n"
 
 #define USAGE_OPTSTR_HELP     _("display this help")
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 8b9933e..5be9fad 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1242,7 +1242,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -n, --newline            display each piece of information on a new line\n"), out);
 	fputs(_("     --noheadings         don't print headings\n"), out);
 	fputs(_("     --notruncate         don't truncate output\n"), out);
-	fputs(_(" -o, --output[=<list>]    define the columns to output\n"), out);
+	fputs(_(" -o, --output[=<list>]    columns to display (see Columns:)\n"), out);
 	fputs(_(" -p, --pwd                display information related to login by password.\n"), out);
 	fputs(_(" -r, --raw                display in raw mode\n"), out);
 	fputs(_(" -s, --system-accs        display system accounts\n"), out);
diff --git a/misc-utils/fincore.c b/misc-utils/fincore.c
index 9ef9127..a34f95c 100644
--- a/misc-utils/fincore.c
+++ b/misc-utils/fincore.c
@@ -270,7 +270,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -J, --json            use JSON output format\n"), out);
 	fputs(_(" -b, --bytes           print sizes in bytes rather than in human readable format\n"), out);
 	fputs(_(" -n, --noheadings      don't print headings\n"), out);
-	fputs(_(" -o, --output <list>   output columns\n"), out);
+	fputs(_(" -o, --output <list>   columns to display (see Columns:)\n"), out);
 	fputs(_(" -r, --raw             use raw output format\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 5219425..fa4a573 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1226,7 +1226,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -N, --task <tid>       use alternative namespace (/proc/<tid>/mountinfo file)\n"), out);
 	fputs(_(" -n, --noheadings       don't print column headings\n"), out);
 	fputs(_(" -O, --options <list>   limit the set of filesystems by mount options\n"), out);
-	fputs(_(" -o, --output <list>    the output columns to be shown\n"), out);
+	fputs(_(" -o, --output <list>    columns to display (see Columns:)\n"), out);
 	fputs(_(" -P, --pairs            use key=\"value\" output format\n"), out);
 	fputs(_(" -R, --submounts        print all submounts for the matching filesystems\n"), out);
 	fputs(_(" -r, --raw              use raw output format\n"), out);
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 983804b..bcc0681 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1648,7 +1648,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -T, --tree           use tree format output\n"), out);
 	fputs(_(" -m, --perms          output info about permissions\n"), out);
 	fputs(_(" -n, --noheadings     don't print headings\n"), out);
-	fputs(_(" -o, --output <list>  output columns\n"), out);
+	fputs(_(" -o, --output <list>  columns to display (see Columns:)\n"), out);
 	fputs(_(" -O, --output-all     output all columns\n"), out);
 	fputs(_(" -p, --paths          print complete device path\n"), out);
 	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), out);
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index d872e2d..3db718b 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -501,7 +501,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -J, --json             use JSON output format\n"), out);
 	fputs(_(" -i, --noinaccessible   ignore locks without read permissions\n"), out);
 	fputs(_(" -n, --noheadings       don't print headings\n"), out);
-	fputs(_(" -o, --output <list>    define which output columns to use\n"), out);
+	fputs(_(" -o, --output <list>    columns to display (see Columns:)\n"), out);
 	fputs(_(" -p, --pid <pid>        display only locks held by this process\n"), out);
 	fputs(_(" -r, --raw              use the raw output format\n"), out);
 	fputs(_(" -u, --notruncate       don't truncate text in columns\n"), out);
diff --git a/misc-utils/uuidparse.c b/misc-utils/uuidparse.c
index d9dba49..9d2a25f 100644
--- a/misc-utils/uuidparse.c
+++ b/misc-utils/uuidparse.c
@@ -101,7 +101,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_OPTIONS, stdout);
 	fputs(_(" -J, --json             use JSON output format\n"), stdout);
 	fputs(_(" -n, --noheadings       don't print headings\n"), stdout);
-	fputs(_(" -o, --output <list>    define which output columns to use\n"), stdout);
+	fputs(_(" -o, --output <list>    columns to display (see Columns:)\n"), stdout);
 	fputs(_(" -r, --raw              use the raw output format\n"), stdout);
 
 	fputs(USAGE_SEPARATOR, stdout);
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index d4740bd..0a5e8e0 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -415,7 +415,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -J, --json                    use JSON --list output format\n"), out);
 	fputs(_(" -l, --list                    list info about all or specified (default)\n"), out);
 	fputs(_(" -n, --noheadings              don't print headings for --list output\n"), out);
-	fputs(_(" -O, --output <cols>           specify columns to output for --list\n"), out);
+	fputs(_(" -O, --output <cols>           columns to display in --list (see Columns:)\n"), out);
 	fputs(_("     --raw                     use raw --list output format\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 424b9de..6e2af79 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -2060,8 +2060,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -b, --online            print online CPUs only (default for -p)\n"), out);
 	fputs(_(" -c, --offline           print offline CPUs only\n"), out);
 	fputs(_(" -J, --json              use JSON for default or extended format\n"), out);
-	fputs(_(" -e, --extended[=<list>] print out an extended readable format\n"), out);
-	fputs(_(" -p, --parse[=<list>]    print out a parsable format\n"), out);
+	fputs(_(" -e, --extended[=<list>] display human-readable format (see Columns:)\n"), out);
+	fputs(_(" -p, --parse[=<list>]    display parsable format (see Columns:)\n"), out);
 	fputs(_(" -s, --sysroot <dir>     use specified directory as system root\n"), out);
 	fputs(_(" -x, --hex               print hexadecimal masks rather than lists of CPUs\n"), out);
 	fputs(_(" -y, --physical          print physical instead of logical IDs\n"), out);
diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index 04e7d20..64749f8 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -380,7 +380,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -a, --all            list each individual memory block\n"), out);
 	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
 	fputs(_(" -n, --noheadings     don't print headings\n"), out);
-	fputs(_(" -o, --output <list>  output columns\n"), out);
+	fputs(_(" -o, --output <list>  columns to display (see Columns:)\n"), out);
 	fputs(_(" -r, --raw            use raw output format\n"), out);
 	fputs(_(" -s, --sysroot <dir>  use the specified directory as system root\n"), out);
 	fputs(_("     --summary[=when] print summary information (never,always or only)\n"), out);
diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 6ed772c..d42e389 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -620,7 +620,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -J, --json             use JSON output format\n"), out);
 	fputs(_(" -l, --list             use list format output\n"), out);
 	fputs(_(" -n, --noheadings       don't print headings\n"), out);
-	fputs(_(" -o, --output <list>    define which output columns to use\n"), out);
+	fputs(_(" -o, --output <list>    columns to display (see Columns:)\n"), out);
 	fputs(_(" -p, --task <pid>       print process namespaces\n"), out);
 	fputs(_(" -r, --raw              use the raw output format\n"), out);
 	fputs(_(" -u, --notruncate       don't truncate text in columns\n"), out);
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 37e0f9f..a6d38ac 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -168,7 +168,7 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(_("\nGeneral Options:\n"), out);
 	fputs(_(" -p, --pid <pid>        process id\n"
-		" -o, --output <list>    define which output columns to use\n"
+		" -o, --output <list>    columns to display (see Columns:)\n"
 		"     --noheadings       don't print headings\n"
 		"     --raw              use the raw output format\n"
 		"     --verbose          verbose output\n"
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 28f3bd8..ddf67a3 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -801,7 +801,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -o, --options <list>     comma-separated list of swap options\n"), out);
 	fputs(_(" -p, --priority <prio>    specify the priority of the swap device\n"), out);
 	fputs(_(" -s, --summary            display summary about used swap devices (DEPRECATED)\n"), out);
-	fputs(_("     --show[=<columns>]   display summary in definable table\n"), out);
+	fputs(_("     --show[=<columns>]   display summary in definable table (see Columns:)\n"), out);
 	fputs(_("     --noheadings         don't print table heading (with --show)\n"), out);
 	fputs(_("     --raw                use the raw output format (with --show)\n"), out);
 	fputs(_("     --bytes              display swap size in bytes in --show output\n"), out);
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 1b82fc8..327c9c6 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -183,7 +183,7 @@ static void __attribute__((__noreturn__)) usage(void)
 		" -I, --noident          don't print watchdog identity information\n"
 		" -n, --noheadings       don't print headings for flags table\n"
 		" -O, --oneline          print all information on one line\n"
-		" -o, --output <list>    output columns of the flags\n"
+		" -o, --output <list>    columns to display for flags (see Columns:)\n"
 		" -r, --raw              use raw output format for flags table\n"
 		" -T, --notimeouts       don't print watchdog timeouts\n"
 		" -s, --settimeout <sec> set watchdog timeout\n"
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 3d604cf..07e3784 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -536,7 +536,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -b, --bytes               print sizes in bytes rather than in human readable format\n"), out);
 	fputs(_(" -f, --find                find a free device\n"), out);
 	fputs(_(" -n, --noheadings          don't print headings\n"), out);
-	fputs(_(" -o, --output <list>       columns to use for status output\n"), out);
+	fputs(_(" -o, --output <list>       columns to display in status output (see Columns:)\n"), out);
 	fputs(_("     --raw                 use raw status output format\n"), out);
 	fputs(_(" -r, --reset               reset all specified devices\n"), out);
 	fputs(_(" -s, --size <size>         device size\n"), out);
