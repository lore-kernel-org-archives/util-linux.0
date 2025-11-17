Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3A27FD6D
	for <util-linux@vger.kernel.org>; Mon, 17 Nov 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373047; cv=none; b=gUvNRAmApycLANzYNGBCIZjYH+dEfX4d5AXVXwqZ82YBs7c9CpTKBfGSob2YxP6tFrOzb4FN55dOicZTr4r9JSMoalgJqpTgh52bxvm2LdcDy9EliOg6v7v0IyV+GjN8JJf02zlWr3DMsmTVTgG1uIIEhn/vnhXpt9zUx/b3dyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373047; c=relaxed/simple;
	bh=rhb5oiCMnGWz8mxEAt6RKlJYtv+dRWxHlg1F8vQJLEo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fhAdhbYhVSMcoUmzBu/Ba6Ch2jryuT39lm+XqQxdlKlQQGWGEGsErTYQ7Sqy45G9KJWrUWvK3US+t7iaUn/rAfXqwjhgRZvxyE/fLmqL7HxaSRm1NigSHh6Xri9vAbVPmA2XXgBYbX7Zob52GtSJOmc0bwrrZZ2X3Rgrx/urMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ZQWJqhhy; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ZQWJqhhy"
X-KPN-MessageId: 29358c37-c39b-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 29358c37-c39b-11f0-bd6b-005056aba152;
	Mon, 17 Nov 2025 10:52:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=zAN+XaTMdb/M1BnwzAN0wVGwAx9F1IBF0yKMv8kxxU0=;
	b=ZQWJqhhy7i0qIXhV+7cw2KFWOSApDLdA+lbMWWguDksy9wnMgiD/hjgu3vxKGc2ZGjOyZoCae3PBU
	 2hB1dm8ys0499gzx8wF+x3x3esyrLlCgMs/eEhDsZsG+6sS3ymaw0M5RdeRKNo/QqXOasvV+wkjU29
	 NDekI0VXPrnY5pMQ=
X-KPN-MID: 33|6eMMxEn0jXV1FIXdIAme9TOvmD0x2OPyWBIyaagn0iPkzPObcG0zXcS6QklxfDZ
 9iEnL6RIxtwCIbWz9uL0ZHdKA3+0rYZDsy6XJiEaQ0qc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Jym2KRPg8cQOeaL5ZoY6DZXixXBOdT3KGOKvdlSYjN5jbIX7xz2LwiT6ihfsMWA
 J6h2xfXcp1GiYOzE6TLmd4w==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id db5d1afc-c39a-11f0-bda2-005056ab1411;
	Mon, 17 Nov 2025 10:50:32 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] treewide: consistently use tabs for indentation where it is the rule
Date: Mon, 17 Nov 2025 10:50:22 +0100
Message-ID: <20251117095022.6155-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also unwrap a line, delete two blank lines, and improve three comments.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/blockdev.c          |  20 ++--
 disk-utils/cfdisk.c            |   8 +-
 disk-utils/fdformat.c          |   2 +-
 disk-utils/fdisk-menu.c        |  10 +-
 disk-utils/fdisk.c             |   6 +-
 disk-utils/mkfs.bfs.c          |   2 +-
 disk-utils/mkfs.cramfs.c       |   6 +-
 disk-utils/mkswap.c            |   3 +-
 disk-utils/sfdisk.c            |   4 +-
 lib/buffer.c                   |   2 +-
 lib/env.c                      |  86 ++++++++---------
 lib/fileeq.c                   |   2 +-
 lib/ismounted.c                |  32 +++---
 lib/logindefs.c                |  46 ++++-----
 lib/loopdev.c                  |  38 ++++----
 lib/procfs.c                   |   4 +-
 lib/pty-session.c              |   6 +-
 lib/shells.c                   |  54 +++++------
 lib/strutils.c                 | 148 ++++++++++++++--------------
 lib/sysfs.c                    | 171 ++++++++++++++++-----------------
 lib/timer.c                    |   2 +-
 login-utils/login.c            |   4 +-
 login-utils/sulogin-consoles.c |  10 +-
 misc-utils/findmnt.c           |  16 +--
 misc-utils/lastlog2.c          |   7 +-
 misc-utils/lsblk-devtree.c     |  16 +--
 misc-utils/rename.c            |   4 +-
 sys-utils/ipcrm.c              |   2 +-
 sys-utils/ldattach.c           |   6 +-
 sys-utils/losetup.c            |   2 +-
 sys-utils/lscpu-topology.c     |   2 +-
 sys-utils/lsns.c               |  16 +--
 sys-utils/swapoff.c            |   2 +-
 sys-utils/tunelp.c             |   4 +-
 sys-utils/unshare.c            |  16 +--
 sys-utils/zramctl.c            |   6 +-
 term-utils/agetty.c            |  14 +--
 term-utils/mesg.c              |   4 +-
 term-utils/script.c            |   2 +-
 term-utils/scriptreplay.c      |   4 +-
 text-utils/col.c               |  65 ++++++-------
 text-utils/hexdump-display.c   |   4 +-
 text-utils/hexdump-parse.c     |  10 +-
 text-utils/hexdump.c           |   2 +-
 44 files changed, 433 insertions(+), 437 deletions(-)

diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index 55b47acf6..3ef74aa22 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -140,7 +140,7 @@ static const struct bdc bdcms[] =
 		.argname = "<bytes>",
 		.argtype = ARG_INT,
 		.flags = FL_NORESULT,
-	        .help = N_("set blocksize on file descriptor opening the block device")
+		.help = N_("set blocksize on file descriptor opening the block device")
 	},{
 		IOCTL_ENTRY(BLKGETSIZE),
 		.name = "--getsize",
@@ -210,23 +210,23 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_HEADER, stdout);
 	fprintf(stdout, _(
-	         " %1$s [-v|-q] commands devices\n"
-	         " %1$s --report [devices]\n"
-	         " %1$s -h|-V\n"
-		), program_invocation_short_name);
+	          " %1$s [-v|-q] commands devices\n"
+	          " %1$s --report [devices]\n"
+	          " %1$s -h|-V\n"
+	       ), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, stdout);
-	fputsln(  _("Call block device ioctls from the command line."), stdout);
+	fputsln(_("Call block device ioctls from the command line."), stdout);
 
 	fputs(USAGE_OPTIONS, stdout);
-	fputsln(  _(" -q             quiet mode"), stdout);
-	fputsln(  _(" -v             verbose mode"), stdout);
-	fputsln(  _("     --report   print report for specified (or all) devices"), stdout);
+	fputsln(_(" -q             quiet mode"), stdout);
+	fputsln(_(" -v             verbose mode"), stdout);
+	fputsln(_("     --report   print report for specified (or all) devices"), stdout);
 	fputs(USAGE_SEPARATOR, stdout);
 	fprintf(stdout, USAGE_HELP_OPTIONS(16));
 
 	fputs(USAGE_SEPARATOR, stdout);
