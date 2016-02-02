Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34997 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcBBNkT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2016 08:40:19 -0500
Received: by mail-wm0-f67.google.com with SMTP id l66so2475518wml.2
        for <util-linux@vger.kernel.org>; Tue, 02 Feb 2016 05:40:18 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] swapon: move function arguments to control structure
Date: Tue,  2 Feb 2016 13:40:09 +0000
Message-Id: <1454420410-654-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
References: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes reading what the code does easier.  This change also makes error
messages to prefer none-canonical device path, e.g., the one user supplied
rather than the canonical path needed internally.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 158 ++++++++++++++++++++++++++---------------------------
 1 file changed, 77 insertions(+), 81 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index b677f50..5ad5cd1 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -65,8 +65,6 @@
 # define swapon(path, flags) syscall(SYS_swapon, path, flags)
 #endif
 
-#define CANONIC	1
-
 #define MAX_PAGESIZE	(64 * 1024)
 
 enum {
@@ -103,6 +101,8 @@ struct colinfo infos[] = {
 
 /* control struct */
 struct swapon_ctl {
+	char *device;			/* device or file to be turned on */
+	char *dev_canonical;		/* canonical path to device */
 	char *options;			/* fstab-compatible option string */
 	const char *label;		/* swap label */
 	const char *uuid;		/* unique identifier */
@@ -110,9 +110,11 @@ struct swapon_ctl {
 	int columns[ARRAY_SIZE(infos) * 2];	/* --show columns */
 	int ncolumns;			/* number of columns */
 	int priority;			/* non-prioritized swap by default */
+	unsigned int pagesize;		/* swap page size */
 	unsigned int
 		all:1,			/* turn on all swap devices */
 		bytes:1,		/* display --show in bytes */
+		canonic:1,		/* is device path canonical */
 		fix_page_size:1,	/* reinitialize page size */
 		no_fail:1,		/* skip devices that do not exist */
 		no_heading:1,		/* toggle --show headers */
@@ -288,15 +290,14 @@ static int show_table(struct swapon_ctl *ctl)
 }
 
 /* calls mkswap */
-static int swap_reinitialize(const char *device,
-			     const char *label, const char *uuid)
+static int swap_reinitialize(struct swapon_ctl *ctl)
 {
 	pid_t pid;
 	int status, ret;
-	char *cmd[7];
+	char const *cmd[7];
 	int idx=0;
 
-	warnx(_("%s: reinitializing the swap."), device);
+	warnx(_("%s: reinitializing the swap."), ctl->device);
 
 	switch((pid=fork())) {
 	case -1: /* fork error */
@@ -305,17 +306,17 @@ static int swap_reinitialize(const char *device,
 
 	case 0:	/* child */
 		cmd[idx++] = "mkswap";
-		if (label && *label) {
+		if (ctl->label) {
 			cmd[idx++] = "-L";
-			cmd[idx++] = (char *) label;
+			cmd[idx++] = ctl->label;
 		}
-		if (uuid && *uuid) {
+		if (ctl->uuid) {
 			cmd[idx++] = "-U";
-			cmd[idx++] = (char *) uuid;
+			cmd[idx++] = ctl->uuid;
 		}
-		cmd[idx++] = (char *) device;
+		cmd[idx++] = ctl->device;
 		cmd[idx++] = NULL;
-		execvp(cmd[0], cmd);
+		execvp(cmd[0], (char * const *) cmd);
 		err(EXIT_FAILURE, _("failed to execute %s"), cmd[0]);
 
 	default: /* parent */
@@ -336,31 +337,31 @@ static int swap_reinitialize(const char *device,
 	return -1; /* error */
 }
 
-static int swap_rewrite_signature(const char *devname, unsigned int pagesize)
+static int swap_rewrite_signature(const struct swapon_ctl *ctl)
 {
 	int fd, rc = -1;
 
-	fd = open(devname, O_WRONLY);
+	fd = open(ctl->dev_canonical, O_WRONLY);
 	if (fd == -1) {
-		warn(_("cannot open %s"), devname);
+		warn(_("cannot open %s"), ctl->device);
 		return -1;
 	}
 
-	if (lseek(fd, pagesize - SWAP_SIGNATURE_SZ, SEEK_SET) < 0) {
-		warn(_("%s: lseek failed"), devname);
+	if (lseek(fd, ctl->pagesize - SWAP_SIGNATURE_SZ, SEEK_SET) < 0) {
+		warn(_("%s: lseek failed"), ctl->device);
 		goto err;
 	}
 
 	if (write(fd, (void *) SWAP_SIGNATURE,
 			SWAP_SIGNATURE_SZ) != SWAP_SIGNATURE_SZ) {
-		warn(_("%s: write signature failed"), devname);
+		warn(_("%s: write signature failed"), ctl->device);
 		goto err;
 	}
 
 	rc  = 0;
 err:
 	if (close_fd(fd) != 0) {
-		warn(_("write failed: %s"), devname);
+		warn(_("write failed: %s"), ctl->device);
 		rc = -1;
 	}
 	return rc;
@@ -383,13 +384,13 @@ static int swap_detect_signature(const char *buf, int *sig)
 	return 1;
 }
 
-static char *swap_get_header(int fd, int *sig, unsigned int *pagesize)
+static char *swap_get_header(struct swapon_ctl *ctl, int fd, int *sig)
 {
 	char *buf;
 	ssize_t datasz;
 	unsigned int page;
 
-	*pagesize = 0;
+	ctl->pagesize = 0;
 	*sig = 0;
 
 	buf = xmalloc(MAX_PAGESIZE);
@@ -408,12 +409,12 @@ static char *swap_get_header(int fd, int *sig, unsigned int *pagesize)
 		if (datasz < 0 || (size_t) datasz < (page - SWAP_SIGNATURE_SZ))
 			break;
 		if (swap_detect_signature(buf + page - SWAP_SIGNATURE_SZ, sig)) {
-			*pagesize = page;
+			ctl->pagesize = page;
 			break;
 		}
 	}
 
-	if (*pagesize)
+	if (ctl->pagesize)
 		return buf;
 err:
 	free(buf);
@@ -421,9 +422,7 @@ err:
 }
 
 /* returns real size of swap space */
-static unsigned long long swap_get_size(const struct swapon_ctl *ctl,
-					const char *hdr, const char *devname,
-					unsigned int pagesize)
+static unsigned long long swap_get_size(const struct swapon_ctl *ctl, const char *hdr)
 {
 	unsigned int last_page = 0;
 	const unsigned int swap_version = SWAP_VERSION;
@@ -440,12 +439,12 @@ static unsigned long long swap_get_size(const struct swapon_ctl *ctl,
 	if (ctl->verbose)
 		warnx(_("%s: found swap signature: version %ud, "
 			"page-size %d, %s byte order"),
-			devname,
+			ctl->device,
 			swap_version,
-			pagesize / 1024,
+			ctl->pagesize / 1024,
 			flip ? _("different") : _("same"));
 
-	return ((unsigned long long) last_page + 1) * pagesize;
+	return ((unsigned long long) last_page + 1) * ctl->pagesize;
 }
 
 static void swap_get_info(struct swapon_ctl *ctl, const char *hdr)
@@ -470,89 +469,85 @@ static void swap_get_info(struct swapon_ctl *ctl, const char *hdr)
 	}
 }
 
-static int swapon_checks(struct swapon_ctl *ctl, const char *special)
+static int swapon_checks(struct swapon_ctl *ctl)
 {
 	struct stat st;
 	int fd = -1, sig;
 	char *hdr = NULL;
-	unsigned int pagesize;
 	unsigned long long devsize = 0;
 	int permMask;
 
-	fd = open(special, O_RDONLY);
+	fd = open(ctl->dev_canonical, O_RDONLY);
 	if (fd == -1) {
-		warn(_("cannot open %s"), special);
+		warn(_("cannot open %s"), ctl->device);
 		goto err;
 	}
 
 	if (fstat(fd, &st) < 0) {
-		warn(_("stat of %s failed"), special);
+		warn(_("stat of %s failed"), ctl->device);
 		goto err;
 	}
 
 	permMask = S_ISBLK(st.st_mode) ? 07007 : 07077;
 	if ((st.st_mode & permMask) != 0)
 		warnx(_("%s: insecure permissions %04o, %04o suggested."),
-				special, st.st_mode & 07777,
+				ctl->device, st.st_mode & 07777,
 				~permMask & 0666);
 
 	if (S_ISREG(st.st_mode) && st.st_uid != 0)
 		warnx(_("%s: insecure file owner %d, 0 (root) suggested."),
-				special, st.st_uid);
+				ctl->device, st.st_uid);
 
 	/* test for holes by LBT */
 	if (S_ISREG(st.st_mode)) {
 		if (st.st_blocks * 512 < st.st_size) {
 			warnx(_("%s: skipping - it appears to have holes."),
-				special);
+				ctl->device);
 			goto err;
 		}
 		devsize = st.st_size;
 	}
 
 	if (S_ISBLK(st.st_mode) && blkdev_get_size(fd, &devsize)) {
-		warnx(_("%s: get size failed"), special);
+		warnx(_("%s: get size failed"), ctl->device);
 		goto err;
 	}
 
-	hdr = swap_get_header(fd, &sig, &pagesize);
+	hdr = swap_get_header(ctl, fd, &sig);
 	if (!hdr) {
-		warnx(_("%s: read swap header failed"), special);
+		warnx(_("%s: read swap header failed"), ctl->device);
 		goto err;
 	}
 
-	if (sig == SIG_SWAPSPACE && pagesize) {
+	if (sig == SIG_SWAPSPACE && ctl->pagesize) {
 		unsigned long long swapsize =
-				swap_get_size(ctl, hdr, special, pagesize);
+				swap_get_size(ctl, hdr);
 		int syspg = getpagesize();
 
 		if (ctl->verbose)
 			warnx(_("%s: pagesize=%d, swapsize=%llu, devsize=%llu"),
-				special, pagesize, swapsize, devsize);
+				ctl->device, ctl->pagesize, swapsize, devsize);
 
 		if (swapsize > devsize) {
 			if (ctl->verbose)
 				warnx(_("%s: last_page 0x%08llx is larger"
 					" than actual size of swapspace"),
-					special, swapsize);
-		} else if (syspg < 0 || (unsigned) syspg != pagesize) {
+					ctl->device, swapsize);
+		} else if (syspg < 0 || (unsigned int) syspg != ctl->pagesize) {
 			if (ctl->fix_page_size) {
-				char *label = NULL, *uuid = NULL;
 				int rc;
 
 				swap_get_info(ctl, hdr);
 
 				warnx(_("%s: swap format pagesize does not match."),
-					special);
-				rc = swap_reinitialize(special, label, uuid);
-				free(label);
-				free(uuid);
+					ctl->device);
+				rc = swap_reinitialize(ctl);
 				if (rc < 0)
 					goto err;
 			} else
 				warnx(_("%s: swap format pagesize does not match. "
 					"(Use --fixpgsz to reinitialize it.)"),
-					special);
+					ctl->device);
 		}
 	} else if (sig == SIG_SWSUSPEND) {
 		/* We have to reinitialize swap with old (=useless) software suspend
@@ -561,8 +556,8 @@ static int swapon_checks(struct swapon_ctl *ctl, const char *special)
 		 */
 		warnx(_("%s: software suspend data detected. "
 				"Rewriting the swap signature."),
-			special);
-		if (swap_rewrite_signature(special, pagesize) < 0)
+			ctl->device);
+		if (swap_rewrite_signature(ctl) < 0)
 			goto err;
 	}
 
@@ -576,23 +571,22 @@ err:
 	return -1;
 }
 
-static int do_swapon(struct swapon_ctl *ctl, const char *orig_special,
-		     int canonic)
+static int do_swapon(struct swapon_ctl *ctl)
 {
 	int status;
-	const char *special = orig_special;
 	int flags = 0;
 
 	if (ctl->verbose)
-		printf(_("swapon %s\n"), orig_special);
+		printf(_("swapon %s\n"), ctl->device);
 
-	if (!canonic) {
-		special = mnt_resolve_spec(orig_special, mntcache);
-		if (!special)
-			return cannot_find(orig_special);
-	}
+	if (!ctl->canonic) {
+		ctl->dev_canonical = mnt_resolve_spec(ctl->device, mntcache);
+		if (!ctl->dev_canonical)
+			return cannot_find(ctl->device);
+	} else
+		ctl->dev_canonical = ctl->device;
 
-	if (swapon_checks(ctl, special))
+	if (swapon_checks(ctl))
 		return -1;
 
 #ifdef SWAP_FLAG_PREFER
@@ -621,25 +615,23 @@ static int do_swapon(struct swapon_ctl *ctl, const char *orig_special,
 			flags |= ctl->discard;
 	}
 
-	status = swapon(special, flags);
+	status = swapon(ctl->dev_canonical, flags);
 	if (status < 0)
-		warn(_("%s: swapon failed"), orig_special);
+		warn(_("%s: swapon failed"), ctl->device);
 
 	return status;
 }
 
 static int swapon_by_label(struct swapon_ctl *ctl)
 {
-	const char *special = mnt_resolve_tag("LABEL", ctl->label, mntcache);
-	return special ? do_swapon(ctl, special, CANONIC) :
-			 cannot_find(ctl->label);
+	ctl->device = mnt_resolve_tag("LABEL", ctl->label, mntcache);
+	return ctl->device ? do_swapon(ctl) :  cannot_find(ctl->label);
 }
 
 static int swapon_by_uuid(struct swapon_ctl *ctl)
 {
-	const char *special = mnt_resolve_tag("UUID", ctl->uuid, mntcache);
-	return special ? do_swapon(ctl, special, CANONIC) :
-			 cannot_find(ctl->uuid);
+	ctl->device = mnt_resolve_tag("UUID", ctl->uuid, mntcache);
+	return ctl->device ? do_swapon(ctl) : cannot_find(ctl->uuid);
 }
 
 /* -o <options> or fstab */
@@ -693,7 +685,7 @@ static int swapon_all(struct swapon_ctl *ctl)
 
 	while (mnt_table_find_next_fs(tb, itr, match_swap, NULL, &fs) == 0) {
 		/* defaults */
-		const char *opts, *src;
+		const char *opts;
 
 		if (mnt_fs_get_option(fs, "noauto", NULL, NULL) == 0)
 			continue;
@@ -702,16 +694,16 @@ static int swapon_all(struct swapon_ctl *ctl)
 		if (opts)
 			parse_options(ctl);
 
-		src = mnt_resolve_spec(mnt_fs_get_source(fs), mntcache);
-		if (!src) {
+		ctl->device = mnt_resolve_spec(mnt_fs_get_source(fs), mntcache);
+		if (!ctl->device) {
 			if (!ctl->no_fail)
 				status |= cannot_find(mnt_fs_get_source(fs));
 			continue;
 		}
 
-		if (!is_active_swap(src) &&
-		    (!ctl->no_fail || !access(src, R_OK)))
-			status |= do_swapon(ctl, src, CANONIC);
+		if (!is_active_swap(ctl->device) &&
+		    (!ctl->no_fail || !access(ctl->device, R_OK)))
+			status |= do_swapon(ctl);
 	}
 
 	mnt_free_iter(itr);
@@ -808,7 +800,7 @@ int main(int argc, char *argv[])
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
-	struct swapon_ctl ctl = { .priority = -1, 0 };
+	struct swapon_ctl ctl = { .priority = -1, .canonic = 1, 0 };
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -932,9 +924,13 @@ int main(int argc, char *argv[])
 		ctl.uuid = get_uuid(i);
 		status |= swapon_by_uuid(&ctl);
 	}
-
-	while (*argv != NULL)
-		status |= do_swapon(&ctl, *argv++, !CANONIC);
+	if (*argv != NULL) {
+		ctl.canonic = 0;
+		while (*argv != NULL) {
+			ctl.device = *argv++;
+			status |= do_swapon(&ctl);
+		}
+	}
 
 	free_tables();
 	mnt_unref_cache(mntcache);
-- 
2.7.0

