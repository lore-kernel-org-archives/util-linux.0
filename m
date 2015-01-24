Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:42936 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbAXHTE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 24 Jan 2015 02:19:04 -0500
Received: by mail-wg0-f50.google.com with SMTP id b13so1125200wgh.9
        for <util-linux@vger.kernel.org>; Fri, 23 Jan 2015 23:19:03 -0800 (PST)
From: Yuri Chornoivan <yurchor@gmail.com>
To: util-linux@vger.kernel.org
Cc: Yuri Chornoivan <yurchor@ukr.net>
Subject: [PATCH] Fix various minor typos
Date: Sat, 24 Jan 2015 09:18:51 +0200
Message-Id: <1422083931-24410-1-git-send-email-yurchor@ukr.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 Documentation/releases/v2.25-ReleaseNotes |  2 +-
 disk-utils/fdisk-list.c                   |  6 +++---
 disk-utils/sfdisk.c                       | 24 ++++++++++++------------
 libfdisk/src/gpt.c                        |  2 +-
 misc-utils/whereis.c                      |  2 +-
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/releases/v2.25-ReleaseNotes b/Documentation/releases/v2.25-ReleaseNotes
index f4faf7a..d9b9ce4 100644
--- a/Documentation/releases/v2.25-ReleaseNotes
+++ b/Documentation/releases/v2.25-ReleaseNotes
@@ -203,7 +203,7 @@ cal:
    - mention where Gregorian reformation happen in September 1752  [Sami Kerola]
    - remove optional from short arg -w  [Tommi Kyntola]
    - remove unnecessary static variables  [Sami Kerola]
-   - remove unnused structure and definition  [Sami Kerola]
+   - remove unused structure and definition  [Sami Kerola]
    - rename ascii_wnum() to ascii_weeknum()  [Sami Kerola]
    - simplify ascii_weeknum() function  [Sami Kerola]
    - use control structure for run time configuration  [Sami Kerola]
diff --git a/disk-utils/fdisk-list.c b/disk-utils/fdisk-list.c
index 824eb48..c65b8b4 100644
--- a/disk-utils/fdisk-list.c
+++ b/disk-utils/fdisk-list.c
@@ -104,13 +104,13 @@ void list_disklabel(struct fdisk_context *cxt)
 
 	itr = fdisk_new_iter(FDISK_ITER_FORWARD);
 	if (!itr) {
-		fdisk_warn(cxt, _("faild to allocate iterator"));
+		fdisk_warn(cxt, _("failed to allocate iterator"));
 		goto done;
 	}
 
 	out = scols_new_table();
 	if (!out) {
-		fdisk_warn(cxt, _("faild to allocate output table"));
+		fdisk_warn(cxt, _("failed to allocate output table"));
 		goto done;
 	}
 
