Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:63862 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752000AbaGVU4j (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Jul 2014 16:56:39 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] textual: fix some typos and inconsistencies in various messages
Date: Tue, 22 Jul 2014 22:56:27 +0200
Message-Id: <1406062587-2183-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fixing plain typos, miswordings, inconsistent periods, some missing
angular brackets, and a proper pluralization (even when it involves
a constant, because for some languages the precise value matters).

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c      |    6 +++---
 disk-utils/fdisk.c       |    2 +-
 disk-utils/fsck.cramfs.c |    2 +-
 libfdisk/src/bsd.c       |    2 +-
 libfdisk/src/gpt.c       |    6 +++---
 libfdisk/src/sgi.c       |    2 +-
 login-utils/chfn.c       |    2 +-
 login-utils/chsh.c       |    4 ++--
 login-utils/last.c       |    6 +++---
 login-utils/lslogins.c   |    2 +-
 login-utils/su-common.c  |    6 +++---
 misc-utils/kill.c        |    2 +-
 misc-utils/logger.c      |    4 ++--
 misc-utils/mcookie.c     |    7 ++++---
 misc-utils/namei.c       |    2 +-
 misc-utils/rename.c      |    4 ++--
 misc-utils/whereis.c     |    2 +-
 misc-utils/wipefs.c      |    4 ++--
 18 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 109489a..5a42ab1 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1806,9 +1806,9 @@ static int main_menu_action(struct cfdisk *cf, int key)
 		ref = 1;
 
 		if (t && fdisk_set_partition_type(cf->cxt, n, t) == 0)
-			info = _("Changed type of the partition %zu.");
+			info = _("Changed type of partition %zu.");
 		else
-			info = _("Type of the partition %zu is unchanged.");
+			info = _("The type of partition %zu is unchanged.");
 		break;
 	}
 	case 's': /* fix order */
