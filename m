Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BFCC2FC0E
	for <util-linux@archiver.kernel.org>; Thu, 17 Aug 2023 09:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349470AbjHQJVf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjHQJVF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 17 Aug 2023 05:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00682210E
        for <util-linux@vger.kernel.org>; Thu, 17 Aug 2023 02:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 772E965DE4
        for <util-linux@vger.kernel.org>; Thu, 17 Aug 2023 09:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C338C433C7;
        Thu, 17 Aug 2023 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692264059;
        bh=KoROJKnnxVkXSGOVaLRxYe7u9eb8/YgDlKZv5Da4sTA=;
        h=From:To:Cc:Subject:Date:From;
        b=TM3M3nS3LOi2Fgyxw35bC8/dBOt/tYgrmQvcgOVr8EJtgVxUifdqzelm9gtSeXWci
         ROC9KaqHB6Ud8WGiPs4zq9SnTe6nR48r3JnEpIWwNRbjlWUIrp1GMVZIgumWtbyb6/
         KUAJd2Dmw8dQUhFshO85VS+crLb1pjKaOw8I6KvmVq41FDOnc9OQDaUJdeVLS9VA3T
         Ounnq2QhQIMoHyg1sHYrnAIS/jl0J57VWGREHmTQ6Szzw0ysEZ7juCs3d07C3B2eYc
         Fn6AB6WCIk04phnS3sliZorbqPyyOLk1drjekj4BGhs25SkdsTd0BloU0kp62P7+kD
         W2+RcMluJVyfg==
From:   fdmanana@kernel.org
To:     util-linux@vger.kernel.org
Cc:     Filipe Manana <fdmanana@kernel.org>
Subject: [PATCH] libmount: Fix regression when mounting with atime
Date:   Thu, 17 Aug 2023 10:20:13 +0100
Message-Id: <aeef1a885d791881a6cf0e61e405f5490f060701.1692264006.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Filipe Manana <fdmanana@kernel.org>

A regression was introduced in v2.39 that causes mounting with the atime
option to fail:

  $ mkfs.ext4 -F /dev/sdi
  $ mount -o atime /dev/sdi /mnt/sdi
  mount: /mnt/sdi: not mount point or bad option.
         dmesg(1) may have more information after failed mount system call.

The failure comes from the mount_setattr(2) call returning -EINVAL. This
is because we pass an invalid value for the attr_clr argument. From a
strace capture we have:

  mount_setattr(4, "", AT_EMPTY_PATH, {attr_set=0, attr_clr=MOUNT_ATTR_NOATIME, propagation=0 /* MS_??? */, userns_fd=0}, 32) = -1 EINVAL (Invalid argument)

We can't pass MOUNT_ATTR_NOATIME to mount_setattr(2) through the attr_clr
argument because all atime options are exclusive, so in order to set atime
one has to pass MOUNT_ATTR__ATIME to attr_clr and leave attr_set as
MOUNT_ATTR_RELATIME (which is defined as a value of 0).

