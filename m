Received: from sosiego.soundray.org (sosiego.soundray.org [116.203.207.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19847A7A
	for <util-linux@vger.kernel.org>; Thu, 30 May 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.207.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092787; cv=none; b=WVYHMLs3yJ/jX2Sx0opDRrkWxln1SobfLiSf7C+1+sLpIBGv+1HBroJI20tU8gEQOWFpBqp0rDxLFHM+6+eZbgoJM9EsT38rPf2FiCdthKpJq99A/+69//5Xy97J+ztSb0/ozwytHPLjTxCKIquGX2wWxjIsn5igzntI+9LOhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092787; c=relaxed/simple;
	bh=Y/i7jW6p+y1HYp4etZgADc5y+s/Kqi9mcYmLFlp4KXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKAvUNMpIlxDSgtg7KrXfxn/k8s0UdLo3X115dF9dnO0eLO9ThlKqzcZ8IsMItoe1/Cs39o8aQePu9h+mCIPUSvBYt3g+2cj1CSyM5tAuZQbqL8Ellf4aEJw262rtN3vtzVNELYrc0UrOGMNHDBBm7yt5CJYX0CIShQX3Ahxs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org; spf=pass smtp.mailfrom=sphalerite.org; dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b=IED4z6Lq; arc=none smtp.client-ip=116.203.207.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sphalerite.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b="IED4z6Lq"
From: Linus Heckemann <git@sphalerite.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sphalerite.org;
	s=sosiego; t=1717092268;
	bh=zqucAzL8QWkfJBkyQa5Z07RzzwYoXimyhiiloU7DNs4=;
	h=From:To:Cc:Subject:Date;
	b=IED4z6LqbGp42OBNMLMcXC9pNX+Bx7az9D5mMFuBv6twoBQa8f3D1qRsKL551Km4J
	 7f5rlb0VBBwTxqsuaD1jKboLDG40rsyHDKP6w8jC5S1Sn/TmCDF1QsVN3IH3F8qfym
	 s20meijC2zj7AXNyvuAIK9B1nIsFgd7icWLtva5o=
To: util-linux@vger.kernel.org
Cc: Linus Heckemann <git@sphalerite.org>
Subject: [PATCH] libmount: provide tree fd even when a mount helper is used
Date: Thu, 30 May 2024 20:00:34 +0200
Message-ID: <20240530180041.3447273-1-git@sphalerite.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the X-mount.subdir option would fail (mount exited with
code 0, but the target was not mounted) when a helper was used.

In addition to fixing X-mount.subdir, this allows dropping the
fallback behaviour previously implemented specifically by the
set_vfsflags and set_propagation hooks.

I realise this patch is not acceptable as is, since I just exported
the previously private open_mount_tree symbol from hook_mount.c
without even adding it to a header (so builds with sensible warning
configurations, with -Werror=implicit-function-declaration, won't even
compile this); but I'm submitting this as is in hopes that someone who
knows their way around libmount will suggest a sensible way to shuffle
the code around.
---
 libmount/src/context_mount.c | 15 ++++++++++++++-
 libmount/src/hook_mount.c    | 20 +-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 676287733..ef66f47af 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -482,8 +482,21 @@ static int exec_helper(struct libmnt_context *cxt)
 			DBG(CXT, ul_debugobj(cxt, "%s forked [status=%d, rc=%d]",
 				cxt->helper,
 				cxt->helper_status, rc));
+
+			struct libmnt_sysapi *api = mnt_context_get_sysapi(cxt);
+			assert(api);
+
+			/* a mount helper, unlike an internal mount, won't provide the mount fd.
+			 * This is, however, needed by hooks like subdir -- so let's open the tree
+			 * that was mounted by our helper child. */
+			if (api->fd_tree < 0 && mnt_fs_get_target(cxt->fs)) {
+				api->fd_tree = open_mount_tree(cxt, NULL, (unsigned long) -1);
+				if (api->fd_tree > 0) {
+					rc = 0;
+				}
+			}
+			break;
 		}
-		break;
 	}
 
 	case -1:
diff --git a/libmount/src/hook_mount.c b/libmount/src/hook_mount.c
index 6b7caff85..b80fe4839 100644
--- a/libmount/src/hook_mount.c
+++ b/libmount/src/hook_mount.c
@@ -255,7 +255,7 @@ static int open_fs_configuration_context(struct libmnt_context *cxt,
 	return api->fd_fs;
 }
 
-static int open_mount_tree(struct libmnt_context *cxt, const char *path, unsigned long mflg)
+int open_mount_tree(struct libmnt_context *cxt, const char *path, unsigned long mflg)
 {
 	unsigned long oflg = OPEN_TREE_CLOEXEC;
 	int rc = 0, fd = -1;
@@ -416,15 +416,6 @@ static int set_vfsflags(struct libmnt_context *cxt,
 	api = get_sysapi(cxt);
 	assert(api);
 
-	/* fallback only; necessary when init_sysapi() during preparation
-	 * cannot open the tree -- for example when we call /sbin/mount.<type> */
-	if (api->fd_tree < 0 && mnt_fs_get_target(cxt->fs)) {
-		rc = api->fd_tree = open_mount_tree(cxt, NULL, (unsigned long) -1);
-		if (rc < 0)
-			return rc;
-		rc = 0;
-	}
-
 	if (recursive)
 		callflags |= AT_RECURSIVE;
 
@@ -494,15 +485,6 @@ static int hook_set_propagation(struct libmnt_context *cxt,
 	api = get_sysapi(cxt);
 	assert(api);
 
-	/* fallback only; necessary when init_sysapi() during preparation
-	 * cannot open the tree -- for example when we call /sbin/mount.<type> */
-	if (api->fd_tree < 0 && mnt_fs_get_target(cxt->fs)) {
-		rc = api->fd_tree = open_mount_tree(cxt, NULL, (unsigned long) -1);
-		if (rc < 0)
-			goto done;
-		rc = 0;
-	}
-
 	mnt_reset_iter(&itr, MNT_ITER_FORWARD);
 
 	while (mnt_optlist_next_opt(ol, &itr, &opt) == 0) {
-- 
2.42.0