@@ -1830,7 +1830,7 @@ static int main_menu_action(struct cfdisk *cf, int key)
 		rc = ui_get_string(cf,
 			  _("Are you sure you want to write the partition "
 			    "table to disk? "),
-			  _("Type \"yes\" or \"no\" or press ESC to left dialog."),
+			  _("Type \"yes\" or \"no\", or press ESC to leave this dialog."),
 			  buf, sizeof(buf));
 
 		ref = 1;
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index d6bb737..8d57dbb 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -958,7 +958,7 @@ int main(int argc, char **argv)
 
 		} else if (fdisk_is_disklabel(cxt, GPT) && fdisk_gpt_is_hybrid(cxt))
 			fdisk_warnx(cxt, _(
-				  "The hybrid GPT detected. You have to sync "
+				  "A hybrid GPT was detected. You have to sync "
 				  "the hybrid MBR manually (expert command 'M')."));
 
 		while (1)
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 6adfa33..0a1c6f2 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -105,7 +105,7 @@ static void __attribute__((__noreturn__)) usage(int status)
 
 	fputs(USAGE_HEADER, stream);
 	fprintf(stream,
-		_(" %s [options] file\n"), program_invocation_short_name);
+		_(" %s [options] <file>\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, stream);
 	fputs(_(" -a                       for compatibility only, ignored\n"), stream);
 	fputs(_(" -v, --verbose            be more verbose\n"), stream);
diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
index df0fc13..0a03338 100644
--- a/libfdisk/src/bsd.c
+++ b/libfdisk/src/bsd.c
@@ -797,7 +797,7 @@ int fdisk_bsd_link_partition(struct fdisk_context *cxt)
 	struct bsd_disklabel *d = self_disklabel(cxt);
 
 	if (!cxt->parent || !fdisk_is_disklabel(cxt->parent, DOS)) {
-		fdisk_warnx(cxt, _("BSD label is not nested within a DOS partition"));
+		fdisk_warnx(cxt, _("BSD label is not nested within a DOS partition."));
 		return -EINVAL;
 	}
 
diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index db8651f..1b5ffb4 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -514,7 +514,7 @@ static int gpt_mknew_header(struct fdisk_context *cxt,
 	header->size      = cpu_to_le32(sizeof(struct gpt_header));
 
 	/*
-	 * 128 partitions is the default. It can go behond this, however,
+	 * 128 partitions are the default. It can go beyond that, but
 	 * we're creating a de facto header here, so no funny business.
 	 */
 	header->npartition_entries     = cpu_to_le32(GPT_NPARTITIONS);
@@ -958,7 +958,7 @@ static uint32_t partition_start_after_end(struct gpt_header *header, struct gpt_
 }
 
 /*
- * Check if partition e1 overlaps with partition e2
+ * Check if partition e1 overlaps with partition e2.
  */
 static inline int partition_overlap(struct gpt_entry *e1, struct gpt_entry *e2)
 {
@@ -971,7 +971,7 @@ static inline int partition_overlap(struct gpt_entry *e1, struct gpt_entry *e2)
 }
 
 /*
- * Find any paritions that overlap.
+ * Find any partitions that overlap.
  */
 static uint32_t partition_check_overlaps(struct gpt_header *header, struct gpt_entry *e)
 {
diff --git a/libfdisk/src/sgi.c b/libfdisk/src/sgi.c
index cf13541..b191176 100644
--- a/libfdisk/src/sgi.c
+++ b/libfdisk/src/sgi.c
@@ -140,7 +140,7 @@ int fdisk_sgi_create_info(struct fdisk_context *cxt)
 	sgilabel->volume[0].num_bytes = cpu_to_be32(sizeof(struct sgi_info));
 	strncpy((char *) sgilabel->volume[0].name, "sgilabel", 8);
 
-	fdisk_info(cxt, _("SGI info created on second sector"));
+	fdisk_info(cxt, _("SGI info created on second sector."));
 	return 0;
 }
 
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 5aa491d..ca10fbf 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -80,7 +80,7 @@ static int save_new_data(struct finfo *pinfo);
 static void __attribute__((__noreturn__)) usage(FILE *fp)
 {
 	fputs(USAGE_HEADER, fp);
-	fprintf(fp, _(" %s [options] [username]\n"), program_invocation_short_name);
+	fprintf(fp, _(" %s [options] [<username>]\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, fp);
 	fputs(_(" -f, --full-name <full-name>  real name\n"), fp);
 	fputs(_(" -o, --office <office>        office number\n"), fp);
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index e14efe0..76c3d21 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -69,7 +69,7 @@ static int get_shell_list(char *shell);
 static void __attribute__((__noreturn__)) usage (FILE *fp)
 {
 	fputs(USAGE_HEADER, fp);
-	fprintf(fp, _(" %s [options] [username]\n"), program_invocation_short_name);
+	fprintf(fp, _(" %s [options] [<username>]\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, fp);
 	fputs(_(" -s, --shell <shell>  specify login shell\n"), fp);
 	fputs(_(" -l, --list-shells    print list of shells and exit\n"), fp);
@@ -112,7 +112,7 @@ int main(int argc, char **argv)
 
 #ifndef HAVE_LIBUSER
 	if (!(is_local(pw->pw_name)))
-		errx(EXIT_FAILURE, _("can only change local entries."));
+		errx(EXIT_FAILURE, _("can only change local entries"));
 #endif
 
 #ifdef HAVE_LIBSELINUX
diff --git a/login-utils/last.c b/login-utils/last.c
index f0c2b8c..f7a2576 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -564,11 +564,11 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -R, --nohostname     don't display the hostname field\n"), out);
 	fputs(_(" -s, --since <time>   display the lines since the specified time\n"), out);
 	fputs(_(" -t, --until <time>   display the lines until the specified time\n"), out);
-	fputs(_(" -p, --present <time> display who where present at the specified time\n"), out);
+	fputs(_(" -p, --present <time> display who were present at the specified time\n"), out);
 	fputs(_(" -w, --fullnames      display full user and domain names\n"), out);
 	fputs(_(" -x, --system         display system shutdown entries and run level changes\n"), out);
-	fputs(_("     --time-format <format>  show time stamp using format:\n"), out);
-	fputs(_("                               [notime|short|full|iso]\n"), out);
+	fputs(_("     --time-format <format>  show timestamps in the specified <format>:\n"
+		"                               notime|short|full|iso\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index ece582b..ae1d545 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1187,7 +1187,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -a, --acc-expiration     display info about passwords expiration\n"), out);
 	fputs(_(" -c, --colon-separate     display data in a format similar to /etc/passwd\n"), out);
 	fputs(_(" -e, --export             display in an export-able output format\n"), out);
-	fputs(_(" -f, --failed             display data about the last users' failed logins\n"), out);
+	fputs(_(" -f, --failed             display data about the users' last failed logins\n"), out);
 	fputs(_(" -G, --groups-info        display information about groups\n"), out);
 	fputs(_(" -g, --groups=<groups>    display users belonging to a group in <groups>\n"), out);
 	fputs(_(" -L, --last               show info about the users' last login sessions\n"), out);
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 2766a60..db72826 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -857,7 +857,7 @@ su_main (int argc, char **argv, int mode)
     }
 
   if (simulate_login && !change_environment) {
-    warnx(_("ignore --preserve-environment, it's mutually exclusive to --login."));
+    warnx(_("ignoring --preserve-environment, it's mutually exclusive with --login"));
     change_environment = true;
   }
 
@@ -869,10 +869,10 @@ su_main (int argc, char **argv, int mode)
       if (shell || fast_startup || command || simulate_login) {
         errx(EXIT_FAILURE,
 	   _("options --{shell,fast,command,session-command,login} and "
-	     "--user are mutually exclusive."));
+	     "--user are mutually exclusive"));
       }
       if (optind == argc)
-        errx(EXIT_FAILURE, _("COMMAND not specified."));
+        errx(EXIT_FAILURE, _("no command was specified"));
 
       break;
     }
diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 2f89427..f8cb7dd 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -509,7 +509,7 @@ int main(int argc, char **argv)
 
 			if (!found) {
 				nerrs++, ct++;
-				warnx(_("cannot find process \"%s\"."), ctl.arg);
+				warnx(_("cannot find process \"%s\""), ctl.arg);
 			}
 		}
 	}
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index a862e55..0bf5e53 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -130,7 +130,7 @@ static int pencode(char *s)
 		*s = '\0';
 		fac = decode(save, facilitynames);
 		if (fac < 0)
-			errx(EXIT_FAILURE, _("unknown facility name: %s."), save);
+			errx(EXIT_FAILURE, _("unknown facility name: %s"), save);
 		*s++ = '.';
 	}
 	else {
@@ -139,7 +139,7 @@ static int pencode(char *s)
 	}
 	lev = decode(s, prioritynames);
 	if (lev < 0)
-		errx(EXIT_FAILURE, _("unknown priority name: %s."), save);
+		errx(EXIT_FAILURE, _("unknown priority name: %s"), save);
 	return ((lev & LOG_PRIMASK) | (fac & LOG_FACMASK));
 }
 
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index 7b60dd8..a46ea0c 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -174,7 +174,7 @@ int main(int argc, char **argv)
 	}
 
 	if (ctl.maxsz && ctl.nfiles == 0)
