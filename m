Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdFZSaG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 14:30:06 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFR2O-1dV54o1L3k-00EIlO for
 <util-linux@vger.kernel.org>; Mon, 26 Jun 2017 20:29:54 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] misc: consolidate all --help option descriptions
Date: Mon, 26 Jun 2017 20:29:49 +0200
Message-Id: <20170626182952.15988-4-sweet_f_a@gmx.de>
In-Reply-To: <20170626182952.15988-1-sweet_f_a@gmx.de>
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Now we are always using the same text also for commands
which had still hardcoded descriptions or where we can't
use the standard PRINT_USAGE_HELP macro.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.c         |  4 ++--
 disk-utils/fsck.cramfs.c  |  4 ++--
 disk-utils/mkfs.bfs.c     |  5 ++---
 disk-utils/mkfs.c         |  5 +----
 disk-utils/mkswap.c       |  5 +++--
 login-utils/chfn.c        |  4 ++--
 login-utils/chsh.c        |  4 ++--
 misc-utils/findmnt.c      |  1 -
 misc-utils/namei.c        |  4 ++--
 misc-utils/wipefs.c       |  5 ++---
 schedutils/taskset.c      |  5 +++--
 sys-utils/chcpu.c         | 22 ++++++++++++----------
 sys-utils/dmesg.c         |  2 +-
 sys-utils/prlimit.c       |  4 ++--
 term-utils/agetty.c       |  4 ++--
 term-utils/script.c       |  4 ++--
 term-utils/scriptreplay.c |  4 ++--
 term-utils/setterm.c      |  5 +++--
 text-utils/col.c          |  6 ++++--
 text-utils/more.c         |  4 ++--
 20 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 918103ac0..c68d32ee5 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -1394,8 +1394,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -V         explain what is being done\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_(" -?, --help     display this help and exit\n"), out);
-	fputs(_("     --version  output version information and exit\n"), out);
+	printf( " -?, --help     %s\n", USAGE_HELP_TXT);
+	printf( "     --version  %s\n", USAGE_VERSION_TXT);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("See the specific fsck.* commands for available fs-options."), out);
 	fprintf(out, USAGE_MAN_TAIL("fsck(8)"));
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index df13d2bb4..071cb0c61 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -120,9 +120,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -b, --blocksize <size>   use this blocksize, defaults to page size\n"), out);
 	fputs(_("     --extract[=<dir>]    test uncompression, optionally extract into <dir>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
-	PRINT_USAGE_HELP(16);
-	fputs(USAGE_SEPARATOR, out);
+	PRINT_USAGE_HELP(26);
 
+	printf(USAGE_MAN_TAIL("fsck.cramfs(8)"));
 	exit(FSCK_EX_OK);
 }
 
diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index b19afa7cd..2cf1f313c 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -84,9 +84,8 @@ static void __attribute__((__noreturn__)) usage(void)
 		       " -v, --verbose       explain what is being done\n"
 		       " -c                  this option is silently ignored\n"
 		       " -l                  this option is silently ignored\n"
-		       " -V, --version       output version information and exit\n"
-		       "                     -V as version must be only option\n"
-		       " -h, --help          display this help and exit\n\n"));
+		       ));
+	PRINT_USAGE_HELP(21);
 
 	fprintf(out, USAGE_MAN_TAIL("mkfs.bfs(8)"));
 	exit(EXIT_SUCCESS);
diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index 25cc59d20..4a9de3e8d 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -55,12 +55,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fprintf(out, _("     <size>         number of blocks to be used on the device\n"));
 	fprintf(out, _(" -V, --verbose      explain what is being done;\n"
 		       "                      specifying -V more than once will cause a dry-run\n"));
-	fprintf(out, _(" -V, --version      display version information and exit;\n"
-		       "                      -V as --version must be the only option\n"));
-	fprintf(out, _(" -h, --help         display this help text and exit\n"));
+	PRINT_USAGE_HELP(20);
 
 	fprintf(out, USAGE_MAN_TAIL("mkfs(8)"));
-
 	exit(EXIT_SUCCESS);
 }
 
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 73e5258ed..79097f220 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -160,9 +160,10 @@ static void __attribute__((__noreturn__)) usage(void)
 		" -L, --label LABEL         specify label\n"
 		" -v, --swapversion NUM     specify swap-space version number\n"
 		" -U, --uuid UUID           specify the uuid to use\n"
-		" -V, --version             output version information and exit\n"
-		" -h, --help                display this help and exit\n\n"));
+		));
+	PRINT_USAGE_HELP(27);
 
+	printf(USAGE_MAN_TAIL("mkswap(8)"));
 	exit(EXIT_SUCCESS);
 }
 
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 7a57e9169..c86327099 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -104,8 +104,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -p, --office-phone <phone>   office phone number\n"), fp);
 	fputs(_(" -h, --home-phone <phone>     home phone number\n"), fp);
 	fputs(USAGE_SEPARATOR, fp);