This can be read from the man page for mount_setattr(2) and also from the
kernel source:

  $ cat fs/namespace.c
  static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
                               struct mount_kattr *kattr, unsigned int flags)
  {
      (...)
      /*
       * Since the MOUNT_ATTR_<atime> values are an enum, not a bitmap,
       * users wanting to transition to a different atime setting cannot
       * simply specify the atime setting in @attr_set, but must also
       * specify MOUNT_ATTR__ATIME in the @attr_clr field.
       * So ensure that MOUNT_ATTR__ATIME can't be partially set in
       * @attr_clr and that @attr_set can't have any atime bits set if
       * MOUNT_ATTR__ATIME isn't set in @attr_clr.
       */
      if (attr->attr_clr & MOUNT_ATTR__ATIME) {
          if ((attr->attr_clr & MOUNT_ATTR__ATIME) != MOUNT_ATTR__ATIME)
              return -EINVAL;

              /*
               * Clear all previous time settings as they are mutually
               * exclusive.
               */
              kattr->attr_clr |= MNT_RELATIME | MNT_NOATIME;
              switch (attr->attr_set & MOUNT_ATTR__ATIME) {
              case MOUNT_ATTR_RELATIME:
                  kattr->attr_set |= MNT_RELATIME;
                  break;
              case MOUNT_ATTR_NOATIME:
                  kattr->attr_set |= MNT_NOATIME;
                  break;
              case MOUNT_ATTR_STRICTATIME:
                  break;
              default:
                  return -EINVAL;
              }
    (...)

So fix this by setting attr_clr MOUNT_ATTR__ATIME if we want to clear any
atime related option.

Signed-off-by: Filipe Manana <fdmanana@kernel.org>
---
 libmount/src/optlist.c                      | 13 ++++++++++++-
 tests/expected/libmount/context-mount-flags |  3 +++
 tests/ts/libmount/context                   |  9 ++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/libmount/src/optlist.c b/libmount/src/optlist.c
index e93810b47..d0afc94f7 100644
--- a/libmount/src/optlist.c
+++ b/libmount/src/optlist.c
@@ -875,7 +875,18 @@ int mnt_optlist_get_attrs(struct libmnt_optlist *ls, uint64_t *set, uint64_t *cl
 
 		if (opt->ent->mask & MNT_INVERT) {
 			DBG(OPTLIST, ul_debugobj(ls, " clr: %s", opt->ent->name));
-			*clr |= x;
+			/*
+			 * All atime settings are mutually exclusive so *clr must
+			 * have MOUNT_ATTR__ATIME set.
+			 *
+			 * See the function fs/namespace.c:build_mount_kattr()
+			 * in the linux kernel source.
+			 */
+			if (x == MOUNT_ATTR_RELATIME || x == MOUNT_ATTR_NOATIME ||
+			    x == MOUNT_ATTR_STRICTATIME)
+				*clr |= MOUNT_ATTR__ATIME;
+			else
+				*clr |= x;
 		} else {
 			DBG(OPTLIST, ul_debugobj(ls, " set: %s", opt->ent->name));
 			*set |= x;
diff --git a/tests/expected/libmount/context-mount-flags b/tests/expected/libmount/context-mount-flags
index 960641863..eb71323dd 100644
--- a/tests/expected/libmount/context-mount-flags
+++ b/tests/expected/libmount/context-mount-flags
@@ -3,3 +3,6 @@ ro,nosuid,noexec
 successfully mounted
 rw,nosuid,noexec
 successfully umounted
+successfully mounted
+rw,relatime
+successfully umounted
diff --git a/tests/ts/libmount/context b/tests/ts/libmount/context
index f5b47185e..a5d2e81a3 100755
--- a/tests/ts/libmount/context
+++ b/tests/ts/libmount/context
@@ -116,8 +116,15 @@ $TS_CMD_FINDMNT --kernel --mountpoint $MOUNTPOINT -o VFS-OPTIONS -n >> $TS_OUTPU
 
 ts_run $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>> $TS_ERRLOG
 is_mounted $DEVICE && echo "$DEVICE still mounted" >> $TS_OUTPUT 2>> $TS_ERRLOG
-ts_finalize_subtest
 
+# Test that the atime option works after the migration to use the new kernel mount APIs.
+ts_run $TESTPROG --mount -o atime $DEVICE $MOUNTPOINT >> $TS_OUTPUT 2>> $TS_ERRLOG
+$TS_CMD_FINDMNT --kernel --mountpoint $MOUNTPOINT -o VFS-OPTIONS -n >> $TS_OUTPUT 2>> $TS_ERRLOG
+is_mounted $DEVICE || echo "$DEVICE not mounted" >> $TS_OUTPUT 2>> $TS_ERRLOG
+ts_run $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>> $TS_ERRLOG
+is_mounted $DEVICE && echo "$DEVICE still mounted" >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+ts_finalize_subtest
 
 ts_init_subtest "mount-loopdev"
 mkdir -p $MOUNTPOINT &> /dev/null
-- 
2.40.1

