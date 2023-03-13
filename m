Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D89C6FD1F
	for <util-linux@archiver.kernel.org>; Mon, 13 Mar 2023 01:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCMBuH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 12 Mar 2023 21:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCMBuG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Mar 2023 21:50:06 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C9298D4
        for <util-linux@vger.kernel.org>; Sun, 12 Mar 2023 18:50:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 3ABAD100377
        for <util-linux@vger.kernel.org>; Mon, 13 Mar 2023 12:42:58 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cGCbdEBnd8pH for <util-linux@vger.kernel.org>;
        Mon, 13 Mar 2023 12:42:58 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 2AEB8100381; Mon, 13 Mar 2023 12:42:58 +1100 (AEDT)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 41331100330;
        Mon, 13 Mar 2023 12:42:56 +1100 (AEDT)
Subject: [PATCH 1/2] libmount: dont ignore autofs mounts by default
From:   Ian Kent <raven@themaw.net>
To:     util-linux <util-linux@vger.kernel.org>
Cc:     fhirtz@redhat.com, John Westerdale <jwesterd@redhat.com>,
        Frank Sorenson <fsorenso@redhat.com>
Date:   Mon, 13 Mar 2023 09:42:56 +0800
Message-ID: <167867177635.35511.15003989525678735907.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Making libmount ingore autofs mounts by default can be a problem for
systemd, I remember now what the problem was.

autofs multi-mounts can be nested (and often are, think of a tree of
NFS exports) where there are autofs file system mounts within NFS
mounts and together with autofs mount triggers.

In this case systemd needs to see all the mounts at shutdown when it
is umounting the tree of mounts. We don't want to have to rely on
modifications having been made to systemd for this to work properly
so we can't make this the default behaviour in libmount.

Fixes: 22147e08c987 (libmount: use autofs mount hint to ignore autofs mount entries)
Signed-off-by: Ian Kent <raven@themaw.net>
Cc: John Westerdale <jwesterd@redhat.com>
Cc: Frank Hertz <fhirtz@redhat.com>
Cc: Frank Sorenson <fsorenso@redhat.com>
---
 libmount/src/context.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmount/src/context.c b/libmount/src/context.c
index 8db6b6950..2df4716a7 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -75,7 +75,7 @@ struct libmnt_context *mnt_new_context(void)
 	/* if we're really root and aren't running setuid */
 	cxt->restricted = (uid_t) 0 == ruid && ruid == euid ? 0 : 1;
 
-	cxt->noautofs = 1;
+	cxt->noautofs = 0;
 
 	DBG(CXT, ul_debugobj(cxt, "----> allocate %s",
 				cxt->restricted ? "[RESTRICTED]" : ""));
@@ -164,7 +164,7 @@ int mnt_reset_context(struct libmnt_context *cxt)
 	cxt->helper = NULL;
 	cxt->mountdata = NULL;
 	cxt->flags = MNT_FL_DEFAULT;
-	cxt->noautofs = 1;
+	cxt->noautofs = 0;
 	cxt->has_selinux_opt = 0;
 
 	cxt->map_linux = mnt_get_builtin_optmap(MNT_LINUX_MAP);