-	fputs(_(" -u, --help     display this help and exit\n"), fp);
-	fputs(_(" -v, --version  output version information and exit\n"), fp);
+	printf( " -u, --help                   %s\n", USAGE_HELP_TXT);
+	printf( " -v, --version                %s\n", USAGE_VERSION_TXT);
 	fprintf(fp, USAGE_MAN_TAIL("chfn(1)"));
 	exit(EXIT_SUCCESS);
 }
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 1083583b9..895ce17c5 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -83,8 +83,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -s, --shell <shell>  specify login shell\n"), fp);
 	fputs(_(" -l, --list-shells    print list of shells and exit\n"), fp);
 	fputs(USAGE_SEPARATOR, fp);
-	fputs(_(" -u, --help     display this help and exit\n"), fp);
-	fputs(_(" -v, --version  output version information and exit\n"), fp);
+	printf( " -u, --help           %s\n", USAGE_HELP_TXT);
+	printf( " -v, --version        %s\n", USAGE_VERSION_TXT);
 	fprintf(fp, USAGE_MAN_TAIL("chsh(1)"));
 	exit(EXIT_SUCCESS);
 }
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index b5e4d66d0..610314eb3 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1243,7 +1243,6 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputc('\n', out);
 	fputs(_(" -x, --verify           verify mount table content (default is fstab)\n"), out);
 	fputs(_("     --verbose          print more details\n"), out);
-	fputc('\n', out);
 
 	fputs(USAGE_SEPARATOR, out);
 	PRINT_USAGE_HELP(24);
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index dcaf5d2eb..93989ec55 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -336,14 +336,14 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Follow a pathname until a terminal point is found.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -h, --help          displays this help text\n"
-		" -V, --version       output version information and exit\n"
+	fputs(_(
 		" -x, --mountpoints   show mount point directories with a 'D'\n"
 		" -m, --modes         show the mode bits of each file\n"
 		" -o, --owners        show owner and group name of each file\n"
 		" -l, --long          use a long listing format (-m -o -v) \n"
 		" -n, --nosymlinks    don't follow symlinks\n"
 		" -v, --vertical      vertical align of modes and owners\n"), out);
+	PRINT_USAGE_HELP(21);
 
 	fprintf(out, USAGE_MAN_TAIL("namei(1)"));
 	exit(EXIT_SUCCESS);
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 0bd53253d..1eec9c404 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -465,16 +465,15 @@ usage(void)
 	fputs(_(" -a, --all           wipe all magic strings (BE CAREFUL!)\n"
 		" -b, --backup        create a signature backup in $HOME\n"
 		" -f, --force         force erasure\n"
-		" -h, --help          show this help text\n"
 		" -n, --no-act        do everything except the actual write() call\n"
 		" -o, --offset <num>  offset to erase, in bytes\n"
 		" -p, --parsable      print out in parsable instead of printable format\n"
 		" -q, --quiet         suppress output messages\n"
 		" -t, --types <list>  limit the set of filesystem, RAIDs or partition tables\n"
-		" -V, --version       output version information and exit\n"), out);
+		), out);
+	PRINT_USAGE_HELP(21);
 
 	fprintf(out, USAGE_MAN_TAIL("wipefs(8)"));
-
 	exit(EXIT_SUCCESS);
 }
 
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index c55b986fb..f5ac1586b 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -61,9 +61,10 @@ static void __attribute__((__noreturn__)) usage(void)
 		" -a, --all-tasks         operate on all the tasks (threads) for a given pid\n"
 		" -p, --pid               operate on existing given pid\n"
 		" -c, --cpu-list          display and specify cpus in list format\n"
-		" -h, --help              display this help\n"
-		" -V, --version           output version information\n\n"));
+		));
+	PRINT_USAGE_HELP(25);
 
+	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, _(
 		"The default behavior is to run a new command:\n"
 		"    %1$s 03 sshd -b 1024\n"
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index c0f568073..ff52b0c07 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -242,16 +242,18 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Configure CPUs in a multi-processor system.\n"), out);
 
-	puts(_(	"\nOptions:\n"
-		"  -h, --help                    print this help\n"
-		"  -e, --enable <cpu-list>       enable cpus\n"
-		"  -d, --disable <cpu-list>      disable cpus\n"
-		"  -c, --configure <cpu-list>    configure cpus\n"
-		"  -g, --deconfigure <cpu-list>  deconfigure cpus\n"
-		"  -p, --dispatch <mode>         set dispatching mode\n"
-		"  -r, --rescan                  trigger rescan of cpus\n"
-		"  -V, --version                 output version information and exit\n"));
-
+	fputs(USAGE_OPTIONS, stdout);
+	fputs(_(
+		" -e, --enable <cpu-list>       enable cpus\n"
+		" -d, --disable <cpu-list>      disable cpus\n"
+		" -c, --configure <cpu-list>    configure cpus\n"
+		" -g, --deconfigure <cpu-list>  deconfigure cpus\n"
+		" -p, --dispatch <mode>         set dispatching mode\n"
+		" -r, --rescan                  trigger rescan of cpus\n"
+		), stdout);
+	PRINT_USAGE_HELP(31);
+
+	printf(USAGE_MAN_TAIL("chcpu(8)"));
 	exit(EXIT_SUCCESS);
 }
 
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index eb47b9129..579635bbe 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -318,7 +318,7 @@ static void __attribute__((__noreturn__)) usage(void)
 		fprintf(out, " %7s - %s\n",
 			level_names[i].name,
 			_(level_names[i].help));
