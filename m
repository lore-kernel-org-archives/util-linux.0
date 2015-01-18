Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:49975 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752117AbbARURP (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 15:17:15 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] textual: fix spellos and inconsistencies in several program messages
Date: Sun, 18 Jan 2015 21:17:09 +0100
Message-Id: <1421612229-5535-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c     |    4 ++--
 disk-utils/fdisk-list.c |    6 +++---
 disk-utils/fdisk-menu.c |    6 +++---
 disk-utils/sfdisk.c     |   28 ++++++++++++++--------------
 libfdisk/src/gpt.c      |    2 +-
 misc-utils/logger.c     |    2 +-
 sys-utils/swapon.c      |    6 +++---
 sys-utils/unshare.c     |    4 ++--
 term-utils/agetty.c     |    6 +++---
 9 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 1d4e2d5..509fbbd 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1660,7 +1660,7 @@ static int ui_script_read(struct cfdisk *cf)
 	errno = 0;
 	sc = fdisk_new_script_from_file(cf->cxt, buf);
 	if (!sc && errno)
-		ui_warn(_("Cannot open: %s"), buf);
+		ui_warn(_("Cannot open %s"), buf);
 	else if (!sc)
 		ui_warnx(_("Failed to parse script file %s"), buf);
 	else if (fdisk_apply_script(cf->cxt, sc) != 0)
@@ -1701,7 +1701,7 @@ static int ui_script_write(struct cfdisk *cf)
 	DBG(UI, ul_debug("writing dump into: '%s'", buf));
 	f = fopen(buf, "w");
 	if (!f) {
-		ui_warn(_("Cannot open: %s"), buf);
+		ui_warn(_("Cannot open %s"), buf);
 		rc = -errno;
 		goto done;
 	}
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
 
diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index a8af7b8..64e7ba1 100644
--- a/disk-utils/fdisk-menu.c
+++ b/disk-utils/fdisk-menu.c
@@ -459,7 +459,7 @@ static int script_read(struct fdisk_context *cxt)
 	errno = 0;
 	sc = fdisk_new_script_from_file(cxt, filename);
 	if (!sc && errno)
-		fdisk_warn(cxt, _("Cannot open: %s"), filename);
+		fdisk_warn(cxt, _("Cannot open %s"), filename);
 	else if (!sc)
 		fdisk_warnx(cxt, _("Failed to parse script file %s"), filename);
 	else if (fdisk_apply_script(cxt, sc) != 0)
@@ -491,13 +491,13 @@ static int script_write(struct fdisk_context *cxt)
 
 	rc = fdisk_script_read_context(sc, NULL);
 	if (rc) {
-		fdisk_warnx(cxt, _("Failed to read disk layout into script."));
+		fdisk_warnx(cxt, _("Failed to transform disk layout into script"));
 		goto done;
 	}
 
 	f = fopen(filename, "w");
 	if (!f) {
-		fdisk_warn(cxt, _("Cannot open: %s"), filename);
+		fdisk_warn(cxt, _("Cannot open %s"), filename);
 		goto done;
 	}
 
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 499dd8f..99445ad 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -304,7 +304,7 @@ static int write_changes(struct sfdisk *sf)
 	int rc = 0;
 
 	if (sf->noact)
