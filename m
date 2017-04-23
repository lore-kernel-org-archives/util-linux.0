Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34893 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046084AbdDWU6q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:46 -0400
Received: by mail-wm0-f50.google.com with SMTP id w64so48376886wma.0
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/10] misc: clarify ternary operators with parentheses
Date: Sun, 23 Apr 2017 21:58:17 +0100
Message-Id: <20170423205821.7444-7-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Compilers probably got these evaluations right, but it is best not to leave
any room of interpretation what is the human intention.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/blockdev.c          |  2 +-
 lib/loopdev.c                  |  4 ++--
 lib/strutils.c                 | 30 +++++++++++++++---------------
 libfdisk/src/bsd.c             | 10 +++++-----
 libfdisk/src/label.c           |  2 +-
 libfdisk/src/sun.c             |  4 ++--
 libmount/src/context.c         | 38 +++++++++++++++++++-------------------
 libmount/src/context_mount.c   |  2 +-
 libsmartcols/src/column.c      | 14 +++++++-------
 libsmartcols/src/table_print.c |  6 +++---
 misc-utils/findmnt.c           |  2 +-
 misc-utils/whereis.c           |  6 +++---
 sys-utils/ipcs.c               |  4 ++--
 sys-utils/wdctl.c              |  8 ++++----
 term-utils/script.c            | 12 ++++++------
 15 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index 2f6681ce2..c8754c3d7 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -338,7 +338,7 @@ static void do_commands(int fd, char **argv, int d)
 			} else
 				iarg = bdcms[j].argval;
 
-			res = bdcms[j].flags & FL_NOPTR ?
+			res = (bdcms[j].flags & FL_NOPTR) ?
 			    ioctl(fd, bdcms[j].ioc, iarg) :
 			    ioctl(fd, bdcms[j].ioc, &iarg);
 			break;
diff --git a/lib/loopdev.c b/lib/loopdev.c
index fd4f16692..232336ab2 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -275,10 +275,10 @@ int loopcxt_get_fd(struct loopdev_cxt *lc)
 		return -EINVAL;
 
 	if (lc->fd < 0) {
-		lc->mode = lc->flags & LOOPDEV_FL_RDWR ? O_RDWR : O_RDONLY;
+		lc->mode = (lc->flags & LOOPDEV_FL_RDWR) ? O_RDWR : O_RDONLY;
 		lc->fd = open(lc->device, lc->mode | O_CLOEXEC);
 		DBG(CXT, ul_debugobj(lc, "open %s [%s]: %m", lc->device,
-				lc->flags & LOOPDEV_FL_RDWR ? "rw" : "ro"));
+				(lc->flags & LOOPDEV_FL_RDWR) ? "rw" : "ro"));
 	}
 	return lc->fd;
 }
diff --git a/lib/strutils.c b/lib/strutils.c
index 45127b5a2..580ec2139 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -497,21 +497,21 @@ void xstrmode(mode_t mode, char *str)
 	else if (S_ISREG(mode))
 		str[i++] = '-';
 
-	str[i++] = mode & S_IRUSR ? 'r' : '-';
-	str[i++] = mode & S_IWUSR ? 'w' : '-';
-	str[i++] = (mode & S_ISUID
-		? (mode & S_IXUSR ? 's' : 'S')
-		: (mode & S_IXUSR ? 'x' : '-'));
-	str[i++] = mode & S_IRGRP ? 'r' : '-';
-	str[i++] = mode & S_IWGRP ? 'w' : '-';
-	str[i++] = (mode & S_ISGID
-		? (mode & S_IXGRP ? 's' : 'S')
-		: (mode & S_IXGRP ? 'x' : '-'));
-	str[i++] = mode & S_IROTH ? 'r' : '-';
-	str[i++] = mode & S_IWOTH ? 'w' : '-';
-	str[i++] = (mode & S_ISVTX
-		? (mode & S_IXOTH ? 't' : 'T')
-		: (mode & S_IXOTH ? 'x' : '-'));
+	str[i++] = (mode & S_IRUSR) ? 'r' : '-';
+	str[i++] = (mode & S_IWUSR) ? 'w' : '-';
+	str[i++] = ((mode & S_ISUID)
+		    ? ((mode & S_IXUSR) ? 's' : 'S')
+		    : ((mode & S_IXUSR) ? 'x' : '-'));
+	str[i++] = (mode & S_IRGRP) ? 'r' : '-';
+	str[i++] = (mode & S_IWGRP) ? 'w' : '-';
+	str[i++] = ((mode & S_ISGID)
+		    ? ((mode & S_IXGRP) ? 's' : 'S')
+		    : ((mode & S_IXGRP) ? 'x' : '-'));
+	str[i++] = (mode & S_IROTH) ? 'r' : '-';
+	str[i++] = (mode & S_IWOTH) ? 'w' : '-';
+	str[i++] = ((mode & S_ISVTX)
+		    ? ((mode & S_IXOTH) ? 't' : 'T')
+		    : ((mode & S_IXOTH) ? 'x' : '-'));
 	str[i] = '\0';
 }
 
diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
index 0a2563dde..702f5d143 100644
--- a/libfdisk/src/bsd.c
+++ b/libfdisk/src/bsd.c
@@ -463,9 +463,9 @@ static int bsd_get_disklabel_item(struct fdisk_context *cxt, struct fdisk_labeli
 		item->name = _("Flags");
 		item->type = 's';
 		item->data.str = strdup(
-			d->d_flags & BSD_D_REMOVABLE ? _(" removable") :
-			d->d_flags & BSD_D_ECC ? _(" ecc") :
-			d->d_flags & BSD_D_BADSECT ? _(" badsect") : "");
+			(d->d_flags & BSD_D_REMOVABLE) ? _(" removable") :
+			(d->d_flags & BSD_D_ECC) ? _(" ecc") :
+			(d->d_flags & BSD_D_BADSECT) ? _(" badsect") : "");
 		if (!item->data.str)
 			rc = -ENOMEM;
 		break;
@@ -553,8 +553,8 @@ static int bsd_get_partition(struct fdisk_context *cxt, size_t n,
 		return 0;
 
 	if (fdisk_use_cylinders(cxt) && d->d_secpercyl) {
-		pa->start_post = p->p_offset % d->d_secpercyl ? '*' : ' ';
-		pa->end_post = (p->p_offset + p->p_size) % d->d_secpercyl ? '*' : ' ';
+		pa->start_post = (p->p_offset % d->d_secpercyl) ? '*' : ' ';
+		pa->end_post = ((p->p_offset + p->p_size) % d->d_secpercyl) ? '*' : ' ';
 	}
 
 	pa->start = p->p_offset;
diff --git a/libfdisk/src/label.c b/libfdisk/src/label.c
index 1319284b0..99c90d295 100644
--- a/libfdisk/src/label.c
+++ b/libfdisk/src/label.c
@@ -95,7 +95,7 @@ int fdisk_label_require_geometry(const struct fdisk_label *lb)
 {
 	assert(lb);
 
-	return lb->flags & FDISK_LABEL_FL_REQUIRE_GEOMETRY ? 1 : 0;
+	return (lb->flags & FDISK_LABEL_FL_REQUIRE_GEOMETRY) ? 1 : 0;
 }
 
 /**
diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index 5414a927c..224a7dfff 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -845,8 +845,8 @@ static int sun_get_partition(struct fdisk_context *cxt, size_t n,
 
 	if (flags & SUN_FLAG_UNMNT || flags & SUN_FLAG_RONLY) {
 		if (asprintf(&pa->attrs, "%c%c",
-				flags & SUN_FLAG_UNMNT ? 'u' : ' ',
-				flags & SUN_FLAG_RONLY ? 'r' : ' ') < 0)
+				(flags & SUN_FLAG_UNMNT) ? 'u' : ' ',
+				(flags & SUN_FLAG_RONLY) ? 'r' : ' ') < 0)
 			return -ENOMEM;
 	}
 
diff --git a/libmount/src/context.c b/libmount/src/context.c
index e731749b4..6f12c39ba 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -369,7 +369,7 @@ int mnt_context_disable_canonicalize(struct libmnt_context *cxt, int disable)
  */
 int mnt_context_is_nocanonicalize(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_NOCANONICALIZE ? 1 : 0;
+	return (cxt->flags & MNT_FL_NOCANONICALIZE) ? 1 : 0;
 }
 
 /**
@@ -394,7 +394,7 @@ int mnt_context_enable_lazy(struct libmnt_context *cxt, int enable)
  */
 int mnt_context_is_lazy(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_LAZY ? 1 : 0;
+	return (cxt->flags & MNT_FL_LAZY) ? 1 : 0;
 }
 
 /**
@@ -420,7 +420,7 @@ int mnt_context_enable_fork(struct libmnt_context *cxt, int enable)
  */
 int mnt_context_is_fork(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_FORK ? 1 : 0;
+	return (cxt->flags & MNT_FL_FORK) ? 1 : 0;
 }
 
 /**
@@ -474,7 +474,7 @@ int mnt_context_enable_rdonly_umount(struct libmnt_context *cxt, int enable)
  */
 int mnt_context_is_rdonly_umount(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_RDONLY_UMOUNT ? 1 : 0;
+	return (cxt->flags & MNT_FL_RDONLY_UMOUNT) ? 1 : 0;
 }
 
 /**
@@ -499,7 +499,7 @@ int mnt_context_disable_helpers(struct libmnt_context *cxt, int disable)
  */
 int mnt_context_is_nohelpers(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_NOHELPERS ? 1 : 0;
+	return (cxt->flags & MNT_FL_NOHELPERS) ? 1 : 0;
 }
 
 
@@ -525,7 +525,7 @@ int mnt_context_enable_sloppy(struct libmnt_context *cxt, int enable)
  */
 int mnt_context_is_sloppy(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_SLOPPY ? 1 : 0;
+	return (cxt->flags & MNT_FL_SLOPPY) ? 1 : 0;
 }
 
 /**
@@ -550,7 +550,7 @@ int mnt_context_enable_fake(struct libmnt_context *cxt, int enable)
  */
 int mnt_context_is_fake(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_FAKE ? 1 : 0;
+	return (cxt->flags & MNT_FL_FAKE) ? 1 : 0;
 }
 
 /**
@@ -575,7 +575,7 @@ int mnt_context_disable_mtab(struct libmnt_context *cxt, int disable)
  */
 int mnt_context_is_nomtab(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_NOMTAB ? 1 : 0;
+	return (cxt->flags & MNT_FL_NOMTAB) ? 1 : 0;
 }
 
 /**
@@ -601,7 +601,7 @@ int mnt_context_disable_swapmatch(struct libmnt_context *cxt, int disable)
  */
 int mnt_context_is_swapmatch(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_NOSWAPMATCH ? 0 : 1;
+	return (cxt->flags & MNT_FL_NOSWAPMATCH) ? 0 : 1;
 }
 
 /**
@@ -626,7 +626,7 @@ int mnt_context_enable_force(struct libmnt_context *cxt, int enable)
  */
 int mnt_context_is_force(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_FORCE ? 1 : 0;
+	return (cxt->flags & MNT_FL_FORCE) ? 1 : 0;
 }
 
 /**
@@ -651,7 +651,7 @@ int mnt_context_enable_verbose(struct libmnt_context *cxt, int enable)
  */
 int mnt_context_is_verbose(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_VERBOSE ? 1 : 0;
+	return (cxt->flags & MNT_FL_VERBOSE) ? 1 : 0;
 }
 
 /**
@@ -676,7 +676,7 @@ int mnt_context_enable_loopdel(struct libmnt_context *cxt, int enable)
  */
 int mnt_context_is_loopdel(struct libmnt_context *cxt)
 {
-	return cxt->flags & MNT_FL_LOOPDEL ? 1 : 0;
+	return (cxt->flags & MNT_FL_LOOPDEL) ? 1 : 0;
 }
 
 /**
@@ -2027,13 +2027,13 @@ int mnt_context_apply_fstab(struct libmnt_context *cxt)
 
 	DBG(CXT, ul_debugobj(cxt, "OPTSMODE: ignore=%d, append=%d, prepend=%d, "
 				  "replace=%d, force=%d, fstab=%d, mtab=%d",
-				  cxt->optsmode & MNT_OMODE_IGNORE ? 1 : 0,
-				  cxt->optsmode & MNT_OMODE_APPEND ? 1 : 0,
-				  cxt->optsmode & MNT_OMODE_PREPEND ? 1 : 0,
-				  cxt->optsmode & MNT_OMODE_REPLACE ? 1 : 0,
-				  cxt->optsmode & MNT_OMODE_FORCE ? 1 : 0,
-				  cxt->optsmode & MNT_OMODE_FSTAB ? 1 : 0,
-				  cxt->optsmode & MNT_OMODE_MTAB ? 1 : 0));
+				  (cxt->optsmode & MNT_OMODE_IGNORE) ? 1 : 0,
+				  (cxt->optsmode & MNT_OMODE_APPEND) ? 1 : 0,
+				  (cxt->optsmode & MNT_OMODE_PREPEND) ? 1 : 0,
+				  (cxt->optsmode & MNT_OMODE_REPLACE) ? 1 : 0,
+				  (cxt->optsmode & MNT_OMODE_FORCE) ? 1 : 0,
+				  (cxt->optsmode & MNT_OMODE_FSTAB) ? 1 : 0,
+				  (cxt->optsmode & MNT_OMODE_MTAB) ? 1 : 0));
 
 	/* fstab is not required if source and target are specified */
 	if (src && tgt && !(cxt->optsmode & MNT_OMODE_FORCE)) {
diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 6368e9ba8..947a7f9b2 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -676,7 +676,7 @@ static int do_mount_additional(struct libmnt_context *cxt,
 
 		DBG(CXT, ul_debugobj(cxt, "mount(2) changing flag: 0x%08lx %s",
 				ad->mountflags,
-				ad->mountflags & MS_REC ? " (recursive)" : ""));
+				(ad->mountflags & MS_REC) ? " (recursive)" : ""));
 
 		rc = mount("none", target, NULL,
 				ad->mountflags | (flags & MS_SILENT), NULL);
diff --git a/libsmartcols/src/column.c b/libsmartcols/src/column.c
index 1d3287960..76400743e 100644
--- a/libsmartcols/src/column.c
+++ b/libsmartcols/src/column.c
@@ -427,7 +427,7 @@ size_t scols_column_get_width(const struct libscols_column *cl)
  */
 int scols_column_is_hidden(const struct libscols_column *cl)
 {
-	return cl->flags & SCOLS_FL_HIDDEN ? 1 : 0;
+	return (cl->flags & SCOLS_FL_HIDDEN) ? 1 : 0;
 }
 
 /**
@@ -440,7 +440,7 @@ int scols_column_is_hidden(const struct libscols_column *cl)
  */
 int scols_column_is_trunc(const struct libscols_column *cl)
 {
-	return cl->flags & SCOLS_FL_TRUNC ? 1 : 0;
+	return (cl->flags & SCOLS_FL_TRUNC) ? 1 : 0;
 }
 /**
  * scols_column_is_tree:
@@ -452,7 +452,7 @@ int scols_column_is_trunc(const struct libscols_column *cl)
  */
 int scols_column_is_tree(const struct libscols_column *cl)
 {
-	return cl->flags & SCOLS_FL_TREE ? 1 : 0;
+	return (cl->flags & SCOLS_FL_TREE) ? 1 : 0;
 }
 /**
  * scols_column_is_right:
@@ -464,7 +464,7 @@ int scols_column_is_tree(const struct libscols_column *cl)
  */
 int scols_column_is_right(const struct libscols_column *cl)
 {
-	return cl->flags & SCOLS_FL_RIGHT ? 1 : 0;
+	return (cl->flags & SCOLS_FL_RIGHT) ? 1 : 0;
 }
 /**
  * scols_column_is_strict_width:
@@ -476,7 +476,7 @@ int scols_column_is_right(const struct libscols_column *cl)
  */
 int scols_column_is_strict_width(const struct libscols_column *cl)
 {
-	return cl->flags & SCOLS_FL_STRICTWIDTH ? 1 : 0;
+	return (cl->flags & SCOLS_FL_STRICTWIDTH) ? 1 : 0;
 }
 /**
  * scols_column_is_noextremes:
@@ -488,7 +488,7 @@ int scols_column_is_strict_width(const struct libscols_column *cl)
  */
 int scols_column_is_noextremes(const struct libscols_column *cl)
 {
-	return cl->flags & SCOLS_FL_NOEXTREMES ? 1 : 0;
+	return (cl->flags & SCOLS_FL_NOEXTREMES) ? 1 : 0;
 }
 /**
  * scols_column_is_wrap:
@@ -502,7 +502,7 @@ int scols_column_is_noextremes(const struct libscols_column *cl)
  */
 int scols_column_is_wrap(const struct libscols_column *cl)
 {
-	return cl->flags & SCOLS_FL_WRAP ? 1 : 0;
+	return (cl->flags & SCOLS_FL_WRAP) ? 1 : 0;
 }
 /**
  * scols_column_is_customwrap:
diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 2377a0063..5a439b733 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -972,13 +972,13 @@ static void dbg_column(struct libscols_table *tb, struct libscols_column *cl)
 				 "extreme=%s %s",
 
 		cl->header.data, cl->seqnum, cl->width,
-		cl->width_hint > 1 ? (int) cl->width_hint :
-				     (int) (cl->width_hint * tb->termwidth),
+		(cl->width_hint > 1) ? (int) cl->width_hint :
+				       (int) (cl->width_hint * tb->termwidth),
 		cl->width_avg,
 		cl->width_max,
 		cl->width_min,
 		cl->is_extreme ? "yes" : "not",
-		cl->flags & SCOLS_FL_TRUNC ? "trunc" : ""));
+		(cl->flags & SCOLS_FL_TRUNC) ? "trunc" : ""));
 }
 
 static void dbg_columns(struct libscols_table *tb)
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index d83dca92c..b89783cab 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -911,7 +911,7 @@ static int tab_is_kernel(struct libmnt_table *tb)
 static int match_func(struct libmnt_fs *fs,
 		      void *data __attribute__ ((__unused__)))
 {
-	int rc = flags & FL_INVERT ? 1 : 0;
+	int rc = (flags & FL_INVERT) ? 1 : 0;
 	const char *m;
 	void *md;
 
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index b5b35f5f5..ddbd90f03 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -445,9 +445,9 @@ static void lookup(const char *pattern, struct wh_dirlist *ls, int want)
 
 	DBG(SEARCH, ul_debug("lookup dirs for '%s' (%s), want: %s %s %s",
 				patbuf, pattern,
-				want & BIN_DIR ? "bin" : "",
-				want & MAN_DIR ? "min" : "",
-				want & SRC_DIR ? "src" : ""));
+				(want & BIN_DIR) ? "bin" : "",
+				(want & MAN_DIR) ? "min" : "",
+				(want & SRC_DIR) ? "src" : ""));
 	p = strrchr(patbuf, '.');
 	if (p)
 		*p = '\0';
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 3c4e5df0e..d79fbe796 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -339,8 +339,8 @@ static void do_shm (char format, int unit)
 
 			printf (" %-10ju %-6s %-6s\n",
 				shmdsp->shm_nattch,
-				shmdsp->shm_perm.mode & SHM_DEST ? _("dest") : " ",
-				shmdsp->shm_perm.mode & SHM_LOCKED ? _("locked") : " ");
+				(shmdsp->shm_perm.mode & SHM_DEST) ? _("dest") : " ",
+				(shmdsp->shm_perm.mode & SHM_LOCKED) ? _("locked") : " ");
 			break;
 		}
 	}
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 441b7abf9..e4afb014e 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -227,10 +227,10 @@ static void add_flag_line(struct libscols_table *table, struct wdinfo *wd, const
 			str = fl->description;
 			break;
 		case COL_STATUS:
-			str = wd->status & fl->flag ? "1" : "0";
+			str = (wd->status & fl->flag) ? "1" : "0";
 			break;
 		case COL_BSTATUS:
-			str = wd->bstatus & fl->flag ? "1" : "0";
+			str = (wd->bstatus & fl->flag) ? "1" : "0";
 			break;
 		case COL_DEVICE:
 			str = wd->device;
@@ -448,9 +448,9 @@ static void print_oneline(struct wdinfo *wd, uint32_t wanted,
 			fl= &wdflags[i];
 
 			printf(" %s=\"%s\"", fl->name,
-					     wd->status & fl->flag ? "1" : "0");
+					     (wd->status & fl->flag) ? "1" : "0");
 			printf(" %s_BOOT=\"%s\"", fl->name,
-					     wd->bstatus & fl->flag ? "1" : "0");
+					     (wd->bstatus & fl->flag) ? "1" : "0");
 
 		}
 	}
diff --git a/term-utils/script.c b/term-utils/script.c
index f2fc2f59c..dec6b9e92 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -471,13 +471,13 @@ static void do_io(struct script_control *ctl)
 				continue;
 
 			DBG(POLL, ul_debug(" active pfd[%s].fd=%d %s %s %s",
-						i == POLLFD_STDIN  ? "stdin" :
-						i == POLLFD_MASTER ? "master" :
-						i == POLLFD_SIGNAL ? "signal" : "???",
+						(i == POLLFD_STDIN)  ? "stdin" :
+						(i == POLLFD_MASTER) ? "master" :
+						(i == POLLFD_SIGNAL) ? "signal" : "???",
 						pfd[i].fd,
-						pfd[i].revents & POLLIN  ? "POLLIN" : "",
-						pfd[i].revents & POLLHUP ? "POLLHUP" : "",
-						pfd[i].revents & POLLERR ? "POLLERR" : ""));
+						(pfd[i].revents & POLLIN)  ? "POLLIN" : "",
+						(pfd[i].revents & POLLHUP) ? "POLLHUP" : "",
+						(pfd[i].revents & POLLERR) ? "POLLERR" : ""));
 			switch (i) {
 			case POLLFD_STDIN:
 			case POLLFD_MASTER:
-- 
2.12.2

