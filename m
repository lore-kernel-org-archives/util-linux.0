Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:64244 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbbHAIX2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 1 Aug 2015 04:23:28 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/7] textual: adjust grammar and punctuation of some messages
Date: Sat,  1 Aug 2015 10:23:07 +0200
Message-Id: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also equalize three messages to one other one,
and fix a typo in USE_COLORS_BY_DEFAULT.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c     |    2 +-
 disk-utils/fdisk-menu.c |    2 +-
 disk-utils/fdisk.c      |    2 +-
 disk-utils/fsck.c       |    6 +++---
 disk-utils/sfdisk.c     |   28 ++++++++++++++--------------
 include/colors.h        |    6 +++---
 sys-utils/flock.c       |    2 +-
 sys-utils/lsipc.c       |   10 +++++-----
 8 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index f536f09..3917099 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -2469,7 +2469,7 @@ static int ui_run(struct cfdisk *cf)
 	ui_draw_extra(cf);
 
 	if (fdisk_is_readonly(cf->cxt))
-		ui_warnx(_("Device open in read-only mode."));
+		ui_warnx(_("Device is open in read-only mode."));
 	else if (cf->wrong_order)
 		ui_info(_("Note that partition table entries are not in disk order now."));
 
diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index 5159e21..81bdb31 100644
--- a/disk-utils/fdisk-menu.c
+++ b/disk-utils/fdisk-menu.c
@@ -535,7 +535,7 @@ static int generic_menu_cb(struct fdisk_context **cxt0,
 		break;
 	case 'w':
 		if (fdisk_is_readonly(cxt)) {
-			fdisk_warnx(cxt, _("Device open in read-only mode."));
+			fdisk_warnx(cxt, _("Device is open in read-only mode."));
 			break;
 		}
 		rc = fdisk_write_disklabel(cxt);
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 0e45676..6b20685 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -950,7 +950,7 @@ int main(int argc, char **argv)
 		if (rc == -EACCES) {
 			rc = fdisk_assign_device(cxt, argv[optind], 1);
 			if (rc == 0)
-				fdisk_warnx(cxt, _("Device open in read-only mode."));
+				fdisk_warnx(cxt, _("Device is open in read-only mode."));
 		}
 		if (rc)
 			err(EXIT_FAILURE, _("cannot open %s"), argv[optind]);
diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 465e6d3..a103408 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -1523,10 +1523,10 @@ static void parse_argv(int argc, char *argv[])
 			case 'r':
 				report_stats = 1;
 				if (arg[j+1]) {					/* -r<fd> */
-					report_stats_fd = strtou32_or_err(arg+j+1, _("invalid argument -r"));
+					report_stats_fd = strtou32_or_err(arg+j+1, _("invalid argument of -r"));
 					goto next_arg;
 				} else if (i+1 < argc && *argv[i+1] >= '0' && *argv[i+1] <= '9') {	/* -r <fd> */
-					report_stats_fd = strtou32_or_err(argv[i+1], _("invalid argument -r"));
+					report_stats_fd = strtou32_or_err(argv[i+1], _("invalid argument of -r"));
 					++i;
 					goto next_arg;
 				}
@@ -1574,7 +1574,7 @@ static void parse_argv(int argc, char *argv[])
 		report_stats_file = fdopen(report_stats_fd, "w");
 		if (!report_stats_file)
 			err(FSCK_EX_ERROR,
-				_("invalid argument -r %d"),
+				_("invalid argument of -r: %d"),
 				report_stats_fd);
 	}
 
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index d3b9baa..052153a 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -698,7 +698,7 @@ static void assign_device_partition(struct sfdisk *sf,
 
 	lb = fdisk_get_label(sf->cxt, NULL);
 	if (!lb)
-		errx(EXIT_FAILURE, _("%s: not found partition table."), devname);
+		errx(EXIT_FAILURE, _("%s: no partition table found"), devname);
 
 	n = fdisk_get_npartitions(sf->cxt);
 	if (partno > n)
@@ -980,10 +980,10 @@ static void command_fdisk_help(void)
 	fputs(_("   write    write table to disk and exit\n"), stdout);
 	fputs(_("   quit     show new situation and wait for user's feedback before write\n"), stdout);
 	fputs(_("   abort    exit sfdisk shell\n"), stdout);
-	fputs(_("   print    print partition table.\n"), stdout);
-	fputs(_("   help     this help.\n"), stdout);
+	fputs(_("   print    display the partition table\n"), stdout);
+	fputs(_("   help     show this help text\n"), stdout);
 	fputc('\n', stdout);
-	fputs(_("   CTRL-D   the same like 'quit' command\n"), stdout);
+	fputs(_("   Ctrl-D   the same as 'quit'\n"), stdout);
 
 	fputc('\n', stdout);
 	color_scheme_enable("help-title", UL_COLOR_BOLD);
@@ -992,28 +992,28 @@ static void command_fdisk_help(void)
 	fputs(_("   <start>, <size>, <type>, <bootable>\n"), stdout);
 
 	fputc('\n', stdout);
-	fputs(_("   <start>  begin of the partition in sectors or bytes if specified\n"
-		"            in format <number>{K,M,G,T,P,E,Z,Y}. The default is\n"
-		"            the first free space.\n"), stdout);
+	fputs(_("   <start>  Beginning of the partition in sectors, or bytes if\n"
+		"            specified in the format <number>{K,M,G,T,P,E,Z,Y}.\n"
+		"            The default is the first free space.\n"), stdout);
 
 	fputc('\n', stdout);
-	fputs(_("   <size>   size of the partition in sectors if specified in format\n"
-		"            <number>{K,M,G,T,P,E,Z,Y} then it's interpreted as size\n"
-		"            in bytes. The default is all available space.\n"), stdout);
+	fputs(_("   <size>   Size of the partition in sectors, or bytes if\n"
+		"            specified in the format <number>{K,M,G,T,P,E,Z,Y}.\n"
+		"            The default is all available space.\n"), stdout);
 
 	fputc('\n', stdout);
-	fputs(_("   <type>   partition type. The default is Linux data partition.\n"), stdout);
+	fputs(_("   <type>   The partition type.  Default is a Linux data partition.\n"), stdout);
 	fputs(_("            MBR: hex or L,S,E,X shortcuts.\n"), stdout);
-	fputs(_("            GPT: uuid or L,S,H shortcuts.\n"), stdout);
+	fputs(_("            GPT: UUID or L,S,H shortcuts.\n"), stdout);
 
 	fputc('\n', stdout);
-	fputs(_("   <bootable>  '*' to mark MBR partition as bootable. \n"), stdout);
+	fputs(_("   <bootable>  Use '*' to mark an MBR partition as bootable.\n"), stdout);
 
 	fputc('\n', stdout);
 	color_scheme_enable("help-title", UL_COLOR_BOLD);
 	fputs(_(" Example:\n"), stdout);
 	color_disable();
-	fputs(_("   , 4G     creates 4GiB partition on default start offset.\n"), stdout);
+	fputs(_("   , 4G     Creates a 4GiB partition at default start offset.\n"), stdout);
 	fputc('\n', stdout);
 }
 
