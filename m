Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:54461 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454Ab2FOIEX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 04:04:23 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id EF465906EB
	for <util-linux@vger.kernel.org>; Fri, 15 Jun 2012 10:04:21 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH] remove obsolete encryption support from losetup
Date: Fri, 15 Jun 2012 10:04:16 +0200
Message-Id: <1339747456-30761-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

kernel cryptoloop is deprecated since ages and support for cryptoloop in
util-linux is incomplete/broken.
- no password hashing
- last 8 bit of key are always set to zero
- no binary keys possible (stops reading key at \n and \0)

In the past some Distros added the above features with patches. So
remove cryptoloop support from util-linux completely to make sure
people won't try using it.

Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 include/loopdev.h              |    3 --
 lib/loopdev.c                  |   56 ----------------------------------------
 libmount/src/context_loopdev.c |   22 +++-------------
 mount/mount.8                  |    9 +-----
 mount/mount.c                  |   26 +++---------------
 sys-utils/losetup.8            |   29 +-------------------
 sys-utils/losetup.c            |   37 ++++++--------------------
 sys-utils/mount.c              |   42 +----------------------------
 8 files changed, 23 insertions(+), 201 deletions(-)

PS: the new pure libmount based mount has no way to complain about specific
options. There's only a generic error message that it can't parse options.

diff --git a/include/loopdev.h b/include/loopdev.h
index 143c0d3..f19298c 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -166,9 +166,6 @@ int loopcxt_set_offset(struct loopdev_cxt *lc, uint64_t offset);
 int loopcxt_set_sizelimit(struct loopdev_cxt *lc, uint64_t sizelimit);
 int loopcxt_set_flags(struct loopdev_cxt *lc, uint32_t flags);
 int loopcxt_set_backing_file(struct loopdev_cxt *lc, const char *filename);
-int loopcxt_set_encryption(struct loopdev_cxt *lc,
-                           const char *encryption,
-                           const char *password);
 
 extern char *loopcxt_get_backing_file(struct loopdev_cxt *lc);
 extern int loopcxt_get_backing_devno(struct loopdev_cxt *lc, dev_t *devno);
diff --git a/lib/loopdev.c b/lib/loopdev.c
index 8e57067..c2682fe 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1045,62 +1045,6 @@ int loopcxt_set_backing_file(struct loopdev_cxt *lc, const char *filename)
 	return 0;
 }
 
-static int digits_only(const char *s)
-{
-	while (*s)
-		if (!isdigit(*s++))
-			return 0;
-	return 1;
-}
-
-/*
- * @lc: context
- * @encryption: encryption name / type (see lopsetup man page)
- * @password
- *
- * Note that the encryption functionality is deprecated an unmaintained. Use
- * cryptsetup (it also supports AES-loops).
- *
- * The setting is removed by loopcxt_set_device() loopcxt_next()!
- *
- * Returns: 0 on success, <0 on error.
- */
-int loopcxt_set_encryption(struct loopdev_cxt *lc,
-			   const char *encryption,
-			   const char *password)
-{
-	if (!lc)
-		return -EINVAL;
-
-	DBG(lc, loopdev_debug("setting encryption '%s'", encryption));
-
-	if (encryption && *encryption) {
-		if (digits_only(encryption)) {
-			lc->info.lo_encrypt_type = atoi(encryption);
-		} else {
-			lc->info.lo_encrypt_type = LO_CRYPT_CRYPTOAPI;
-			snprintf((char *)lc->info.lo_crypt_name, LO_NAME_SIZE,
-				 "%s", encryption);
-		}
-	}
-
-	switch (lc->info.lo_encrypt_type) {
-	case LO_CRYPT_NONE:
-		lc->info.lo_encrypt_key_size = 0;
-		break;
-	default:
-		DBG(lc, loopdev_debug("setting encryption key"));
-		memset(lc->info.lo_encrypt_key, 0, LO_KEY_SIZE);
-		strncpy((char *)lc->info.lo_encrypt_key, password, LO_KEY_SIZE);
-		lc->info.lo_encrypt_key[LO_KEY_SIZE - 1] = '\0';
-		lc->info.lo_encrypt_key_size = LO_KEY_SIZE;
-		break;
-	}
-
-	DBG(lc, loopdev_debug("encryption successfully set"));
-	return 0;
-}
-
 /*
  * @cl: context
  *
diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 290e0d3..919d0e3 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -7,7 +7,6 @@
 
 /*
  * DOCS: - "lo@" prefix for fstype is unsupported
- *	 - encyption= mount option for loop device is unssuported
  */
 
 #include <blkid.h>