-		fdisk_info(sf->cxt, _("The partition table unchanged (--no-act)."));
+		fdisk_info(sf->cxt, _("The partition table is unchanged (--no-act)."));
 	else {
 		rc = fdisk_write_disklabel(sf->cxt);
 		if (!rc) {
@@ -380,7 +380,7 @@ static int verify_device(struct sfdisk *sf, const char *devname)
 	fdisk_enable_listonly(sf->cxt, 1);
 
 	if (fdisk_assign_device(sf->cxt, devname, 1)) {
-		warn(_("cannot open: %s"), devname);
+		warn(_("cannot open %s"), devname);
 		return 1;
 	}
 
@@ -436,7 +436,7 @@ static int get_size(const char *dev, int silent, uintmax_t *sz)
 	fd = open(dev, O_RDONLY);
 	if (fd < 0) {
 		if (!silent)
-			warn(_("cannot open: %s"), dev);
+			warn(_("cannot open %s"), dev);
 		return -errno;
 	}
 
@@ -490,7 +490,7 @@ static int print_geom(struct sfdisk *sf, const char *devname)
 	fdisk_enable_listonly(sf->cxt, 1);
 
 	if (fdisk_assign_device(sf->cxt, devname, 1)) {
-		warn(_("cannot open: %s"), devname);
+		warn(_("cannot open %s"), devname);
 		return 1;
 	}
 
@@ -656,10 +656,10 @@ static void assign_device_partition(struct sfdisk *sf,
 
 	n = fdisk_get_npartitions(sf->cxt);
 	if (partno > n)
-		errx(EXIT_FAILURE, _("%s: partition %zu: partition table contains %zu "
-				     "partitions only."), devname, partno, n);
+		errx(EXIT_FAILURE, _("%s: partition %zu: partition table contains "
+				     "only %zu partitions"), devname, partno, n);
 	if (!fdisk_is_partition_used(sf->cxt, partno - 1))
-		errx(EXIT_FAILURE, _("%s: partition %zu: partition unnused"),
+		errx(EXIT_FAILURE, _("%s: partition %zu: partition is unused"),
 				devname, partno);
 }
 
@@ -1110,14 +1110,14 @@ static int command_fdisk(struct sfdisk *sf, int argc, char **argv)
 	if (partno >= 0) {
 		size_t n;
 		if (!fdisk_has_label(sf->cxt))
-			errx(EXIT_FAILURE, _("%s: cannot modify partition %d, "
-					     "not found partition table."),
+			errx(EXIT_FAILURE, _("%s: cannot modify partition %d: "
+					     "no partition table was found"),
 					devname, partno);
 		n = fdisk_get_npartitions(sf->cxt);
 		if ((size_t) partno > n)
-			errx(EXIT_FAILURE, _("%s: cannot modify partition %d, "
-					     "partition table contains %zu "
-					     "partitions only."),
+			errx(EXIT_FAILURE, _("%s: cannot modify partition %d: "
+					     "partition table contains only %zu "
+					     "partitions"),
 					devname, partno, n);
 		created = 1;
 		next_partno = partno;
@@ -1233,7 +1233,7 @@ static int command_fdisk(struct sfdisk *sf, int argc, char **argv)
 
 			if (!fdisk_partition_has_start(pa) &&
 			    !fdisk_partition_start_is_default(pa)) {
-				fdisk_info(sf->cxt, _("Ignore partition %zu"), next_partno + 1);
+				fdisk_info(sf->cxt, _("Ignoring partition %zu."), next_partno + 1);
 				continue;
 			}
 			if (!created) {		/* create a new disklabel */
@@ -1486,7 +1486,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'u':
 			if (*optarg != 'S')
-				errx(EXIT_FAILURE, _("unssupported unit '%c'"), *optarg);
+				errx(EXIT_FAILURE, _("unsupported unit '%c'"), *optarg);
 			break;
 		case 'v':
 			printf(_("%s from %s\n"), program_invocation_short_name,
diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index f6e1741..2f1fe2e 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -1447,7 +1447,7 @@ static int gpt_entry_attrs_from_string(
 		}
 
 		if (bit < 0) {
-			fdisk_warnx(cxt, _("unssuported GPT attribute bit '%s'"), p);
+			fdisk_warnx(cxt, _("unsupported GPT attribute bit '%s'"), p);
 			return -EINVAL;
 		}
 
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 35caf9d..a9d4b74 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -678,7 +678,7 @@ int main(int argc, char **argv)
 		if (stdin != jfd)
 			fclose(jfd);
 		if (ret)
-			errx(EXIT_FAILURE, _("journald entry could not be wrote"));
+			errx(EXIT_FAILURE, _("journald entry could not be written"));
 		return EXIT_SUCCESS;
 	}
 #endif
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index c5106ab..bcceb7c 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -758,9 +758,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" <file>                 name of file to be used\n"), out);
 
 	fputs(_("\nAvailable discard policy types (for --discard):\n"
-		" once	  : only single-time area discards are issued\n"
-		" pages	  : freed pages are discarded before they are reused\n"
-		" If no policy is selected, both discard types are enabled (default).\n"), out);
+		" once    : only single-time area discards are issued\n"
+		" pages   : freed pages are discarded before they are reused\n"
+		"If no policy is selected, both discard types are enabled (default).\n"), out);
 
 	fputs(_("\nAvailable columns (for --show):\n"), out);
 	for (i = 0; i < ARRAY_SIZE(infos); i++)
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 83c4a00..58e9164 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -121,7 +121,7 @@ static void usage(int status)
 	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
 	fputs(_("     --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
-	fputs(_(" -s, --setgroups <allow|deny>  control setgroups syscall in user namespaces\n"), out);
+	fputs(_(" -s, --setgroups allow|deny  control the setgroups syscall in user namespaces\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -235,7 +235,7 @@ int main(int argc, char *argv[])
 	if (maproot) {
 		if (setgrpcmd == SETGROUPS_ALLOW)
 			errx(EXIT_FAILURE, _("options --setgroups=allow and "
-					"--map-root-user are mutually exclusive."));
+					"--map-root-user are mutually exclusive"));
 
 		/* since Linux 3.19 unprivileged writing of /proc/self/gid_map
 		 * has s been disabled unless /proc/self/setgroups is written
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 1aafe72..7c97faf 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1446,7 +1446,7 @@ static char *read_os_release(struct options *op, const char *varname)
 	if (!op->osrelease) {
 		fd = open(_PATH_OS_RELEASE, O_RDONLY);
 		if (fd == -1) {
-			log_warn(_("cannot open: %s: %m"), _PATH_OS_RELEASE);
+			log_warn(_("cannot open %s: %m"), _PATH_OS_RELEASE);
 			return NULL;
 		}
 
@@ -2496,10 +2496,10 @@ static void reload_agettys(void)
 	int fd = open(AGETTY_RELOAD_FILENAME, O_CREAT|O_CLOEXEC|O_WRONLY, 0700);
 
 	if (fd < 0)
-		err(EXIT_FAILURE, _("cannot open: %s"), AGETTY_RELOAD_FILENAME);
+		err(EXIT_FAILURE, _("cannot open %s"), AGETTY_RELOAD_FILENAME);
 
 	if (futimens(fd, NULL) < 0 || close(fd) < 0)
-		err(EXIT_FAILURE, _("cannot touch file: %s"),
+		err(EXIT_FAILURE, _("cannot touch file %s"),
 		    AGETTY_RELOAD_FILENAME);
 #else
 	/* very unusual */
-- 
1.7.0.4

