Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53718 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab1KIJKx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Nov 2011 04:10:53 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9223A8A95F
	for <util-linux@vger.kernel.org>; Wed,  9 Nov 2011 10:10:52 +0100 (CET)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] libmount: fix trivial typos in debugging output
Date: Wed,  9 Nov 2011 10:10:52 +0100
Message-Id: <1320829852-31250-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 libmount/src/cache.c          |    2 +-
 libmount/src/context.c        |    2 +-
 libmount/src/context_mount.c  |    4 ++--
 libmount/src/context_umount.c |    2 +-
 libmount/src/optstr.c         |    2 +-
 libmount/src/tab_update.c     |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/libmount/src/cache.c b/libmount/src/cache.c
index 41aa4fe..cf319ca 100644
--- a/libmount/src/cache.c
+++ b/libmount/src/cache.c
@@ -681,7 +681,7 @@ int test_read_tags(struct libmnt_test *ts, int argc, char *argv[])
 
 		if (*line == '/') {
 			if (mnt_cache_read_tags(cache, line) < 0)
-				fprintf(stderr, "%s: read tags faild\n", line);
+				fprintf(stderr, "%s: read tags failed\n", line);
 
 		} else if (strchr(line, '=')) {
 			char *tag, *val;
diff --git a/libmount/src/context.c b/libmount/src/context.c
index 47d3f85..dadde5c 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -1542,7 +1542,7 @@ int mnt_context_apply_fstab(struct libmnt_context *cxt)
 
 	/* try mtab */
 	if (rc < 0 && (cxt->optsmode & MNT_OMODE_MTAB)) {
-		DBG(CXT, mnt_debug_h(cxt, "tring to apply from mtab"));
+		DBG(CXT, mnt_debug_h(cxt, "trying to apply from mtab"));
 		rc = mnt_context_get_mtab(cxt, &tab);
 		if (!rc)
 			rc = apply_table(cxt, tab, MNT_ITER_BACKWARD);
diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index bcc4cdd..7b4c0ba 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -461,7 +461,7 @@ static int do_mount_by_pattern(struct libmnt_context *cxt, const char *pattern)
 		 */
 		char *p, *p0;
 
-		DBG(CXT, mnt_debug_h(cxt, "tring mount by FS pattern list"));
+		DBG(CXT, mnt_debug_h(cxt, "trying to mount by FS pattern list"));
 
 		p0 = p = strdup(pattern);
 		if (!p)
@@ -483,7 +483,7 @@ static int do_mount_by_pattern(struct libmnt_context *cxt, const char *pattern)
 	/*
 	 * try /etc/filesystems and /proc/filesystems
 	 */
-	DBG(CXT, mnt_debug_h(cxt, "tring mount by filesystems lists"));
+	DBG(CXT, mnt_debug_h(cxt, "trying to mount by filesystems lists"));
 
 	rc = mnt_get_filesystems(&filesystems, neg ? pattern : NULL);
 	if (rc)
diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index dc417e3..3486ef5 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -508,7 +508,7 @@ static int do_umount(struct libmnt_context *cxt)
 		cxt->mountflags |= MS_REMOUNT | MS_RDONLY;
 		cxt->flags &= ~MNT_FL_LOOPDEL;
 		DBG(CXT, mnt_debug_h(cxt,
-			"umount(2) failed [errno=%d] -- tring remount read-only",
+			"umount(2) failed [errno=%d] -- trying to remount read-only",
 			-cxt->syscall_status));
 
 		rc = mount(src, mnt_fs_get_target(cxt->fs), NULL,
diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index 2a0fc27..8368384 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -652,7 +652,7 @@ int mnt_optstr_apply_flags(char **optstr, unsigned long flags,
 	if (!optstr || !map)
 		return -EINVAL;
 
-	DBG(CXT, mnt_debug("appling 0x%08lu flags '%s'", flags, *optstr));
+	DBG(CXT, mnt_debug("applying 0x%08lu flags '%s'", flags, *optstr));
 
 	maps[0] = map;
 	next = *optstr;
diff --git a/libmount/src/tab_update.c b/libmount/src/tab_update.c
index f049e42..e40868c 100644
--- a/libmount/src/tab_update.c
+++ b/libmount/src/tab_update.c
@@ -169,7 +169,7 @@ int mnt_update_set_fs(struct libmnt_update *upd, unsigned long mountflags,
 		return -EINVAL;
 
 	DBG(UPDATE, mnt_debug_h(upd,
-			"reseting FS [fs=0x%p, target=%s, flags=0x%08lx]",
+			"resetting FS [fs=0x%p, target=%s, flags=0x%08lx]",
 			fs, target, mountflags));
 	if (fs) {
 		DBG(UPDATE, mnt_debug_h(upd, "FS template:"));
-- 
1.7.7