-	fputsln(  _("Available commands:"), stdout);
+	fputsln(_("Available commands:"), stdout);
 	fprintf(stdout, _(" %-25s get size in 512-byte sectors\n"), "--getsz");
 	for (i = 0; i < ARRAY_SIZE(bdcms); i++) {
 		if (bdcms[i].argname)
diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index e4e16001e..e2f1cd74d 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1760,7 +1760,7 @@ static int ui_refresh(struct cfdisk *cf)
 {
 	struct fdisk_label *lb;
 	char *id = NULL;
-        uint64_t bytes = fdisk_get_nsectors(cf->cxt) * fdisk_get_sector_size(cf->cxt);
+	uint64_t bytes = fdisk_get_nsectors(cf->cxt) * fdisk_get_sector_size(cf->cxt);
 	char *strsz;
 
 	if (!ui_enabled)
@@ -2783,9 +2783,9 @@ int main(int argc, char *argv[])
 			if (optarg)
 				colormode = colormode_or_err(optarg);
 			break;
-                case 'r':
-                        read_only = 1;
-                        break;
+		case 'r':
+			read_only = 1;
+			break;
 		case 'V':
 			print_version(EXIT_SUCCESS);
 		case 'z':
diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index 49cb51d8a..04e414a53 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -164,7 +164,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -f, --from <N>    start at the track N (default 0)\n"), out);
 	fputs(_(" -t, --to <N>      stop at the track N\n"), out);
 	fputs(_(" -r, --repair <N>  try to repair tracks failed during\n"
-                "                     the verification (max N retries)\n"), out);
+		"                     the verification (max N retries)\n"), out);
 	fputs(_(" -n, --no-verify   disable the verification after the format\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index 707394d4e..f3c9f154e 100644
--- a/disk-utils/fdisk-menu.c
+++ b/disk-utils/fdisk-menu.c
@@ -499,9 +499,9 @@ static int script_read(struct fdisk_context *cxt)
 		fdisk_warnx(cxt, _("Failed to apply script %s"), filename);
 		fdisk_warnx(cxt, _("Resetting fdisk!"));
 		rc = fdisk_reassign_device(cxt);
-                if (rc == 0 && !fdisk_has_label(cxt)) {
-                        fdisk_info(cxt, _("Device does not contain a recognized partition table."));
-                        rc = fdisk_create_disklabel(cxt, NULL);
+		if (rc == 0 && !fdisk_has_label(cxt)) {
+			fdisk_info(cxt, _("Device does not contain a recognized partition table."));
+			rc = fdisk_create_disklabel(cxt, NULL);
 		}
 	} else
 		fdisk_info(cxt, _("Script successfully applied."));
@@ -751,8 +751,8 @@ static int gpt_menu_cb(struct fdisk_context **cxt0,
 		case 'i':
 			return fdisk_set_disklabel_id(cxt);
 		case 'l':
-	                rc =  fdisk_ask_number(cxt, 1, fdisk_get_npartitions(cxt),
-	                                ~(uint32_t)0, _("New maximum entries"), &length);
+			rc =  fdisk_ask_number(cxt, 1, fdisk_get_npartitions(cxt),
+			                       ~(uint32_t)0, _("New maximum entries"), &length);
 			if (rc)
 				return rc;
 			return fdisk_gpt_set_npartitions(cxt, (uint32_t) length);
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 72feed587..f44a4899e 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -494,11 +494,11 @@ static struct fdisk_parttype *ask_partition_type(struct fdisk_context *cxt, int
 	*canceled = 0;
 
 	if (fdisk_label_has_parttypes_shortcuts(lb))
-		 q = fdisk_label_has_code_parttypes(lb) ?
+		q = fdisk_label_has_code_parttypes(lb) ?
 			_("Hex code or alias (type L to list all): ") :
 			_("Partition type or alias (type L to list all): ");
 	else
-	        q = fdisk_label_has_code_parttypes(lb) ?
+		q = fdisk_label_has_code_parttypes(lb) ?
 			_("Hex code (type L to list all codes): ") :
 			_("Partition type (type L to list all types): ");
 	do {
@@ -523,7 +523,7 @@ static struct fdisk_parttype *ask_partition_type(struct fdisk_context *cxt, int
 				fdisk_info(cxt, _("Failed to parse '%s' partition type."), buf);
 			return t;
 		}
-        } while (1);
+	} while (1);
 
 	return NULL;
 }
diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index 30c28d9e7..838fb59b4 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -184,7 +184,7 @@ int main(int argc, char **argv)
 			/* when called via mkfs we may get options c,l,v */
 			break;
 
-                case OPT_LOCK:
+		case OPT_LOCK:
 			lockmode = "1";
 			if (optarg) {
 				if (*optarg == '=')
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index a91016d26..0b1695e77 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -764,9 +764,9 @@ int main(int argc, char **argv)
 			fslen_ub += (image_length + 3); /* 3 is for padding */
 			break;
 		case 'l':
-                        lockmode = "1";
+			lockmode = "1";
 			if (optarg) {
-                                if (*optarg == '=')
+				if (*optarg == '=')
 					optarg++;
 				lockmode = optarg;
 			}
@@ -810,7 +810,7 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		err(MKFS_EX_USAGE, _("cannot open %s"), outfile);
 
-        if (blkdev_lock(fd, outfile, lockmode) != 0)
+	if (blkdev_lock(fd, outfile, lockmode) != 0)
 		exit(MKFS_EX_ERROR);
 
 	root_entry = xcalloc(1, sizeof(struct entry));
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 3cb7a043b..17ec1603f 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -800,8 +800,7 @@ int main(int argc, char **argv)
 	deinit_signature_page(&ctl);
 
 #ifdef HAVE_LIBSELINUX
-	if ((ctl.file || S_ISREG(ctl.devstat.st_mode)) &&
-            is_selinux_enabled() > 0) {
+	if ((ctl.file || S_ISREG(ctl.devstat.st_mode)) && is_selinux_enabled() > 0) {
 		const char *context_string;
 		char *oldcontext;
 		context_t newcontext;
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index b691cb084..aeab826c2 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -478,7 +478,7 @@ static int move_partition_data(struct sfdisk *sf, size_t partno, struct fdisk_pa
 			fdisk_info(sf->cxt, _(" typescript file: %s"), typescript);
 		printf(_("  start sector: (from/to) %ju / %ju\n"), (uintmax_t) from, (uintmax_t) to);
 		printf(_("  sectors: %ju\n"), (uintmax_t) nsectors);
-	        printf(_("  step size: %zu bytes\n"), step_bytes);
+		printf(_("  step size: %zu bytes\n"), step_bytes);
 		putchar('\n');
 		fflush(stdout);
 
@@ -602,7 +602,7 @@ static int move_partition_data(struct sfdisk *sf, size_t partno, struct fdisk_pa
 					i + 1, nsectors,
 					100.0 / ((double) nsectors/(i+1)));
 			fflush(stdout);
-                        fputc('\r', stdout);
+			fputc('\r', stdout);
 
 		}
 next:
diff --git a/lib/buffer.c b/lib/buffer.c
index bdc4744bc..76aefe950 100644
--- a/lib/buffer.c
+++ b/lib/buffer.c
@@ -303,6 +303,6 @@ int main(void)
 
 	ul_buffer_free_data(&buf);
 
-        return EXIT_SUCCESS;
+	return EXIT_SUCCESS;
 }
 #endif /* TEST_PROGRAM_BUFFER */
diff --git a/lib/env.c b/lib/env.c
index 039fad0dc..e5e66337f 100644
--- a/lib/env.c
+++ b/lib/env.c
@@ -27,28 +27,28 @@ extern char **environ;
 #endif
 
 static char * const forbid[] = {
-        "BASH_ENV=",    /* GNU creeping featurism strikes again... */
-        "ENV=",
-        "HOME=",
-        "IFS=",
-        "KRB_CONF=",
-        "LD_",          /* anything with the LD_ prefix */
-        "LIBPATH=",
-        "MAIL=",
-        "NLSPATH=",
-        "PATH=",
-        "SHELL=",
-        "SHLIB_PATH=",
-        (char *) 0
+	"BASH_ENV=",    /* GNU creeping featurism strikes again... */
+	"ENV=",
+	"HOME=",
+	"IFS=",
+	"KRB_CONF=",
+	"LD_",	  /* anything with the LD_ prefix */
+	"LIBPATH=",
+	"MAIL=",
+	"NLSPATH=",
+	"PATH=",
+	"SHELL=",
+	"SHLIB_PATH=",
+	(char *) 0
 };
 
 /* these are allowed, but with no slashes inside
    (to work around security problems in GNU gettext) */
 static char * const noslash[] = {
-        "LANG=",
-        "LANGUAGE=",
-        "LC_",          /* anything with the LC_ prefix */
-        (char *) 0
+	"LANG=",
+	"LANGUAGE=",
+	"LC_",	  /* anything with the LC_ prefix */
+	(char *) 0
 };
 
 
@@ -218,39 +218,39 @@ void env_list_free(struct ul_env_list *ls)
  */
 void __sanitize_env(struct ul_env_list **org)
 {
-        char **envp = environ;
-        char * const *bad;
-        char **cur;
-        int last = 0;
+	char **envp = environ;
+	char * const *bad;
+	char **cur;
+	int last = 0;
 
-        for (cur = envp; *cur; cur++)
-                last++;
+	for (cur = envp; *cur; cur++)
+		last++;
 
-        for (cur = envp; *cur; cur++) {
-                for (bad = forbid; *bad; bad++) {
-                        if (strncmp(*cur, *bad, strlen(*bad)) == 0) {
+	for (cur = envp; *cur; cur++) {
+		for (bad = forbid; *bad; bad++) {
+			if (strncmp(*cur, *bad, strlen(*bad)) == 0) {
 				if (org)
 					*org = env_list_add_from_string(*org, *cur);
-                                last = ul_remove_entry(envp, cur - envp, last);
-                                cur--;
-                                break;
-                        }
-                }
-        }
+				last = ul_remove_entry(envp, cur - envp, last);
+				cur--;
+				break;
+			}
+		}
+	}
 
-        for (cur = envp; *cur; cur++) {
-                for (bad = noslash; *bad; bad++) {
-                        if (strncmp(*cur, *bad, strlen(*bad)) != 0)
-                                continue;
-                        if (!strchr(*cur, '/'))
-                                continue;  /* OK */
+	for (cur = envp; *cur; cur++) {
+		for (bad = noslash; *bad; bad++) {
+			if (strncmp(*cur, *bad, strlen(*bad)) != 0)
+				continue;
+			if (!strchr(*cur, '/'))
+				continue;  /* OK */
 			if (org)
 				*org = env_list_add_from_string(*org, *cur);
-                        last = ul_remove_entry(envp, cur - envp, last);
-                        cur--;
-                        break;
-                }
-        }
+			last = ul_remove_entry(envp, cur - envp, last);
+			cur--;
+			break;
+		}
+	}
 }
 
 void sanitize_env(void)
diff --git a/lib/fileeq.c b/lib/fileeq.c
index ffd208962..762619563 100644
--- a/lib/fileeq.c
+++ b/lib/fileeq.c
@@ -335,7 +335,7 @@ static int get_fd(struct ul_fileeq *eq, struct ul_fileeq_data *data, off_t *off)
 			return data->fd;
 
 #if defined(POSIX_FADV_SEQUENTIAL) && defined(HAVE_POSIX_FADVISE)
-	        ignore_result( posix_fadvise(data->fd, o, 0, POSIX_FADV_SEQUENTIAL) );
+		ignore_result( posix_fadvise(data->fd, o, 0, POSIX_FADV_SEQUENTIAL) );
 #endif
 		if (o) {
 			DBG(DATA, ul_debugobj(data, "lseek off=%ju", (uintmax_t) o));
diff --git a/lib/ismounted.c b/lib/ismounted.c
index ae5327c90..28ddc0d58 100644
--- a/lib/ismounted.c
+++ b/lib/ismounted.c
@@ -216,31 +216,31 @@ static int check_getmntinfo(const char *file, int *mount_flags,
 				  char *mtpt, int mtlen)
 {
 	struct statfs *mp;
-        int    len, n;
-        const  char   *s1;
+	int    len, n;
+	const  char   *s1;
 	char	*s2;
 
-        n = getmntinfo(&mp, MNT_NOWAIT);
-        if (n == 0)
+	n = getmntinfo(&mp, MNT_NOWAIT);
+	if (n == 0)
 		return errno;
 
-        len = sizeof(_PATH_DEV) - 1;
-        s1 = file;
-        if (strncmp(_PATH_DEV, s1, len) == 0)
-                s1 += len;
+	len = sizeof(_PATH_DEV) - 1;
+	s1 = file;
+	if (strncmp(_PATH_DEV, s1, len) == 0)
+		s1 += len;
 
 	*mount_flags = 0;
-        while (--n >= 0) {
-                s2 = mp->f_mntfromname;
-                if (strncmp(_PATH_DEV, s2, len) == 0) {
-                        s2 += len - 1;
-                        *s2 = 'r';
-                }
-                if (strcmp(s1, s2) == 0 || strcmp(s1, &s2[1]) == 0) {
+	while (--n >= 0) {
+		s2 = mp->f_mntfromname;
+		if (strncmp(_PATH_DEV, s2, len) == 0) {
+			s2 += len - 1;
+			*s2 = 'r';
+		}
+		if (strcmp(s1, s2) == 0 || strcmp(s1, &s2[1]) == 0) {
 			*mount_flags = MF_MOUNTED;
 			break;
 		}
-                ++mp;
+		++mp;
 	}
 	if (mtpt && n >= 0)
 		xstrncpy(mtpt, mp->f_mntonname, mtlen);
diff --git a/lib/logindefs.c b/lib/logindefs.c
index 079f2dabf..3da5911d1 100644
--- a/lib/logindefs.c
+++ b/lib/logindefs.c
@@ -253,7 +253,7 @@ static void load_defaults(void)
 	econf_err error;
 
 	if (file != NULL)
-	        free_getlogindefs_data();
+		free_getlogindefs_data();
 
 #ifdef HAVE_ECONF_READCONFIG
 	error = econf_readConfig(&file, NULL,
@@ -282,10 +282,10 @@ void logindefs_load_file(const char *filename)
 	xasprintf(&path, _PATH_VENDORDIR"/%s", filename);
 
 	if (!econf_readFile(&file_l, path, "= \t", "#")) {
-	        if (file == NULL)
-		        file = file_l;
-	        else if (!econf_mergeFiles(&file_m, file, file_l)) {
-		        econf_free(file);
+		if (file == NULL)
+			file = file_l;
+		else if (!econf_mergeFiles(&file_m, file, file_l)) {
+			econf_free(file);
 			file = file_m;
 			econf_free(file_l);
 		}
@@ -296,10 +296,10 @@ void logindefs_load_file(const char *filename)
 	xasprintf(&path, "/etc/%s", filename);
 
 	if (!econf_readFile(&file_l, path, "= \t", "#")) {
-	        if (file == NULL)
-		        file = file_l;
-	        else if (!econf_mergeFiles(&file_m, file, file_l)) {
-	                econf_free(file);
+		if (file == NULL)
+			file = file_l;
+		else if (!econf_mergeFiles(&file_m, file, file_l)) {
+			econf_free(file);
 			file = file_m;
 			econf_free(file_l);
 		}
@@ -319,18 +319,18 @@ void logindefs_load_file(const char *filename)
 
 int getlogindefs_bool(const char *name, int dflt)
 {
-        bool value;
+	bool value;
 	econf_err error;
 
 	if (!file)
-	        load_defaults();
+		load_defaults();
 
 	if (!file)
 		return dflt;
 
 	if ((error = econf_getBoolValue(file, NULL, name, &value))) {
-	        if (error != ECONF_NOKEY)
-	                syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
+		if (error != ECONF_NOKEY)
+			syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
 			       econf_errString(error));
 		return dflt;
 	}
@@ -343,14 +343,14 @@ unsigned long getlogindefs_num(const char *name, unsigned long dflt)
 	econf_err error;
 
 	if (!file)
-	        load_defaults();
+		load_defaults();
 
 	if (!file)
 		return dflt;
 
 	if ((error = econf_getUInt64Value(file, NULL, name, &value))) {
-	        if (error != ECONF_NOKEY)
-		        syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
+		if (error != ECONF_NOKEY)
+			syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
 			       econf_errString(error));
 		return dflt;
 	}
@@ -365,19 +365,19 @@ unsigned long getlogindefs_num(const char *name, unsigned long dflt)
  */
 const char *getlogindefs_str(const char *name, const char *dflt)
 {
-        char *value;
+	char *value;
 	econf_err error;
 
 	if (!file)
-	        load_defaults();
+		load_defaults();
 
 	if (!file)
 		return dflt;
 
 	if ((error = econf_getStringValue(file, NULL, name, &value))) {
-	        if (error != ECONF_NOKEY)
-		  syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
-			 econf_errString(error));
+		if (error != ECONF_NOKEY)
+			syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
+			       econf_errString(error));
 		return dflt;
 	}
 	if (value)
@@ -591,10 +591,10 @@ int main(int argc, char *argv[])
 				NULL};
 
 		for (i = 0; keys[i] != NULL; i++) {
-		  	char *value = NULL;
+			char *value = NULL;
 
 			econf_getStringValue(file, NULL, keys[i], &value);
-		        printf ("%s: $%s: '%s'\n", argv[1], keys[i], value);
+			printf ("%s: $%s: '%s'\n", argv[1], keys[i], value);
 		}
 
 		econf_free (file);
diff --git a/lib/loopdev.c b/lib/loopdev.c
index efc997f87..6b27e451f 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -326,7 +326,7 @@ static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
 		lc->fd = open(lc->device, lc->mode | O_CLOEXEC);
 		DBG(CXT, ul_debugobj(lc, "open %s [%s]: %m", lc->device,
 				mode == O_RDONLY ? "ro" :
-			        mode == O_RDWR ? "rw" : "??"));
+				mode == O_RDWR ? "rw" : "??"));
 
 		if (lc->fd < 0 && old >= 0) {
 			/* restore original on error */
@@ -1661,28 +1661,28 @@ int loopcxt_detach_device(struct loopdev_cxt *lc)
 
 int loopcxt_remove_device(struct loopdev_cxt *lc)
 {
-       int rc = -EINVAL;
-       int ctl, nr = -1;
+	int rc = -EINVAL;
+	int ctl, nr = -1;
 
-       if (!(lc->flags & LOOPDEV_FL_CONTROL)) {
-               rc = -ENOSYS;
-               goto done;
-       }
+	if (!(lc->flags & LOOPDEV_FL_CONTROL)) {
+		rc = -ENOSYS;
+		goto done;
+	}
 
-       rc = loopcxt_get_device_nr(lc, &nr);
-       if (rc)
-               goto done;
+	rc = loopcxt_get_device_nr(lc, &nr);
+	if (rc)
+		goto done;
 
-       ctl = open(_PATH_DEV_LOOPCTL, O_RDWR|O_CLOEXEC);
-       if (ctl >= 0) {
-               DBG(CXT, ul_debugobj(lc, "remove_device %d", nr));
-               rc = ioctl(ctl, LOOP_CTL_REMOVE, nr);
-               close(ctl);
-       }
-       lc->control_ok = rc >= 0 ? 1 : 0;
+	ctl = open(_PATH_DEV_LOOPCTL, O_RDWR|O_CLOEXEC);
+	if (ctl >= 0) {
+		DBG(CXT, ul_debugobj(lc, "remove_device %d", nr));
+		rc = ioctl(ctl, LOOP_CTL_REMOVE, nr);
+		close(ctl);
+	}
+	lc->control_ok = rc >= 0 ? 1 : 0;
 done:
-       DBG(CXT, ul_debugobj(lc, "remove_device done [rc=%d]", rc));
-       return rc;
+	DBG(CXT, ul_debugobj(lc, "remove_device done [rc=%d]", rc));
+	return rc;
 }
 
 int loopcxt_add_device(struct loopdev_cxt *lc)
diff --git a/lib/procfs.c b/lib/procfs.c
index 47cc8eea2..3499c684b 100644
--- a/lib/procfs.c
+++ b/lib/procfs.c
@@ -477,7 +477,7 @@ static int test_tasks(int argc, char *argv[], const char *prefix)
 		printf(" %d", tid);
 
 	printf("\n");
-        ul_unref_path(pc);
+	ul_unref_path(pc);
 	return EXIT_SUCCESS;
 }
 
@@ -502,7 +502,7 @@ static int test_fds(int argc, char *argv[], const char *prefix)
 		printf(" %d", fd);
 
 	fputc('\n', stdout);
-        ul_unref_path(pc);
+	ul_unref_path(pc);
 	return EXIT_SUCCESS;
 }
 
diff --git a/lib/pty-session.c b/lib/pty-session.c
index e9db4988b..b3e41e0c8 100644
--- a/lib/pty-session.c
+++ b/lib/pty-session.c
@@ -169,7 +169,7 @@ int ul_pty_setup(struct ul_pty *pty)
 	sigprocmask(0, NULL, &pty->orgsig);
 
 	if (pty->isterm) {
-	        DBG(SETUP, ul_debugobj(pty, "create for terminal"));
+		DBG(SETUP, ul_debugobj(pty, "create for terminal"));
 
 		/* original setting of the current terminal */
 		if (tcgetattr(STDIN_FILENO, &pty->stdin_attrs) != 0) {
@@ -594,9 +594,9 @@ static int handle_signal(struct ul_pty *pty, int fd)
 	case SIGQUIT:
 		DBG(SIG, ul_debugobj(pty, " get signal SIG{TERM,INT,QUIT}"));
 		pty->delivered_signal = info.ssi_signo;
-                /* Child termination is going to generate SIGCHLD (see above) */
+		/* Child termination is going to generate SIGCHLD (see above) */
 		if (pty->child > 0)
-	                kill(pty->child, SIGTERM);
+			kill(pty->child, SIGTERM);
 
 		if (pty->callbacks.log_signal)
 			rc = pty->callbacks.log_signal(pty->callback_data,
diff --git a/lib/shells.c b/lib/shells.c
index 13f293c5e..6f9cd71a9 100644
--- a/lib/shells.c
+++ b/lib/shells.c
@@ -39,34 +39,34 @@ static econf_file *open_etc_shells(void)
 extern void print_shells(FILE *out, const char *format)
 {
 #if defined (HAVE_LIBECONF) && defined (USE_VENDORDIR)
-        size_t size = 0;
-        econf_err error;
-        char **keys = NULL;
-        econf_file *key_file = open_etc_shells();
+	size_t size = 0;
+	econf_err error;
+	char **keys = NULL;
+	econf_file *key_file = open_etc_shells();
 
 	if (!key_file)
 	  return;
 
-        error = econf_getKeys(key_file, NULL, &size, &keys);
-        if (error) {
-                econf_free(key_file);
-                errx(EXIT_FAILURE,
-                  _("Cannot evaluate entries in shells files: %s"),
-                  econf_errString(error));
-        }
+	error = econf_getKeys(key_file, NULL, &size, &keys);
+	if (error) {
+		econf_free(key_file);
+		errx(EXIT_FAILURE,
+		  _("Cannot evaluate entries in shells files: %s"),
+		  econf_errString(error));
+	}
 
-        for (size_t i = 0; i < size; i++) {
-	        fprintf(out, format, keys[i]);
-        }
-        econf_free(keys);
-        econf_free(key_file);
+	for (size_t i = 0; i < size; i++) {
+		fprintf(out, format, keys[i]);
+	}
+	econf_free(keys);
+	econf_free(key_file);
 #else
-        char *s;
+	char *s;
 
 	setusershell();
-        while ((s = getusershell()))
-	        fprintf(out, format, s);
-        endusershell();
+	while ((s = getusershell()))
+		fprintf(out, format, s);
+	endusershell();
 #endif
 }
 
@@ -86,19 +86,19 @@ extern int is_known_shell(const char *shell_name)
 #if defined (HAVE_LIBECONF) && defined (USE_VENDORDIR)
 	char *val = NULL;
 	econf_err error;
-        econf_file *key_file = open_etc_shells();
+	econf_file *key_file = open_etc_shells();
 
 	if (!key_file)
-	  return 0;
+		return 0;
 
 	error = econf_getStringValue (key_file, NULL, shell_name, &val);
 	if (error) {
-	        if (error != ECONF_NOKEY)
-		       syslog(LOG_ALERT,
-		               _("Cannot evaluate entries in shells files: %s"),
-			      econf_errString(error));
+		if (error != ECONF_NOKEY)
+			syslog(LOG_ALERT,
+			       _("Cannot evaluate entries in shells files: %s"),
+			       econf_errString(error));
 	} else
-	        ret = 1;
+		ret = 1;
 
 	free(val);
 	econf_free(key_file);
diff --git a/lib/strutils.c b/lib/strutils.c
index a3b1376e3..72d0352c8 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -281,20 +281,20 @@ int ul_parse_switch(const char *arg, ...)
 #ifndef HAVE_MEMPCPY
 void *mempcpy(void *restrict dest, const void *restrict src, size_t n)
 {
-    return ((char *)memcpy(dest, src, n)) + n;
+	return ((char *)memcpy(dest, src, n)) + n;
 }
 #endif
 
 #ifndef HAVE_STRNLEN
 size_t strnlen(const char *s, size_t maxlen)
 {
-        size_t i;
+	size_t i;
 
-        for (i = 0; i < maxlen; i++) {
-                if (s[i] == '\0')
-                        return i;
-        }
-        return maxlen;
+	for (i = 0; i < maxlen; i++) {
+		if (s[i] == '\0')
+			return i;
+	}
+	return maxlen;
 }
 #endif
 
@@ -980,38 +980,38 @@ int streq_paths(const char *a, const char *b)
 /* concatenate two strings to a new string, the size of the second string is limited by @b */
 char *ul_strnconcat(const char *s, const char *suffix, size_t b)
 {
-        size_t a;
-        char *r;
+	size_t a;
+	char *r;
 
-        if (!s && !suffix)
-                return strdup("");
-        if (!s)
-                return strndup(suffix, b);
-        if (!suffix)
-                return strdup(s);
+	if (!s && !suffix)
+		return strdup("");
+	if (!s)
+		return strndup(suffix, b);
+	if (!suffix)
+		return strdup(s);
 
-        assert(s);
-        assert(suffix);
+	assert(s);
+	assert(suffix);
 
-        a = strlen(s);
-        if (b > ((size_t) -1) - a)
-                return NULL;
+	a = strlen(s);
+	if (b > ((size_t) -1) - a)
+		return NULL;
 
-        r = malloc(a + b + 1);
-        if (!r)
-                return NULL;
+	r = malloc(a + b + 1);
+	if (!r)
+		return NULL;
 
-        memcpy(r, s, a);
-        memcpy(r + a, suffix, b);
-        r[a+b] = 0;
+	memcpy(r, s, a);
+	memcpy(r + a, suffix, b);
+	r[a+b] = 0;
 
-        return r;
+	return r;
 }
 
 /* concatenate two strings to a new string */
 char *ul_strconcat(const char *s, const char *suffix)
 {
-        return ul_strnconcat(s, suffix, suffix ? strlen(suffix) : 0);
+	return ul_strnconcat(s, suffix, suffix ? strlen(suffix) : 0);
 }
 
 /* concatenate @s and string defined by @format to a new string */
@@ -1088,20 +1088,20 @@ extern int ul_strvfappend(char **a, const char *format, va_list ap)
 
 static size_t strcspn_escaped(const char *s, const char *reject)
 {
-        int escaped = 0;
-        int n;
+	int escaped = 0;
+	int n;
 
-        for (n=0; s[n]; n++) {
-                if (escaped)
-                        escaped = 0;
-                else if (s[n] == '\\')
-                        escaped = 1;
-                else if (strchr(reject, s[n]))
-                        break;
-        }
+	for (n=0; s[n]; n++) {
+		if (escaped)
+			escaped = 0;
+		else if (s[n] == '\\')
+			escaped = 1;
+		else if (strchr(reject, s[n]))
+			break;
+	}
 
-        /* if s ends in \, return index of previous char */
-        return n - escaped;
+	/* if s ends in \, return index of previous char */
+	return n - escaped;
 }
 
 /*
@@ -1138,46 +1138,46 @@ char *ul_strchr_escaped(const char *s, int c)
 /* Split a string into words. */
 const char *ul_split(const char **state, size_t *l, const char *separator, int quoted)
 {
-        const char *current;
+	const char *current;
 
-        current = *state;
+	current = *state;
 
-        if (!*current) {
-                assert(**state == '\0');
-                return NULL;
-        }
+	if (!*current) {
+		assert(**state == '\0');
+		return NULL;
+	}
 
-        current += strspn(current, separator);
-        if (!*current) {
-                *state = current;
-                return NULL;
-        }
+	current += strspn(current, separator);
+	if (!*current) {
+		*state = current;
+		return NULL;
+	}
 
-        if (quoted && strchr("\'\"", *current)) {
-                char quotechars[2] = {*current, '\0'};
+	if (quoted && strchr("\'\"", *current)) {
+		char quotechars[2] = {*current, '\0'};
 
-                *l = strcspn_escaped(current + 1, quotechars);
-                if (current[*l + 1] == '\0' || current[*l + 1] != quotechars[0] ||
-                    (current[*l + 2] && !strchr(separator, current[*l + 2]))) {
-                        /* right quote missing or garbage at the end */
-                        *state = current;
-                        return NULL;
-                }
-                *state = current++ + *l + 2;
-        } else if (quoted) {
-                *l = strcspn_escaped(current, separator);
-                if (current[*l] && !strchr(separator, current[*l])) {
-                        /* unfinished escape */
-                        *state = current;
-                        return NULL;
-                }
-                *state = current + *l;
-        } else {
-                *l = strcspn(current, separator);
-                *state = current + *l;
-        }
+		*l = strcspn_escaped(current + 1, quotechars);
+		if (current[*l + 1] == '\0' || current[*l + 1] != quotechars[0] ||
+		    (current[*l + 2] && !strchr(separator, current[*l + 2]))) {
+			/* right quote missing or garbage at the end */
+			*state = current;
+			return NULL;
+		}
+		*state = current++ + *l + 2;
+	} else if (quoted) {
+		*l = strcspn_escaped(current, separator);
+		if (current[*l] && !strchr(separator, current[*l])) {
+			/* unfinished escape */
+			*state = current;
+			return NULL;
+		}
+		*state = current + *l;
+	} else {
+		*l = strcspn(current, separator);
+		*state = current + *l;
+	}
 
-        return current;
+	return current;
 }
 
 /* Rewind file pointer forward to new line.  */
diff --git a/lib/sysfs.c b/lib/sysfs.c
index c888617b7..13977ee5b 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -183,7 +183,7 @@ char *sysfs_blkdev_get_name(struct path_cxt *pc, char *buf, size_t bufsiz)
 	char *name;
 	ssize_t	sz;
 
-        /* read /sys/dev/block/<maj:min> link */
+	/* read /sys/dev/block/<maj:min> link */
 	sz = ul_path_readlink(pc, link, sizeof(link), NULL);
 	if (sz < 0)
 		return NULL;
@@ -522,29 +522,29 @@ int sysfs_blkdev_is_removable(struct path_cxt *pc)
 }
 
 static int get_dm_wholedisk(struct path_cxt *pc, char *diskname,
-                size_t len, dev_t *diskdevno)
+                            size_t len, dev_t *diskdevno)
 {
-    int rc = 0;
-    char *name;
+	int rc = 0;
+	char *name;
 
-    /* Note, sysfs_blkdev_get_slave() returns the first slave only,
-     * if there is more slaves, then return NULL
-     */
-    name = sysfs_blkdev_get_slave(pc);
-    if (!name)
-        return -1;
+	/* Note: sysfs_blkdev_get_slave() returns the first slave only;
+	 * if there are more slaves, it returns NULL.
+	 */
+	name = sysfs_blkdev_get_slave(pc);
+	if (!name)
+		return -1;
 
-    if (diskname && len)
-        xstrncpy(diskname, name, len);
+	if (diskname && len)
+		xstrncpy(diskname, name, len);
 
-    if (diskdevno) {
-        *diskdevno = __sysfs_devname_to_devno(ul_path_get_prefix(pc), name, NULL);
-        if (!*diskdevno)
-            rc = -1;
-    }
+	if (diskdevno) {
+		*diskdevno = __sysfs_devname_to_devno(ul_path_get_prefix(pc), name, NULL);
+		if (!*diskdevno)
+			rc = -1;
+	}
 
-    free(name);
-    return rc;
+	free(name);
+	return rc;
 }
 
 /*
@@ -556,85 +556,84 @@ int sysfs_blkdev_get_wholedisk(	struct path_cxt *pc,
 				size_t len,
 				dev_t *diskdevno)
 {
-    int is_part = 0;
+	int is_part = 0;
 
-    if (!pc)
-        return -1;
+	if (!pc)
+		return -1;
 
-    is_part = ul_path_access(pc, F_OK, "partition") == 0;
-    if (!is_part) {
-        /*
-         * Extra case for partitions mapped by device-mapper.
-         *
-         * All regular partitions (added by BLKPG ioctl or kernel PT
-         * parser) have the /sys/.../partition file. The partitions
-         * mapped by DM don't have such file, but they have "part"
-         * prefix in DM UUID.
-         */
-        char *uuid = NULL, *tmp, *prefix;
+	is_part = ul_path_access(pc, F_OK, "partition") == 0;
+	if (!is_part) {
+		/*
+		 * Extra case for partitions mapped by device-mapper.
+		 *
+		 * All regular partitions (added by BLKPG ioctl or kernel PT
+		 * parser) have the /sys/.../partition file. The partitions
+		 * mapped by DM don't have such file, but they have "part"
+		 * prefix in DM UUID.
+		 */
+		char *uuid = NULL, *tmp, *prefix;
 
-	ul_path_read_string(pc, &uuid, "dm/uuid");
-	tmp = uuid;
-	prefix = uuid ? strsep(&tmp, "-") : NULL;
+		ul_path_read_string(pc, &uuid, "dm/uuid");
+		tmp = uuid;
+		prefix = uuid ? strsep(&tmp, "-") : NULL;
 
-        if (prefix && c_strncasecmp(prefix, "part", 4) == 0)
-            is_part = 1;
-        free(uuid);
+		if (prefix && c_strncasecmp(prefix, "part", 4) == 0)
+			is_part = 1;
+		free(uuid);
 
-        if (is_part &&
-            get_dm_wholedisk(pc, diskname, len, diskdevno) == 0)
-            /*
-             * partitioned device, mapped by DM
-             */
-            goto done;
+		if (is_part &&
+			get_dm_wholedisk(pc, diskname, len, diskdevno) == 0)
+			/*
+			 * partitioned device, mapped by DM
+			 */
+			goto done;
 
-        is_part = 0;
-    }
+		is_part = 0;
+	}
 
-    if (!is_part) {
-        /*
-         * unpartitioned device
-         */
-        if (diskname && !sysfs_blkdev_get_name(pc, diskname, len))
-            goto err;
-        if (diskdevno)
-            *diskdevno = sysfs_blkdev_get_devno(pc);
+	if (!is_part) {
+		/*
+		 * unpartitioned device
+		 */
+		if (diskname && !sysfs_blkdev_get_name(pc, diskname, len))
+			goto err;
+		if (diskdevno)
+			*diskdevno = sysfs_blkdev_get_devno(pc);
+	} else {
+		/*
+		 * partitioned device
+		 *  - readlink /sys/dev/block/8:1   = ../../block/sda/sda1
+		 *  - dirname  ../../block/sda/sda1 = ../../block/sda
+		 *  - basename ../../block/sda	  = sda
+		 */
+		char linkpath[PATH_MAX];
+		char *name;
+		ssize_t	linklen;
 
-    } else {
-        /*
-         * partitioned device
-         *  - readlink /sys/dev/block/8:1   = ../../block/sda/sda1
-         *  - dirname  ../../block/sda/sda1 = ../../block/sda
-         *  - basename ../../block/sda      = sda
-         */
-        char linkpath[PATH_MAX];
-        char *name;
-	ssize_t	linklen;
+		linklen = ul_path_readlink(pc, linkpath, sizeof(linkpath), NULL);
+		if (linklen < 0)
+			goto err;
 
-	linklen = ul_path_readlink(pc, linkpath, sizeof(linkpath), NULL);
-        if (linklen < 0)
-            goto err;
+		stripoff_last_component(linkpath);	  /* dirname */
+		name = stripoff_last_component(linkpath);   /* basename */
+		if (!name)
+			goto err;
 
-        stripoff_last_component(linkpath);      /* dirname */
-        name = stripoff_last_component(linkpath);   /* basename */
-        if (!name)
-            goto err;
+		sysfs_devname_sys_to_dev(name);
+		if (diskname && len)
+			xstrncpy(diskname, name, len);
 
-	sysfs_devname_sys_to_dev(name);
-        if (diskname && len)
-            xstrncpy(diskname, name, len);
-
-        if (diskdevno) {
-            *diskdevno = __sysfs_devname_to_devno(ul_path_get_prefix(pc), name, NULL);
-            if (!*diskdevno)
-                goto err;
-        }
-    }
+		if (diskdevno) {
+			*diskdevno = __sysfs_devname_to_devno(ul_path_get_prefix(pc), name, NULL);
+			if (!*diskdevno)
+				goto err;
+		}
+	}
 
 done:
-    return 0;
+	return 0;
 err:
-    return -1;
+	return -1;
 }
 
 int sysfs_devno_to_wholedisk(dev_t devno, char *diskname,
@@ -790,7 +789,7 @@ char *sysfs_blkdev_scsi_host_strdup_attribute(struct path_cxt *pc,
 		return NULL;
 
 	if (!(f = fopen(buf, "r" UL_CLOEXECSTR)))
-                return NULL;
+		return NULL;
 
 	rc = fscanf(f, "%1023[^\n]", buf);
 	fclose(f);
@@ -1093,7 +1092,7 @@ char *sysfs_chrdev_devno_to_devname(dev_t devno, char *buf, size_t bufsiz)
 	if (!pc)
 		return NULL;
 
-        /* read /sys/dev/char/<maj:min> link */
+	/* read /sys/dev/char/<maj:min> link */
 	sz = ul_path_readlink(pc, link, sizeof(link), NULL);
 	ul_unref_path(pc);
 
diff --git a/lib/timer.c b/lib/timer.c
index cfa18f6fd..2f7e90cd4 100644
--- a/lib/timer.c
+++ b/lib/timer.c
@@ -92,7 +92,7 @@ int setup_timer(struct ul_timer *timer,
 void cancel_timer(struct ul_timer *timer)
 {
 	setitimer(ITIMER_REAL, &timer->old_timer, NULL);
-        sigaction(SIGALRM, &timer->old_sa, NULL);
+	sigaction(SIGALRM, &timer->old_sa, NULL);
 
 }
 #endif /* !HAVE_TIMER_CREATE */
diff --git a/login-utils/login.c b/login-utils/login.c
index 402e17820..d847b81e7 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1303,8 +1303,8 @@ static void load_credentials(struct login_context *cxt) {
 	struct path_cxt *pc;
 
 	env = safe_getenv("CREDENTIALS_DIRECTORY");
-        if (!env)
-                return;
+	if (!env)
+		return;
 
 	pc = ul_new_path("%s", env);
 	if (!pc) {
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 93eeab111..7faf19da1 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -124,7 +124,7 @@ void emergency_do_mounts(void)
 	if (stat("/dev", &xt) == 0
 	    && rt.st_dev == xt.st_dev
 	    && mount("devtmpfs", "/dev", "devtmpfs",
-		     MS_RELATIME, "mode=0755,nr_inodes=0") == 0) {
+	             MS_RELATIME, "mode=0755,nr_inodes=0") == 0) {
 
 		emergency_flags |= MNT_DEVTMPFS;
 		mknod("/dev/console", S_IFCHR|S_IRUSR|S_IWUSR,
@@ -249,9 +249,9 @@ char* scandev(DIR *dir, const dev_t comparedev)
 			    "/dev/char/%u:%u", major(comparedev), minor(comparedev))) > 0 &&
 	    (size_t)len < sizeof(path)) {
 
-	    name = realpath(path, NULL);
-	    if (name)
-		    goto out;
+		name = realpath(path, NULL);
+		if (name)
+			goto out;
 	}
 
 	fd = dirfd(dir);
@@ -771,7 +771,7 @@ console:
 fallback:
 	if (fallback >= 0) {
 		const char *name;
-	        char *n;
+		char *n;
 		struct console *console;
 
 		if (device && *device != '\0')
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 78511dca7..f1526bcad 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -812,14 +812,14 @@ static char *get_tabdiff_data(struct libmnt_fs *old_fs,
 		break;
 	case COL_OLD_OPTIONS:
 		if (old_fs && (change == MNT_TABDIFF_REMOUNT ||
-			       change == MNT_TABDIFF_UMOUNT)
+		               change == MNT_TABDIFF_UMOUNT)
 		           && mnt_fs_get_options(old_fs))
 			str = xstrdup(mnt_fs_get_options(old_fs));
 		break;
 	case COL_OLD_TARGET:
 		if (old_fs && (change == MNT_TABDIFF_MOVE ||
-			       change == MNT_TABDIFF_UMOUNT)
-			   && mnt_fs_get_target(old_fs))
+		               change == MNT_TABDIFF_UMOUNT)
+		           && mnt_fs_get_target(old_fs))
 			str = xstrdup(mnt_fs_get_target(old_fs));
 		break;
 	default:
@@ -1519,10 +1519,10 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(
-	" %1$s [options]\n"
-	" %1$s [options] <device> | <mountpoint>\n"
-	" %1$s [options] <device> <mountpoint>\n"
-	" %1$s [options] [--source <device>] [--target <path> | --mountpoint <dir>]\n"),
+		" %1$s [options]\n"
+		" %1$s [options] <device> | <mountpoint>\n"
+		" %1$s [options] <device> <mountpoint>\n"
+		" %1$s [options] [--source <device>] [--target <path> | --mountpoint <dir>]\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -1677,7 +1677,7 @@ static struct libscols_table *init_scols_table(struct findmnt *findmnt)
 						scols_wrapzero_nextchunk,
 						NULL);
 		if ((flags & FL_JSON) || use_filter)
-	                scols_column_set_json_type(cl, get_column_json_type(id, fl, NULL,
+			scols_column_set_json_type(cl, get_column_json_type(id, fl, NULL,
 									    flags));
 	}
 
diff --git a/misc-utils/lastlog2.c b/misc-utils/lastlog2.c
index e973b5461..be33f2ae3 100644
--- a/misc-utils/lastlog2.c
+++ b/misc-utils/lastlog2.c
@@ -68,10 +68,9 @@ static int print_entry(const char *user, int64_t ll_time,
 	/* Print only if newer than t days */
 	if (tflg && ((time (NULL) - ll_time) > t_days))
 		return 0;
-        /* this is necessary if you compile this on architectures with
-           a 32bit time_t type. */
-        time_t t_time = ll_time;
-        tm = localtime_r(&t_time, &tm_buf);
+	/* This is needed on architectures with a 32bit time_t type. */
+	time_t t_time = ll_time;
+	tm = localtime_r(&t_time, &tm_buf);
 	if (tm == NULL)
 		datep = "(unknown)";
 	else {
diff --git a/misc-utils/lsblk-devtree.c b/misc-utils/lsblk-devtree.c
index 07f67b4da..5e9d38da1 100644
--- a/misc-utils/lsblk-devtree.c
+++ b/misc-utils/lsblk-devtree.c
@@ -160,7 +160,7 @@ int lsblk_device_new_dependence(struct lsblk_device *parent, struct lsblk_device
 	dp->parent = parent;
 	list_add_tail(&dp->ls_parents, &child->parents);
 
-        DBG(DEV, ul_debugobj(parent, "add dependence 0x%p [%s->%s]", dp, parent->name, child->name));
+	DBG(DEV, ul_debugobj(parent, "add dependence 0x%p [%s->%s]", dp, parent->name, child->name));
 
 	return 0;
 }
@@ -307,16 +307,16 @@ int lsblk_devtree_add_root(struct lsblk_devtree *tr, struct lsblk_device *dev)
 	/* We don't increment reference counter for tr->roots list. The primary
 	 * reference is tr->devices */
 
-        DBG(TREE, ul_debugobj(tr, "add root device 0x%p [%s]", dev, dev->name));
-        list_add_tail(&dev->ls_roots, &tr->roots);
+	DBG(TREE, ul_debugobj(tr, "add root device 0x%p [%s]", dev, dev->name));
+	list_add_tail(&dev->ls_roots, &tr->roots);
 	return 0;
 }
 
 int lsblk_devtree_remove_root(struct lsblk_devtree *tr __attribute__((unused)),
 			      struct lsblk_device *dev)
 {
-        DBG(TREE, ul_debugobj(tr, "remove root device 0x%p [%s]", dev, dev->name));
-        list_del_init(&dev->ls_roots);
+	DBG(TREE, ul_debugobj(tr, "remove root device 0x%p [%s]", dev, dev->name));
+	list_del_init(&dev->ls_roots);
 
 	return 0;
 }
@@ -343,8 +343,8 @@ int lsblk_devtree_add_device(struct lsblk_devtree *tr, struct lsblk_device *dev)
 {
 	lsblk_ref_device(dev);
 
-        DBG(TREE, ul_debugobj(tr, "add device 0x%p [%s]", dev, dev->name));
-        list_add_tail(&dev->ls_devices, &tr->devices);
+	DBG(TREE, ul_debugobj(tr, "add device 0x%p [%s]", dev, dev->name));
+	list_add_tail(&dev->ls_devices, &tr->devices);
 	return 0;
 }
 
@@ -398,7 +398,7 @@ struct lsblk_device *lsblk_devtree_get_device(struct lsblk_devtree *tr, const ch
 
 int lsblk_devtree_remove_device(struct lsblk_devtree *tr, struct lsblk_device *dev)
 {
-        DBG(TREE, ul_debugobj(tr, "remove device 0x%p [%s]", dev, dev->name));
+	DBG(TREE, ul_debugobj(tr, "remove device 0x%p [%s]", dev, dev->name));
 
 	if (!lsblk_devtree_has_device(tr, dev))
 		return 1;
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index d7bf4c5d7..629c48840 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -147,8 +147,8 @@ static int do_symlink(char *from, char *to, char *s, int verbose, int noact,
 	ssize_t ssz;
 	struct stat sb;
 
-	if ( faccessat(AT_FDCWD, s, F_OK, AT_SYMLINK_NOFOLLOW) != 0 &&
-	     errno != EINVAL )
+	if (faccessat(AT_FDCWD, s, F_OK, AT_SYMLINK_NOFOLLOW) != 0 &&
+	    errno != EINVAL )
 	   /* Skip if AT_SYMLINK_NOFOLLOW is not supported; lstat() below will
 	      detect the access error */
 	{
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 8e38f8d61..740d4f3c6 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -78,7 +78,7 @@ static void __attribute__((__noreturn__)) usage(void)
 
 static int remove_id(int type, int iskey, int id)
 {
-        int ret;
+	int ret;
 	char *errmsg;
 	/* needed to delete semaphores */
 	union semun arg;
diff --git a/sys-utils/ldattach.c b/sys-utils/ldattach.c
index 0bc97c903..eba8da126 100644
--- a/sys-utils/ldattach.c
+++ b/sys-utils/ldattach.c
@@ -304,9 +304,9 @@ int main(int argc, char **argv)
 		{"help", no_argument, NULL, 'h'},
 		{"version", no_argument, NULL, 'V'},
 		{"debug", no_argument, NULL, 'd'},
-	        {"intro-command", required_argument, NULL, 'c'},
-	        {"pause", required_argument, NULL, 'p'},
-	        {"mtu", required_argument, NULL, 'm'},
+		{"intro-command", required_argument, NULL, 'c'},
+		{"pause", required_argument, NULL, 'p'},
+		{"mtu", required_argument, NULL, 'm'},
 		{NULL, 0, NULL, 0}
 	};
 
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 7da0ebbd0..aac495aee 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -830,7 +830,7 @@ int main(int argc, char **argv)
 		case OPT_SIZELIMIT:			/* --sizelimit */
 			sizelimit = strtosize_or_err(optarg, _("failed to parse size"));
 			flags |= LOOPDEV_FL_SIZELIMIT;
-                        break;
+			break;
 
 		case 'h':
 			usage();
diff --git a/sys-utils/lscpu-topology.c b/sys-utils/lscpu-topology.c
index 6e0782f64..460ba449b 100644
--- a/sys-utils/lscpu-topology.c
+++ b/sys-utils/lscpu-topology.c
@@ -465,7 +465,7 @@ static int read_caches(struct lscpu_cxt *cxt, struct lscpu_cpu *cpu)
 		if (ul_path_readf_s32(sys, &level, "cpu%d/cache/index%zu/level", num, i) != 0)
 			continue;
 		if (ul_path_readf_buffer(sys, buf, sizeof(buf),
-                                        "cpu%d/cache/index%zu/type", num, i) <= 0)
+		                         "cpu%d/cache/index%zu/type", num, i) <= 0)
 			continue;
 
 		if (id == -1)
diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 2e887e802..2fb4977f9 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -1593,16 +1593,16 @@ static void __attribute__((__noreturn__)) usage(void)
 
 static void __attribute__((__noreturn__)) list_colunms(struct lsns *ls)
 {
-   struct libscols_table *col_tb = xcolumn_list_table_new("lsns-columns", stdout, ls->raw, ls->json);
+	struct libscols_table *col_tb = xcolumn_list_table_new("lsns-columns", stdout, ls->raw, ls->json);
 
-   for (size_t i = 0; i < ARRAY_SIZE(infos); i++)
-           xcolumn_list_table_append_line(col_tb, infos[i].name,
-					  infos[i].json_type, NULL,
-					  _(infos[i].help));
-   scols_print_table(col_tb);
-   scols_unref_table(col_tb);
+	for (size_t i = 0; i < ARRAY_SIZE(infos); i++)
+		xcolumn_list_table_append_line(col_tb, infos[i].name,
+					       infos[i].json_type, NULL,
+					       _(infos[i].help));
+	scols_print_table(col_tb);
+	scols_unref_table(col_tb);
 
-   exit(EXIT_SUCCESS);
+	exit(EXIT_SUCCESS);
 }
 
 static int stat_self_ns (const char *ns, struct stat *st)
diff --git a/sys-utils/swapoff.c b/sys-utils/swapoff.c
index 21c8e1ee8..152d1e11b 100644
--- a/sys-utils/swapoff.c
+++ b/sys-utils/swapoff.c
@@ -96,7 +96,7 @@ static char *resolve_swapfile_tag(const char *name, const char *value)
 
 static int do_swapoff(const char *orig_special, int quiet, int canonic)
 {
-        const char *special = orig_special;
+	 const char *special = orig_special;
 	char *buf = NULL;
 	int rc = SWAPOFF_EX_OK;
 
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 2201f81ce..c6ee0c6bb 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -247,7 +247,7 @@ int main(int argc, char **argv)
 	/* Need to open O_NONBLOCK in case ABORTOPEN is already set
 	 * and printer is off or off-line or in an error condition.
 	 * Otherwise we would abort...
-         */
+	 */
 	if (fd < 0)
 		err(EXIT_FAILURE, "%s", filename);
 
@@ -265,7 +265,7 @@ int main(int argc, char **argv)
 	 */
 	if (LPGETIRQ >= 0x0600 && ioctl(fd, LPGETIRQ, &irq) < 0
 	    && errno == EINVAL)
-	        /* We don't understand the new ioctls */
+		/* We don't understand the new ioctls */
 		offset = 0x0600;
 
 	cmds = cmdst;
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 11aeae48e..7b177e618 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -1038,7 +1038,7 @@ int main(int argc, char *argv[])
 				kill_child_signo = SIGKILL;
 			}
 			break;
-                case OPT_KEEPCAPS:
+		case OPT_KEEPCAPS:
 			keepcaps = 1;
 			cap_last_cap(); /* Force last cap to be cached before we fork. */
 			break;
@@ -1056,11 +1056,11 @@ int main(int argc, char *argv[])
 		case 'w':
 			newdir = optarg;
 			break;
-                case OPT_MONOTONIC:
+		case OPT_MONOTONIC:
 			monotonic = strtos64_or_err(optarg, _("failed to parse monotonic offset"));
 			force_monotonic = 1;
 			break;
-                case OPT_BOOTTIME:
+		case OPT_BOOTTIME:
 			boottime = strtos64_or_err(optarg, _("failed to parse boottime offset"));
 			force_boottime = 1;
 			break;
@@ -1206,13 +1206,13 @@ int main(int argc, char *argv[])
 #endif
 	}
 
-        if (mapuser != (uid_t) -1 && !usermap)
+	if (mapuser != (uid_t) -1 && !usermap)
 		map_id(_PATH_PROC_UIDMAP, mapuser, real_euid);
 
-        /* Since Linux 3.19 unprivileged writing of /proc/self/gid_map
-         * has been disabled unless /proc/self/setgroups is written
-         * first to permanently disable the ability to call setgroups
-         * in that user namespace. */
+	/* Since Linux 3.19 unprivileged writing of /proc/self/gid_map
+	 * has been disabled unless /proc/self/setgroups is written
+	 * first to permanently disable the ability to call setgroups
+	 * in that user namespace. */
 	if (mapgroup != (gid_t) -1 && !groupmap) {
 		if (setgrpcmd == SETGROUPS_ALLOW)
 			errx(EXIT_FAILURE, _("options --setgroups=allow and "
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 057e4a3c0..a890d1b9d 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -224,7 +224,7 @@ static int zram_wait_initialized(struct zram *z)
 	/* Wait up to 3 seconds. */
 	r = sd_event_add_time_relative(event, NULL, CLOCK_BOOTTIME, 3 * 1000 * 1000, 0, NULL, (void*) (intptr_t) (-ETIMEDOUT));
 	if (r < 0)
-	        return r;
+		return r;
 
 	/* Check if the device is already initialized. */
 #if HAVE_DECL_SD_DEVICE_OPEN
@@ -277,7 +277,7 @@ static int zram_lock(struct zram *z, int operation)
 #if HAVE_DECL_SD_DEVICE_OPEN
 	if (z->device) {
 		fd = sd_device_open(z->device, O_RDONLY|O_CLOEXEC|O_NONBLOCK|O_NOCTTY);
-	        if (fd < 0)
+		if (fd < 0)
 			return fd;
 	} else {
 #endif
@@ -909,7 +909,7 @@ int main(int argc, char **argv)
 		if (outarg && string_add_to_idarray(outarg,
 					columns, ARRAY_SIZE(columns),
 					&ncolumns, column_name_to_id) < 0)
-	                return EXIT_FAILURE;
+			return EXIT_FAILURE;
 
 		if (optind < argc) {
 			zram = new_zram(argv[optind++]);
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index f4d720448..d3b650023 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1706,8 +1706,8 @@ static int issuefile_read_stream(struct issue *ie, FILE *f, struct options *op,
 static int issuedir_read(struct issue *ie, const char *dirname,
 			 struct options *op, struct termios *tp)
 {
-        int dd, nfiles, i;
-        struct dirent **namelist = NULL;
+	int dd, nfiles, i;
+	struct dirent **namelist = NULL;
 
 	dd = open(dirname, O_RDONLY|O_CLOEXEC|O_DIRECTORY);
 	if (dd < 0)
@@ -1943,9 +1943,9 @@ skip:
 	struct list_head *current = NULL;
 	char *name = NULL;
 
-        /* Reading all issue files and concatinating all contents to one content.
-         * The ordering rules are defineded in:
-         * https://github.com/uapi-group/specifications/blob/main/specs/configuration_files_specification.md
+	/* Reading all issue files and concatinating all contents to one content.
+	 * The ordering rules are defineded in:
+	 * https://github.com/uapi-group/specifications/blob/main/specs/configuration_files_specification.md
 	 *
 	 * Note that _PATH_RUNSTATEDIR (/run) is always read by ul_configs_file_list().
 	 */
@@ -3120,8 +3120,8 @@ static void load_credentials(struct options *op) {
 	struct path_cxt *pc;
 
 	env = safe_getenv("CREDENTIALS_DIRECTORY");
-        if (!env)
-                return;
+	if (!env)
+		return;
 
 	pc = ul_new_path("%s", env);
 	if (!pc) {
diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 3ff3b9e04..e51f659a6 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -173,8 +173,8 @@ int main(int argc, char *argv[])
 	case RPMATCH_INVALID:
 		warnx(_("invalid argument: %s"), argv[0]);
 		errtryhelp(EXIT_FAILURE);
-        default:
-                abort();
+	default:
+		abort();
 	}
 	close(fd);
 	return ret;
diff --git a/term-utils/script.c b/term-utils/script.c
index ff7f4409f..c4f23ca48 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -1079,7 +1079,7 @@ int main(int argc, char **argv)
 			log_info(&ctl, "INPUT_LOG", "%s", infile);
 	}
 
-        /* this is the main loop */
+	/* this is the main loop */
 	rc = ul_pty_proxy_master(ctl.pty);
 
 	/* all done; cleanup and kill */
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 7e1eec7db..3efcd3015 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -175,8 +175,8 @@ main(int argc, char *argv[])
 	char streams[6] = {0};		/* IOSI - in, out, signal,info */
 	const char *log_out = NULL,
 	           *log_in = NULL,
-		   *log_io = NULL,
-		   *log_tm = NULL;
+	           *log_io = NULL,
+	           *log_tm = NULL;
 	double divi = 1;
 	int diviopt = FALSE, idx;
 	int ch, rc = 0, crmode = REPLAY_CRMODE_AUTO, summary = 0;
diff --git a/text-utils/col.c b/text-utils/col.c
index 5866d7d0e..ddf2a6109 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -601,45 +601,44 @@ static void free_line_allocations(struct col_alloc *root)
 
 static void process_char(struct col_ctl *ctl, struct col_lines *lns)
 {
-                /* Deal printable characters */
-                if (!iswgraph(lns->ch) && handle_not_graphic(ctl, lns))
-                        return;
+	/* Deal with non-printable characters. */
+	if (!iswgraph(lns->ch) && handle_not_graphic(ctl, lns))
+		return;
 
-                /* Must stuff ch in a line - are we at the right one? */
-                if ((size_t)lns->cur_line != lns->this_line - lns->adjust)
-                        update_cur_line(ctl, lns);
+	/* Must stuff ch in a line - are we at the right one? */
+	if ((size_t)lns->cur_line != lns->this_line - lns->adjust)
+		update_cur_line(ctl, lns);
 
-                /* Does line buffer need to grow? */
-                if (ctl->l->l_lsize <= ctl->l->l_line_len + 1) {
-                        size_t need;
+	/* Does line buffer need to grow? */
+	if (ctl->l->l_lsize <= ctl->l->l_line_len + 1) {
+		size_t need;
 
-                        need = ctl->l->l_lsize ? ctl->l->l_lsize * 2 : NALLOC;
-                        ctl->l->l_line = xrealloc(ctl->l->l_line, need * sizeof(struct col_char));
-                        ctl->l->l_lsize = need;
-                }
+		need = ctl->l->l_lsize ? ctl->l->l_lsize * 2 : NALLOC;
+		ctl->l->l_line = xrealloc(ctl->l->l_line, need * sizeof(struct col_char));
+		ctl->l->l_lsize = need;
+	}
 
-                /* Store character */
-                lns->c = &ctl->l->l_line[ctl->l->l_line_len++];
-                lns->c->c_char = lns->ch;
-                lns->c->c_set = lns->cur_set;
+	/* Store character */
+	lns->c = &ctl->l->l_line[ctl->l->l_line_len++];
+	lns->c->c_char = lns->ch;
+	lns->c->c_set = lns->cur_set;
 
-                if (0 < lns->cur_col)
-                        lns->c->c_column = lns->cur_col;
-                else
-                        lns->c->c_column = 0;
-                lns->c->c_width = wcwidth(lns->ch);
-
-                /*
-                 * If things are put in out of order, they will need sorting
-                 * when it is flushed.
-                 */
-                if (lns->cur_col < ctl->l->l_max_col)
-                        ctl->l->l_needs_sort = 1;
-                else
-                        ctl->l->l_max_col = lns->cur_col;
-                if (0 < lns->c->c_width)
-                        lns->cur_col += lns->c->c_width;
+	if (0 < lns->cur_col)
+		lns->c->c_column = lns->cur_col;
+	else
+		lns->c->c_column = 0;
+	lns->c->c_width = wcwidth(lns->ch);
 
+	/*
+	 * If things are put in out of order, they will need sorting
+	 * when it is flushed.
+	 */
+	if (lns->cur_col < ctl->l->l_max_col)
+		ctl->l->l_needs_sort = 1;
+	else
+		ctl->l->l_max_col = lns->cur_col;
+	if (0 < lns->c->c_width)
+		lns->cur_col += lns->c->c_width;
 }
 
 int main(int argc, char **argv)
diff --git a/text-utils/hexdump-display.c b/text-utils/hexdump-display.c
index c865127c8..b605cad44 100644
--- a/text-utils/hexdump-display.c
+++ b/text-utils/hexdump-display.c
@@ -448,7 +448,7 @@ doskip(const char *fname, int statok, struct hexdump *hex)
 
 	if (statok) {
 		if (fstat(fileno(stdin), &sbuf))
-		        err(EXIT_FAILURE, "%s", fname);
+			err(EXIT_FAILURE, "%s", fname);
 		if (S_ISREG(sbuf.st_mode) && hex->skip > sbuf.st_size) {
 		  /* If size valid and skip >= size */
 			hex->skip -= sbuf.st_size;
@@ -458,7 +458,7 @@ doskip(const char *fname, int statok, struct hexdump *hex)
 	}
 	/* sbuf may be undefined here - do not test it */
 	if (fseek(stdin, hex->skip, SEEK_SET))
-	        err(EXIT_FAILURE, "%s", fname);
+		err(EXIT_FAILURE, "%s", fname);
 	address += hex->skip;
 	hex->skip = 0;
 }
diff --git a/text-utils/hexdump-parse.c b/text-utils/hexdump-parse.c
index 018013e5e..efc39c3b3 100644
--- a/text-utils/hexdump-parse.c
+++ b/text-utils/hexdump-parse.c
@@ -52,22 +52,22 @@ static struct list_head *color_fmt(char *cfmt, int bcnt);
 
 static void __attribute__ ((__noreturn__)) badcnt(const char *s)
 {
-        errx(EXIT_FAILURE, _("bad byte count for conversion character %s"), s);
+	errx(EXIT_FAILURE, _("bad byte count for conversion character %s"), s);
 }
 
 static void __attribute__ ((__noreturn__)) badsfmt(void)
 {
-        errx(EXIT_FAILURE, _("%%s requires a precision or a byte count"));
+	errx(EXIT_FAILURE, _("%%s requires a precision or a byte count"));
 }
 
 static void __attribute__ ((__noreturn__)) badfmt(const char *fmt)
 {
-        errx(EXIT_FAILURE, _("bad format {%s}"), fmt);
+	errx(EXIT_FAILURE, _("bad format {%s}"), fmt);
 }
 
 static void __attribute__ ((__noreturn__)) badconv(const char *ch)
 {
-        errx(EXIT_FAILURE, _("bad conversion character %%%s"), ch);
+	errx(EXIT_FAILURE, _("bad conversion character %%%s"), ch);
 }
 
 #define first_letter(s,f) strchr(f, *(s))
@@ -81,7 +81,7 @@ void addfile(char *name, struct hexdump *hex)
 	size_t n = 0;
 
 	if ((fp = fopen(name, "r")) == NULL)
-	        err(EXIT_FAILURE, _("can't read %s"), name);
+		err(EXIT_FAILURE, _("can't read %s"), name);
 
 	while (getline(&buf, &n, fp) != -1) {
 		fmt = buf;
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index 60bf6f94b..ba8d5e1f6 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -116,7 +116,7 @@ parse_args(int argc, char **argv, struct hexdump *hex)
 			colormode = UL_COLORMODE_AUTO;
 			if (optarg)
 				colormode = colormode_or_err(optarg);
-                        break;
+			break;
 		case 'n':
 			hex->length = strtosize_or_err(optarg, _("failed to parse length"));
 			break;
-- 
2.51.2