diff --git a/include/colors.h b/include/colors.h
index fda1ca9..bd34a4f 100644
--- a/include/colors.h
+++ b/include/colors.h
@@ -23,10 +23,10 @@ enum colortmode {
 	__UL_NCOLORMODES	/* last */
 };
 
-#ifdef USE_COLORS_BY_DEFAUL
-# define USAGE_COLORS_DEFAULT	N_("colors enabled by default")
+#ifdef USE_COLORS_BY_DEFAULT
+# define USAGE_COLORS_DEFAULT	N_("colors are enabled by default")
 #else
-# define USAGE_COLORS_DEFAULT   N_("colors disabled by default")
+# define USAGE_COLORS_DEFAULT   N_("colors are disabled by default")
 #endif
 
 extern int colormode_from_string(const char *str);
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index fda7bdc..2b29de1 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -250,7 +250,7 @@ int main(int argc, char *argv[])
 			block = LOCK_NB;
 		} else
 			if (setup_timer(&t_id, &timeout, &timeout_handler))
-				err(EX_OSERR, _("cannot not setup timer"));
+				err(EX_OSERR, _("cannot set up timer"));
 	}
 
 	if (verbose)
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index eecb508..f83e6ca 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -294,15 +294,15 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	for (i = COLDESC_IDX_GEN_FIRST; i <= COLDESC_IDX_GEN_LAST; i++)
 		fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
 
-	fprintf(out, _("\nShared memory columns (--shmems):\n"));
+	fprintf(out, _("\nShared-memory columns (--shmems):\n"));
 	for (i = COLDESC_IDX_SHM_FIRST; i <= COLDESC_IDX_SHM_LAST; i++)
 		fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
 
-	fprintf(out, _("\nMessages queues columns (--queues):\n"));
+	fprintf(out, _("\nMessage-queue columns (--queues):\n"));
 	for (i = COLDESC_IDX_MSG_FIRST; i <= COLDESC_IDX_MSG_LAST; i++)
 		fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
 
-	fprintf(out, _("\nSemaphores columns (--semaphores):\n"));
+	fprintf(out, _("\nSemaphore columns (--semaphores):\n"));
 	for (i = COLDESC_IDX_SEM_FIRST; i <= COLDESC_IDX_SEM_LAST; i++)
 		fprintf(out, " %14s  %s\n", coldescs[i].name, _(coldescs[i].help));
 
@@ -716,7 +716,7 @@ static void do_sem_global(struct libscols_table *tb)
 	}
 
 	global_set_data(tb, "SEMMNS", _("Total number of semaphores"), nsems, lim.semmns);
-	global_set_data(tb, "SEMMNI", _("Number of Semaphore IDs"), nsets, lim.semmni);
+	global_set_data(tb, "SEMMNI", _("Number of semaphore IDs"), nsets, lim.semmni);
 }
 
 static void do_msg(int id, struct lsipc_control *ctl, struct libscols_table *tb)
@@ -1266,7 +1266,7 @@ int main(int argc, char *argv[])
 	if (msg + shm + sem == 0) {
 		msg = shm = sem = global = 1;
 		if (show_time || show_creat || id != -1)
-			errx(EXIT_FAILURE, _("the --global is mutually exclusive with --creator, --id and --time"));
+			errx(EXIT_FAILURE, _("--global is mutually exclusive with --creator, --id and --time"));
 	}
 	if (global) {
 		add_column(columns, ncolumns++, COL_RESOURCE);
-- 
1.7.0.4