@@ -35,8 +34,7 @@ int mnt_context_is_loopdev(struct libmnt_context *cxt)
 
 	if (cxt->user_mountflags & (MNT_MS_LOOP |
 				    MNT_MS_OFFSET |
-				    MNT_MS_SIZELIMIT |
-				    MNT_MS_ENCRYPTION)) {
+				    MNT_MS_SIZELIMIT)) {
 
 		DBG(CXT, mnt_debug_h(cxt, "loopdev specific options detected"));
 		return 1;
@@ -134,7 +132,7 @@ static int is_mounted_same_loopfile(struct libmnt_context *cxt,
 int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 {
 	const char *backing_file, *optstr, *loopdev = NULL;
-	char *val = NULL, *enc = NULL, *pwd = NULL;
+	char *val = NULL;
 	size_t len;
 	struct loopdev_cxt lc;
 	int rc = 0, lo_flags = 0;
@@ -204,13 +202,8 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	 */
 	if (rc == 0 && (cxt->user_mountflags & MNT_MS_ENCRYPTION) &&
 	    mnt_optstr_get_option(optstr, "encryption", &val, &len) == 0) {
-		enc = strndup(val, len);
-		if (val && !enc)
-			rc = -ENOMEM;
-		if (enc && cxt->pwd_get_cb) {
-			DBG(CXT, mnt_debug_h(cxt, "asking for pass"));
-			pwd = cxt->pwd_get_cb(cxt);
-		}
+		DBG(CXT, mnt_debug_h(cxt, "encryption no longer supported"));
+		rc = -MNT_ERR_MOUNTOPT;
 	}
 
 	if (rc == 0 && is_mounted_same_loopfile(cxt,
@@ -249,8 +242,6 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 			rc = loopcxt_set_offset(&lc, offset);
 		if (!rc && sizelimit)
 			rc = loopcxt_set_sizelimit(&lc, sizelimit);
-		if (!rc && enc && pwd)
-			loopcxt_set_encryption(&lc, enc, pwd);
 		if (!rc)
 			loopcxt_set_flags(&lc, lo_flags);
 		if (rc) {
@@ -303,11 +294,6 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 		loopcxt_set_fd(&lc, -1, 0);
 	}
 done:
-	free(enc);
-	if (pwd && cxt->pwd_release_cb) {
-		DBG(CXT, mnt_debug_h(cxt, "release pass"));
-		cxt->pwd_release_cb(cxt, pwd);
-	}
 	loopcxt_deinit(&lc);
 	return rc;
 }
diff --git a/mount/mount.8 b/mount/mount.8
index 0537159..f34c5c2 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -534,11 +534,6 @@ Don't canonicalize paths. The mount command canonicalizes all paths
 file. This option can be used together with the
 .B \-f
 flag for already canonicalized absolut paths.
-.IP "\fB\-p, \-\-pass\-fd \fInum\fP"
-In case of a loop mount with encryption, read the passphrase from
-file descriptor
-.I num
-instead of from the terminal.
 .IP "\fB\-s\fP"
 Tolerate sloppy mount options rather than failing. This will ignore
 mount options not supported by a filesystem type. Not all filesystems
@@ -2707,8 +2702,8 @@ not specified or the filesystem is known for libblkid, for example:
 .B "mount -t ext3 /tmp/disk.img /mnt"
 .sp
 .RE
-This type of mount knows about four options, namely
-.BR loop ", " offset ", " sizelimit " and " encryption ,
+This type of mount knows about three options, namely
+.BR loop ", " offset ", " sizelimit " ,
 that are really options to
 .BR \%losetup (8).
 (These options can be used in addition to those specific
diff --git a/mount/mount.c b/mount/mount.c
index 4ebcc11..0bec577 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -85,9 +85,6 @@ static int mounttype = 0;
 /* True if (ruid != euid) or (0 != ruid), i.e. only "user" mounts permitted.  */
 static int restricted = 1;
 
-/* Contains the fd to read the passphrase from, if any. */
-static int pfd = -1;
-
 #ifdef HAVE_LIBMOUNT_MOUNT
 static struct libmnt_update *mtab_update;
 static char *mtab_opts;
@@ -1266,7 +1263,7 @@ loop_check(const char **spec, const char **type, int *flags,
       *type = opt_vfstype;
   }
 
-  *loop = ((*flags & MS_LOOP) || *loopdev || opt_offset || opt_sizelimit || opt_encryption);
+  *loop = ((*flags & MS_LOOP) || *loopdev || opt_offset || opt_sizelimit);
   *loopfile = *spec;
 
   /* Automatically create a loop device from a regular file if a filesystem
@@ -1322,13 +1319,8 @@ loop_check(const char **spec, const char **type, int *flags,
       }
 
       if (opt_encryption) {
-#ifdef MCL_FUTURE
-        if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
-	  error(_("mount: couldn't lock into memory"));
-          return EX_FAIL;
-	}
-#endif
-	pwd = xgetpass(pfd, _("Password: "));
+        error("mount: %s", _("encryption not supported, use cryptsetup(8) instead"));
+        return EX_FAIL;
       }
 
       loopcxt_init(&lc, 0);
@@ -1357,8 +1349,6 @@ loop_check(const char **spec, const char **type, int *flags,
 	  rc = loopcxt_set_offset(&lc, offset);
 	if (!rc && sizelimit)
 	  rc = loopcxt_set_sizelimit(&lc, sizelimit);
-	if (!rc && opt_encryption && pwd)
-	  loopcxt_set_encryption(&lc, opt_encryption, pwd);
 	if (!rc)
 	  loopcxt_set_flags(&lc, loop_opts);
 
@@ -1546,14 +1536,6 @@ update_mtab_entry(const char *spec, const char *node, const char *type,
 #endif /* !HAVE_LIBMOUNT_MOUNT */
 
 static void
-set_pfd(char *s) {
-	if (!isdigit(*s))
-		die(EX_USAGE,
-		    _("mount: argument to -p or --pass-fd must be a number"));
-	pfd = atoi(optarg);
-}
-
-static void
 cdrom_setspeed(const char *spec) {
 #define CDROM_SELECT_SPEED      0x5322  /* Set the CD-ROM speed */
 	if (opt_speed) {
@@ -2601,7 +2583,7 @@ main(int argc, char *argv[]) {
 			test_opts = append_opt(test_opts, optarg, NULL);
 			break;
 		case 'p':		/* fd on which to read passwd */
-			set_pfd(optarg);
+                        error("mount: %s", _("--pass-fd is no longer supported"));
 			break;
 		case 'r':		/* mount readonly */
 			readonly = 1;
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index 9b5fe61..6a006e1 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -40,8 +40,6 @@ Setup loop device:
 .sp
 .in +5
 .B losetup
-.RB [{ \-e | \-E }
-.IR encryption ]
 .RB [ \-o
 .IR offset ]
 .RB [ \-\-sizelimit
@@ -83,8 +81,6 @@ force loop driver to reread size of the file associated with the specified loop
 detach the file or device associated with the specified loop device(s)
 .IP "\fB\-D, \-\-detach-all\fP"
 detach all associated loop devices
-.IP "\fB\-e, \-E, \-\-encryption \fIencryption_type\fP"
-enable data encryption with specified name or number
 .IP "\fB\-f, \-\-find\fP"
 find the first unused loop device. If a
 .I file
@@ -99,10 +95,6 @@ the data start is moved \fIoffset\fP bytes into the specified file or
 device
 .IP "\fB\-\-sizelimit \fIsize\fP"
 the data end is set to no more than \fIsize\fP bytes after the data start
-.IP "\fB\-p, \-\-pass-fd \fInum\fP"
-read the passphrase from file descriptor with number
-.I num
-instead of from the terminal
 .IP "\fB\-P, \-\-partscan\fP"
 force kernel to scan partition table on newly created loop device
 .IP "\fB\-r, \-\-read-only\fP"
@@ -117,25 +109,8 @@ argument are present.
 verbose mode
 
 .SH ENCRYPTION
-.B Cryptoloop is deprecated in favor of dm-crypt. For more details see
-.B cryptsetup (8). It is possible that all bug reports regarding to -E/-e
-.B options will be ignored.
-
-
-It is possible to specify transfer functions (for encryption/decryption
-or other purposes) using one of the
-.B \-E
-and
-.B \-e
-options.
-There are two mechanisms to specify the desired encryption: by number
-and by name. If an encryption is specified by number then one
-has to make sure that the Linux kernel knows about the encryption with that
-number, probably by patching the kernel. Standard numbers that are
-always present are 0 (no encryption) and 1 (XOR encryption).
-When the cryptoloop module is loaded (or compiled in), it uses number 18.
-This cryptoloop module will take the name of an arbitrary encryption type
-and find the module that knows how to perform that encryption.
+.B Cryptoloop is no longer supported in favor of dm-crypt. For more details see
+.B cryptsetup (8).
 
 .SH RETURN VALUE
 .B losetup
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 3c32299..8468a99 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -18,7 +18,6 @@
 #include "nls.h"
 #include "strutils.h"
 #include "loopdev.h"
-#include "xgetpass.h"
 #include "closestream.h"
 
 enum {
@@ -165,10 +164,8 @@ static void usage(FILE *out)
 		" -j, --associated <file>       list all devices associated with <file>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 
-	fputs(_(" -e, --encryption <type>       enable encryption with specified <name/num>\n"
-		" -o, --offset <num>            start at offset <num> into file\n"
+	fputs(_(" -o, --offset <num>            start at offset <num> into file\n"
 		"     --sizelimit <num>         device limited to <num> bytes of the file\n"
-		" -p, --pass-fd <num>           read passphrase from file descriptor <num>\n"
 		" -P, --partscan                create partitioned loop device\n"
 		" -r, --read-only               setup read-only loop device\n"
 		"     --show                    print device name after setup (with -f)\n"
@@ -206,8 +203,8 @@ static void warn_size(const char *filename, uint64_t size)
 int main(int argc, char **argv)
 {
 	struct loopdev_cxt lc;
-	int act = 0, flags = 0, passfd = -1, c;
-	char *file = NULL, *encryption = NULL;
+	int act = 0, flags = 0, c;
+	char *file = NULL;
 	uint64_t offset = 0, sizelimit = 0;
 	int res = 0, showdev = 0, lo_flags = 0;
 
@@ -271,7 +268,7 @@ int main(int argc, char **argv)
 			break;
 		case 'E':
 		case 'e':
-			encryption = optarg;
+			errx(EXIT_FAILURE, _("encryption not supported, use cryptsetup(8) instead"));
 			break;
 		case 'f':
 			act = A_FIND_FREE;
@@ -288,8 +285,7 @@ int main(int argc, char **argv)
 			flags |= LOOPDEV_FL_OFFSET;
 			break;
 		case 'p':
-			passfd = strtou32_or_err(optarg,
-					_("invalid passphrase file descriptor"));
+                        warn(_("--pass-fd is no longer supported"));
 			break;
 		case 'P':
 			lo_flags |= LO_FLAGS_PARTSCAN;
@@ -345,10 +341,10 @@ int main(int argc, char **argv)
 	}
 
 	if (act != A_CREATE &&
-	    (encryption || sizelimit || passfd != -1 || lo_flags || showdev))
+	    (sizelimit || lo_flags || showdev))
 		errx(EXIT_FAILURE,
 			_("the options %s are allowed to loop device setup only"),
-			"--{encryption,sizelimit,pass-fd,read-only,show}");
+			"--{sizelimit,read-only,show}");
 
 	if ((flags & LOOPDEV_FL_OFFSET) &&
 	    act != A_CREATE && (act != A_SHOW || !file))
@@ -357,16 +353,8 @@ int main(int argc, char **argv)
 	switch (act) {
 	case A_CREATE:
 	{
-		char *pass = NULL;
 		int hasdev = loopcxt_has_device(&lc);
 
-		if (encryption) {
-#ifdef MCL_FUTURE
-			if(mlockall(MCL_CURRENT | MCL_FUTURE))
-				err(EXIT_FAILURE, _("couldn't lock into memory"));
-#endif
-			pass = xgetpass(passfd, _("Password: "));
-		}
 		do {
 			/* Note that loopcxt_{find_unused,set_device}() resets
 			 * loopcxt struct.
@@ -375,8 +363,6 @@ int main(int argc, char **argv)
 				warnx(_("not found unused device"));
 				break;
 			}
-			if (encryption && pass)
-				loopcxt_set_encryption(&lc, encryption, pass);
 			if (flags & LOOPDEV_FL_OFFSET)
 				loopcxt_set_offset(&lc, offset);
 			if (flags & LOOPDEV_FL_SIZELIMIT)
@@ -399,13 +385,8 @@ int main(int argc, char **argv)
 			}
 		} while (hasdev == 0);
 
-		free(pass);
-
-		if (res == 0) {
-			if (showdev)
-				printf("%s\n", loopcxt_get_device(&lc));
-			warn_size(file, sizelimit);
-		}
+		if (showdev && res == 0)
+			printf("%s\n", loopcxt_get_device(&lc));
 		break;
 	}
 	case A_DELETE:
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 9cc2db3..675c24c 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -36,7 +36,6 @@
 #include "env.h"
 #include "optutils.h"
 #include "strutils.h"
-#include "xgetpass.h"
 #include "exitcodes.h"
 #include "xalloc.h"
 #include "closestream.h"
@@ -50,7 +49,6 @@
  *  --options-source-force				MNT_OMODE_FORCE
  */
 
-static int passfd = -1;
 static int readwrite;
 
 static int mk_exit_code(struct libmnt_context *cxt, int rc);
@@ -104,32 +102,6 @@ static int table_parser_errcb(struct libmnt_table *tb __attribute__((__unused__)
 	return 0;
 }
 
-static char *encrypt_pass_get(struct libmnt_context *cxt)
-{
-	if (!cxt)
-		return 0;
-
-#ifdef MCL_FUTURE
-	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
-		warn(_("couldn't lock into memory"));
-		return NULL;
-	}
-#endif
-	return xgetpass(passfd, _("Password: "));
-}
-
-static void encrypt_pass_release(struct libmnt_context *cxt
-			__attribute__((__unused__)), char *pwd)
-{
-	char *p = pwd;
-
-	while (p && *p)
-		*p++ = '\0';
-
-	free(pwd);
-	munlockall();
-}
-
 static void print_all(struct libmnt_context *cxt, char *pattern, int show_label)
 {
 	struct libmnt_table *tb;
@@ -374,13 +346,7 @@ try_readonly:
 				warnx(_("failed to parse mount options"));
 			return MOUNT_EX_USAGE;
 		case -MNT_ERR_LOOPDEV:
-			if (errno == ENOENT
-			    && (uflags & MNT_MS_ENCRYPTION)
-			    && src && stat(src, &st) == 0)
-				warnx(_("%s: failed to setup loop device "
-					"(probably unknown encryption type)"), src);
-			else
-				warn(_("%s: failed to setup loop device"), src);
+			warn(_("%s: failed to setup loop device"), src);
 			return MOUNT_EX_FAIL;
 		default:
 			return handle_generic_errors(rc, _("%s: mount failed"),
@@ -611,7 +577,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out, _(
 	" -o, --options <list>    comma-separated list of mount options\n"
 	" -O, --test-opts <list>  limit the set of filesystems (use with -a)\n"
-	" -p, --pass-fd <num>     read the passphrase from file descriptor\n"
 	" -r, --read-only         mount the filesystem read-only (same as -o ro)\n"
 	" -t, --types <list>      limit the set of filesystem types\n"));
 	fprintf(out, _(
@@ -781,8 +746,7 @@ int main(int argc, char **argv)
 				err(MOUNT_EX_SYSERR, _("failed to set options pattern"));
 			break;
 		case 'p':
-			passfd = strtou32_or_err(optarg,
-					_("invalid passphrase file descriptor"));
+                        warnx(_("--pass-fd is no longer supported"));
 			break;
 		case 'L':
 		case 'U':
@@ -863,8 +827,6 @@ int main(int argc, char **argv)
 	else if (types)
 		mnt_context_set_fstype(cxt, types);
 
-	mnt_context_set_passwd_cb(cxt, encrypt_pass_get, encrypt_pass_release);
-
 	if (all) {
 		/*
 		 * A) Mount all
-- 
1.7.7

