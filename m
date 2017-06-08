Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36437 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdFHTwh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id e23so4713528wre.3
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/11] misc: remove stray semicolons
Date: Thu,  8 Jun 2017 20:52:13 +0100
Message-Id: <20170608195215.1702-10-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/mbsalign.c                          | 2 +-
 libblkid/src/superblocks/adaptec_raid.c | 2 +-
 libmount/src/btrfs.c                    | 4 ++--
 libmount/src/context_mount.c            | 2 +-
 libmount/src/context_umount.c           | 2 +-
 libsmartcols/src/column.c               | 2 +-
 misc-utils/test_uuidd.c                 | 2 +-
 sys-utils/unshare.c                     | 2 +-
 term-utils/wall.c                       | 2 +-
 text-utils/column.c                     | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/mbsalign.c b/lib/mbsalign.c
index 731320b07..b0e1004a0 100644
--- a/lib/mbsalign.c
+++ b/lib/mbsalign.c
@@ -206,7 +206,7 @@ size_t mbs_safe_encode_size(size_t bytes)
 char *mbs_safe_encode(const char *s, size_t *width)
 {
 	size_t sz = s ? strlen(s) : 0;
-	char *buf, *ret = NULL;;
+	char *buf, *ret = NULL;
 
 	if (!sz)
 		return NULL;
diff --git a/libblkid/src/superblocks/adaptec_raid.c b/libblkid/src/superblocks/adaptec_raid.c
index 65fd5b8b4..5fc5fc4bc 100644
--- a/libblkid/src/superblocks/adaptec_raid.c
+++ b/libblkid/src/superblocks/adaptec_raid.c
@@ -91,7 +91,7 @@ static int probe_adraid(blkid_probe pr,
 					off,
 					sizeof(struct adaptec_metadata));
 	if (!ad)
-		return errno ? -errno : BLKID_PROBE_NONE;;
+		return errno ? -errno : BLKID_PROBE_NONE;
 
 	if (ad->smagic != be32_to_cpu(AD_SIGNATURE))
 		return BLKID_PROBE_NONE;
diff --git a/libmount/src/btrfs.c b/libmount/src/btrfs.c
index 0b09053bb..1669c2722 100644
--- a/libmount/src/btrfs.c
+++ b/libmount/src/btrfs.c
@@ -75,9 +75,9 @@ static inline void btrfs_set_##name(type *s, uint##bits##_t val)	\
 
 /* struct btrfs_disk_key */
 BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key,
-			 objectid, 64);
+			 objectid, 64)
 
-BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item, name_len, 16);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item, name_len, 16)
 
 /*
   Red Black Trees
diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 9caee70e5..2c5334217 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -1042,7 +1042,7 @@ int mnt_context_finalize_mount(struct libmnt_context *cxt)
 
 	rc = mnt_context_prepare_update(cxt);
 	if (!rc)
-		rc = mnt_context_update_tabs(cxt);;
+		rc = mnt_context_update_tabs(cxt);
 	return rc;
 }
 
diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index a97c28ba6..1548fff72 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -889,7 +889,7 @@ int mnt_context_finalize_umount(struct libmnt_context *cxt)
 
 	rc = mnt_context_prepare_update(cxt);
 	if (!rc)
-		rc = mnt_context_update_tabs(cxt);;
+		rc = mnt_context_update_tabs(cxt);
 	return rc;
 }
 
diff --git a/libsmartcols/src/column.c b/libsmartcols/src/column.c
index ce1ed7e22..ba6c31920 100644
--- a/libsmartcols/src/column.c
+++ b/libsmartcols/src/column.c
@@ -304,7 +304,7 @@ size_t scols_wrapnl_chunksize(const struct libscols_column *cl __attribute__((un
 			sz = mbs_safe_width(data);
 
 		sum = max(sum, sz);
-		data = p;;
+		data = p;
 	}
 
 	return sum;
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index 9883cbf29..26751a485 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -143,7 +143,7 @@ static void *create_uuids(thread_t *th)
 		object_uuid_create(obj);
 		obj->tid = th->tid;
 		obj->pid = th->proc->pid;
-		obj->idx = th->index + i;;
+		obj->idx = th->index + i;
 	}
 	return NULL;
 }
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 6c5c2e2f9..80fa0d356 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -308,7 +308,7 @@ int main(int argc, char *argv[])
 	int status;
 	unsigned long propagation = UNSHARE_PROPAGATION_DEFAULT;
 	uid_t real_euid = geteuid();
-	gid_t real_egid = getegid();;
+	gid_t real_egid = getegid();
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
diff --git a/term-utils/wall.c b/term-utils/wall.c
index a9dde15be..fa2ec2143 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -303,7 +303,7 @@ static void buf_printf(struct buffer *bs, const char *fmt, ...)
 		buf_enlarge(bs, (size_t)rc + 1);
 		limit = bs->sz - bs->used;
 		va_start(ap, fmt);
-		rc = vsnprintf(bs->data  + bs->used, limit, fmt, ap);;
+		rc = vsnprintf(bs->data  + bs->used, limit, fmt, ap);
 		va_end(ap);
 	}
 
diff --git a/text-utils/column.c b/text-utils/column.c
index c315f91ef..9f9eabaa8 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -482,7 +482,7 @@ static void columnate_fillrows(struct column_control *ctl)
 	ctl->maxlength = (ctl->maxlength + TABCHAR_CELLS) & ~(TABCHAR_CELLS - 1);
 	numcols = ctl->termwidth / ctl->maxlength;
 	endcol = ctl->maxlength;
-	for (chcnt = col = 0, lp = ctl->ents;; ++lp) {
+	for (chcnt = col = 0, lp = ctl->ents; /* nothing */; ++lp) {
 		fputws(*lp, stdout);
 		chcnt += width(*lp);
 		if (!--ctl->nents)
-- 
2.13.1

