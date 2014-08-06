Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:52251 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751549AbaHFUfM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 16:35:12 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] textual: remove some inconsistent periods from error messages
Date: Wed,  6 Aug 2014 22:35:06 +0200
Message-Id: <1407357306-3207-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While doing so, also improve translatability and some wordings.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.c    |    6 +++---
 include/optutils.h     |    8 ++++----
 login-utils/lslogins.c |    2 +-
 login-utils/sulogin.c  |    4 ++--
 misc-utils/findmnt.c   |    2 +-
 misc-utils/logger.c    |    2 +-
 misc-utils/lsblk.c     |    4 ++--
 sys-utils/fallocate.c  |    2 +-
 sys-utils/fstrim.c     |    2 +-
 term-utils/agetty.c    |    2 +-
 text-utils/hexdump.c   |    2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 8d76d91..0e4e729 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1144,10 +1144,10 @@ partitions_ok(int fd, struct disk_desc *z) {
     /* Have at least 4 partitions been defined? */
     if (partno < 4) {
 	if (!partno)
-	    errx(EXIT_FAILURE, _("no partition table present."));
+	    errx(EXIT_FAILURE, _("no partition table present"));
 	else
-	    errx(EXIT_FAILURE, P_("strange, only %d partition defined.",
-		"strange, only %d partitions defined.", partno), partno);
+	    errx(EXIT_FAILURE, P_("strange, only %d partition defined",
+		"strange, only %d partitions defined", partno), partno);
 	return 0;
     }
 
diff --git a/include/optutils.h b/include/optutils.h
index 9177860..fd5dde3 100644
--- a/include/optutils.h
+++ b/include/optutils.h
@@ -78,7 +78,8 @@ static inline void err_exclusive_options(
 			else if (status[e] != c) {
 				size_t ct = 0;
 
-				fprintf(stderr, _("%s: options "),
+				fprintf(stderr, _("%s: these options are"
+						  "mutually exclusive:"),
 						program_invocation_short_name);
 
 				for (op = excl[e];
@@ -86,11 +87,10 @@ static inline void err_exclusive_options(
 				     op++, ct++) {
 					const char *n = option_to_longopt(*op, opts);
 					if (n)
-						fprintf(stderr, "--%s ", n);
+						fprintf(stderr, " --%s", n);
 					else
-						fprintf(stderr, "-%c ", *op);
+						fprintf(stderr, " -%c", *op);
 				}
-				fprintf(stderr, _("are mutually exclusive."));
 				fputc('\n', stderr);
 				exit(OPTUTILS_EXIT_CODE);
 			}
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index ae1d545..9183183 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -285,7 +285,7 @@ static inline size_t err_columns_index(size_t arysz, size_t idx)
 {
 	if (idx >= arysz)
 		errx(EXIT_FAILURE, _("too many columns specified, "
-				     "the limit is %zu columns."),
+				     "the limit is %zu columns"),
 				arysz - 1);
 	return idx;
 }
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index d14e527..f0e88a4 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -895,7 +895,7 @@ int main(int argc, char **argv)
 	}
 
 	if (geteuid() != 0)
-		errx(EXIT_FAILURE, _("only root can run this program."));
+		errx(EXIT_FAILURE, _("only superuser can run this program"));
 
 	mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
 	mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
@@ -945,7 +945,7 @@ int main(int argc, char **argv)
 	 * Get the root password.
 	 */
 	if ((pwd = getrootpwent(opt_e)) == NULL) {
-		warnx(_("cannot open password database."));
+		warnx(_("cannot open password database"));
 		sleep(2);
 		return EXIT_FAILURE;
 	}
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index f7d9ca8..75099d9 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -156,7 +156,7 @@ static inline size_t err_columns_index(size_t arysz, size_t idx)
 {
 	if (idx >= arysz)
 		errx(EXIT_FAILURE, _("too many columns specified, "
-				     "the limit is %zu columns."),
+				     "the limit is %zu columns"),
 				arysz - 1);
 	return idx;
 }
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 7b10df8..4836b8f 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -438,7 +438,7 @@ static void logger_open(struct logger_ctl *ctl)
 
 	if (ctl->syslogfp == syslog_rfc5424 || ctl->syslogfp == syslog_rfc3164)
 		errx(EXIT_FAILURE, _("--server or --socket are required to "
-				     "log by --rfc5424 or --rfc3164."));
+				     "log by --rfc5424 or --rfc3164"));
 
 	openlog(ctl->tag ? ctl->tag : xgetlogin(), ctl->logflags, 0);
 	ctl->syslogfp = syslog_local;
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 9a41afa..dc1cf69 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -206,7 +206,7 @@ static inline size_t err_columns_index(size_t arysz, size_t idx)
 {
 	if (idx >= arysz)
 		errx(EXIT_FAILURE, _("too many columns specified, "
-				     "the limit is %zu columns."),
+				     "the limit is %zu columns"),
 				arysz - 1);
 	return idx;
 }
@@ -1708,7 +1708,7 @@ int main(int argc, char *argv[])
 		excludes[nexcludes++] = 1;	/* default: ignore RAM disks */
 
 	if (lsblk->sort_id >= 0 && column_id_to_number(lsblk->sort_id) < 0)
-		errx(EXIT_FAILURE, _("the sort column has to be between output columns."));
+		errx(EXIT_FAILURE, _("the sort column has to be among the output columns"));
 
 	mnt_init_debug(0);
 	scols_init_debug(0);
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index c619f64..0e06524 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -340,7 +340,7 @@ int main(int argc, char **argv)
 	}
 
 	if (optind == argc)
-		errx(EXIT_FAILURE, _("no filename specified."));
+		errx(EXIT_FAILURE, _("no filename specified"));
 
 	filename = argv[optind++];
 
diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index 7634a53..481a4cb 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -315,7 +315,7 @@ int main(int argc, char **argv)
 	else {
 		rc = fstrim_filesystem(path, &range, verbose);
 		if (rc == 1) {
-			warnx(_("%s: discard operation not supported."), path);
+			warnx(_("%s: the discard operation is not supported"), path);
 			rc = EXIT_FAILURE;
 		}
 	}
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 5d32cc1..3c30a5f 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -2478,6 +2478,6 @@ static void reload_agettys(void)
 		    AGETTY_RELOAD_FILENAME);
 #else
 	/* very unusual */
-	errx(EXIT_FAILURE, _("--reload unssupported on your system."));
+	errx(EXIT_FAILURE, _("--reload is unsupported on your system"));
 #endif
 }
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index ec9fecb..50b593e 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -194,7 +194,7 @@ int main(int argc, char **argv)
 		argv += parse_args(argc, argv, hex);
 	} else
 		errx(EXIT_FAILURE, _("calling hexdump as od has been deprecated "
-				     "in favour to GNU coreutils od."));
+				     "in favor of GNU coreutils od"));
 
 	/* figure out the data block size */
 	hex->blocksize = 0;
-- 
1.7.0.4