@@ -151,7 +151,7 @@ void list_disklabel(struct fdisk_context *cxt)
 		struct libscols_line *ln = scols_table_new_line(out, NULL);
 
 		if (!ln) {
-			fdisk_warn(cxt, _("faild to allocate output line"));
+			fdisk_warn(cxt, _("failed to allocate output line"));
 			goto done;
 		}
 
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 4142181..599e010 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -659,7 +659,7 @@ static void assign_device_partition(struct sfdisk *sf,
 		errx(EXIT_FAILURE, _("%s: partition %zu: partition table contains %zu "
 				     "partitions only."), devname, partno, n);
 	if (!fdisk_is_partition_used(sf->cxt, partno - 1))
-		errx(EXIT_FAILURE, _("%s: partition %zu: partition unnused"),
+		errx(EXIT_FAILURE, _("%s: partition %zu: partition unused"),
 				devname, partno);
 }
 
@@ -684,7 +684,7 @@ static int command_parttype(struct sfdisk *sf, int argc, char **argv)
 	if (argc == 3)
 		typestr = argv[2];
 	else if (argc > 3)
-		errx(EXIT_FAILURE, _("uneexpected arguments"));
+		errx(EXIT_FAILURE, _("unexpected arguments"));
 
 	/* read-only when a new <type> undefined */
 	assign_device_partition(sf, devname, partno, !typestr);
@@ -748,7 +748,7 @@ static int command_partuuid(struct sfdisk *sf, int argc, char **argv)
 	if (argc == 3)
 		uuid = argv[2];
 	else if (argc > 3)
-		errx(EXIT_FAILURE, _("uneexpected arguments"));
+		errx(EXIT_FAILURE, _("unexpected arguments"));
 
 	/* read-only if uuid not given */
 	assign_device_partition(sf, devname, partno, !uuid);
@@ -803,7 +803,7 @@ static int command_partlabel(struct sfdisk *sf, int argc, char **argv)
 	if (argc == 3)
 		name = argv[2];
 	else if (argc > 3)
-		errx(EXIT_FAILURE, _("uneexpected arguments"));
+		errx(EXIT_FAILURE, _("unexpected arguments"));
 
 	/* read-only if name not given */
 	assign_device_partition(sf, devname, partno, !name);
@@ -859,7 +859,7 @@ static int command_partattrs(struct sfdisk *sf, int argc, char **argv)
 	if (argc == 3)
 		attrs = argv[2];
 	else if (argc > 3)
-		errx(EXIT_FAILURE, _("uneexpected arguments"));
+		errx(EXIT_FAILURE, _("unexpected arguments"));
 
 	/* read-only if name not given */
 	assign_device_partition(sf, devname, partno, !attrs);
@@ -932,7 +932,7 @@ static void command_fdisk_help(void)
 	fputs(_(" Commands:\n"), stdout);
 	color_disable();
 	fputs(_("   write    write table to disk and exit\n"), stdout);
-	fputs(_("   quit     show new situation and wait for user's feedbadk before write\n"), stdout);
+	fputs(_("   quit     show new situation and wait for user's feedback before write\n"), stdout);
 	fputs(_("   abort    exit sfdisk shell\n"), stdout);
 	fputs(_("   print    print partition table.\n"), stdout);
 	fputs(_("   help     this help.\n"), stdout);
@@ -943,7 +943,7 @@ static void command_fdisk_help(void)
 	color_scheme_enable("help-title", UL_COLOR_BOLD);
 	fputs(_(" Input format:\n"), stdout);
 	color_disable();
-	fputs(_("   <start>, <size>, <typy>, <bootable>\n"), stdout);
+	fputs(_("   <start>, <size>, <type>, <bootable>\n"), stdout);
 
 	fputc('\n', stdout);
 	fputs(_("   <start>  begin of the partition in sectors or bytes if specified\n"
@@ -1340,7 +1340,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_(" -b, --backup              backup partition table sectors (see -O)\n"), out);
 	fputs(_(" -f, --force               disable all consistency checking\n"), out);
 	fputs(_(" -o, --output <list>       output columns\n"), out);
-	fputs(_(" -O, --backup-file <path>  override default backout file name\n"), out);
+	fputs(_(" -O, --backup-file <path>  override default backup file name\n"), out);
 	fputs(_(" -N, --partno <num>        specify partition number\n"), out);
 	fputs(_(" -X, --label <name>        specify label type (dos, gpt, ...)\n"), out);
 	fputs(_(" -Y, --label-nested <name> specify nested label type (dos, bsd)\n"), out);
@@ -1349,7 +1349,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(_("     --no-reread           do not check whether the device is in use\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" -u, --unit S              deprecated, only sector unit is supported\n"), out);
-	fputs(_(" -L, --Linux               deprecated, only for backward copatibility\n"), out);
+	fputs(_(" -L, --Linux               deprecated, only for backward compatibility\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -1441,11 +1441,11 @@ int main(int argc, char *argv[])
 		case OPT_CHANGE_ID:
 		case OPT_PRINT_ID:
 		case OPT_ID:
-			warnx(_("%s is deprecated in favour of ---part-type"),
+			warnx(_("%s is deprecated in favour of --part-type"),
 				longopts[longidx].name);
 			sf->act = ACT_PARTTYPE;
 		case 'c':
-			warnx(_("--id s deprecated in favour of ---part-type"));
+			warnx(_("--id is deprecated in favour of --part-type"));
 			sf->act = ACT_PARTTYPE;
 			break;
 		case 'd':
@@ -1490,7 +1490,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'u':
 			if (*optarg != 'S')
-				errx(EXIT_FAILURE, _("unssupported unit '%c'"), *optarg);
+				errx(EXIT_FAILURE, _("unsupported unit '%c'"), *optarg);
 			break;
 		case 'v':
 			printf(_("%s from %s\n"), program_invocation_short_name,
diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index f6e1741..7867a30 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -1447,7 +1447,7 @@ static int gpt_entry_attrs_from_string(
 		}
 
 		if (bit < 0) {
-			fdisk_warnx(cxt, _("unssuported GPT attribute bit '%s'"), p);
+			fdisk_warnx(cxt, _("unsuported GPT attribute bit '%s'"), p);
 			return -EINVAL;
 		}
 
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index da809a1..e6f5b41 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -600,7 +600,7 @@ int main(int argc, char **argv)
 				usage(stderr);
 			}
 
-			if (arg_i < i)		/* moved the the next argv[] item */
+			if (arg_i < i)		/* moved to the next argv[] item */
 				break;
 		}
 	}
-- 
1.8.5.6