-	fputs(USAGE_SEPARATOR, out);
+
 	fprintf(out, USAGE_MAN_TAIL("dmesg(1)"));
 	exit(EXIT_SUCCESS);
 }
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 44db54ca5..eb3f12880 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -172,8 +172,8 @@ static void __attribute__((__noreturn__)) usage(void)
 		"     --noheadings       don't print headings\n"
 		"     --raw              use the raw output format\n"
 		"     --verbose          verbose output\n"
-		" -h, --help             display this help and exit\n"
-		" -V, --version          output version information and exit\n"), out);
+		), out);
+	PRINT_USAGE_HELP(24);
 
 	fputs(_("\nResources Options:\n"), out);
 	fputs(_(" -c, --core             maximum size of core files created\n"
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 869513b22..ed74050c3 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -2110,8 +2110,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("     --delay <number>       sleep seconds before prompt\n"), out);
 	fputs(_("     --nice <number>        run login with this priority\n"), out);
 	fputs(_("     --reload               reload prompts on running agetty instances\n"), out);
-	fputs(_("     --help                 display this help and exit\n"), out);
-	fputs(_("     --version              output version information and exit\n"), out);
+	printf( "     --help                 %s\n", USAGE_HELP_TXT);
+	printf( "     --version              %s\n", USAGE_VERSION_TXT);
 	fprintf(out, USAGE_MAN_TAIL("agetty(8)"));
 
 	exit(EXIT_SUCCESS);
diff --git a/term-utils/script.c b/term-utils/script.c
index a93a89ec9..9b0db0eb9 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -171,8 +171,8 @@ static void __attribute__((__noreturn__)) usage(void)
 		"     --force             use output file even when it is a link\n"
 		" -q, --quiet             be quiet\n"
 		" -t, --timing[=<file>]   output timing data to stderr (or to FILE)\n"
-		" -V, --version           output version information and exit\n"
-		" -h, --help              display this help and exit\n\n"), out);
+		), out);
+	PRINT_USAGE_HELP(25);
 
 	fprintf(out, USAGE_MAN_TAIL("script(1)"));
 	exit(EXIT_SUCCESS);
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index a83f9a2eb..71598a0d1 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -52,8 +52,8 @@ usage(void)
 		" -s, --typescript <file> script terminal session output file\n"
 		" -d, --divisor <num>     speed up or slow down execution with time divisor\n"
 		" -m, --maxdelay <num>    wait at most this many seconds between updates\n"
-		" -V, --version           output version information and exit\n"
-		" -h, --help              display this help and exit\n\n"), out);
+		), out);
+	PRINT_USAGE_HELP(25);
 
 	fprintf(out, USAGE_MAN_TAIL("scriptreplay(1)"));
 	exit(EXIT_SUCCESS);
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 8ab5b45d7..60e0422e5 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -418,8 +418,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --powerdown     [0-60]            set vesa powerdown interval in minutes\n"), out);
 	fputs(_(" --blength       [0-2000]          duration of the bell in milliseconds\n"), out);
 	fputs(_(" --bfreq         <number>          bell frequency in Hertz\n"), out);
-	fputs(_(" --version                         show version information and exit\n"), out);
-	fputs(_(" --help                            display this help and exit\n"), out);
+	printf( " --help                            %s\n", USAGE_HELP_TXT);
+	printf( " --version                         %s\n", USAGE_VERSION_TXT);
+
 	fprintf(out, USAGE_MAN_TAIL("setterm(1)"));
 	exit(EXIT_SUCCESS);
 }
diff --git a/text-utils/col.c b/text-utils/col.c
index a473e55fb..c7ecc422f 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -142,9 +142,11 @@ static void __attribute__((__noreturn__)) usage(void)
 		" -h, --tabs             convert spaces to tabs\n"
 		" -x, --spaces           convert tabs to spaces\n"
 		" -l, --lines NUM        buffer at least NUM lines\n"
-		" -V, --version          output version information and exit\n"
-		" -H, --help             display this help and exit\n\n"));
+		));
+	printf( " -H, --help             %s\n", USAGE_HELP_TXT);
+	printf( " -V, --version          %s\n", USAGE_VERSION_TXT);
 
+	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, _(
 		"%s reads from standard input and writes to standard output\n\n"),
 		program_invocation_short_name);
diff --git a/text-utils/more.c b/text-utils/more.c
index 35786567a..610711dbc 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -247,8 +247,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" +/<string>  display file beginning from search string match\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_("     --help     display this help and exit\n"), out);
-	fputs(_(" -V, --version  output version information and exit\n"), out);
+	printf( "     --help     %s\n", USAGE_HELP_TXT);
+	printf( " -V, --version  %s\n", USAGE_VERSION_TXT);
 	fprintf(out, USAGE_MAN_TAIL("more(1)"));
 	exit(EXIT_SUCCESS);
 }
-- 
2.12.3