-		warnx(_("--max-size ignored when used without --file."));
+		warnx(_("--max-size ignored when used without --file"));
 
 	randomness_from_files(&ctl);
 	free(ctl.files);
@@ -182,8 +182,9 @@ int main(int argc, char **argv)
 	random_get_bytes(&buf, RAND_BYTES);
 	MD5Update(&ctl.ctx, buf, RAND_BYTES);
 	if (ctl.verbose)
-		fprintf(stderr, _("Got %d bytes from %s\n"), RAND_BYTES,
-				random_tell_source());
+		fprintf(stderr, P_("Got %zu byte from %s\n",
+				   "Got %zu bytes from %s\n", RAND_BYTES),
+				RAND_BYTES, random_tell_source());
 
 	MD5Final(digest, &ctl.ctx);
 	for (i = 0; i < MD5LENGTH; i++)
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index 1152ea7..cac0e6c 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -426,7 +426,7 @@ static void usage(int rc)
 
 	fputs(_("\nUsage:\n"), out);
 	fprintf(out,
-	      _(" %s [options] pathname [pathname ...]\n"), p);
+	      _(" %s [options] <pathname>...\n"), p);
 
 	fputs(_("\nOptions:\n"), out);
 	fputs(_(" -h, --help          displays this help text\n"
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 9064bc3..1bb23cd 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -114,11 +114,11 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-	      _(" %s [options] expression replacement file...\n"),
+	      _(" %s [options] <expression> <replacement> <file>...\n"),
 		program_invocation_short_name);
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -v, --verbose    explain what is being done\n"), out);
-	fputs(_(" -s, --symlink    act on symlink target\n"), out);
+	fputs(_(" -s, --symlink    act on the target of symlinks\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 6273032..a422c47 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -165,7 +165,7 @@ static const char *srcdirs[] = {
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] file\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] <file>\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -b         search only for binaries\n"), out);
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index ad7caa5..58a643e 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -408,8 +408,8 @@ do_wipe(struct wipe_desc *wp, const char *devname, int flags)
 		if (!(flags & WP_FL_FORCE)
 		    && wp->is_parttable
 		    && !blkid_probe_is_wholedisk(pr)) {
-			warnx(_("%s: ignore nested \"%s\" partition "
-				"table on non-whole disk device."), devname, wp->type);
+			warnx(_("%s: ignoring nested \"%s\" partition table "
+				"on non-whole disk device"), devname, wp->type);
 			need_force = 1;
 			continue;
 		}
-- 
1.7.0.4

