Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B1DC433F5
	for <util-linux@archiver.kernel.org>; Fri,  1 Oct 2021 12:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6599B6136A
	for <util-linux@archiver.kernel.org>; Fri,  1 Oct 2021 12:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354362AbhJAM1j (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354361AbhJAM1j (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 1 Oct 2021 08:27:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5BDE61A55;
        Fri,  1 Oct 2021 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633091155;
        bh=MoRMhRCh7dfJ3jDCeszg8H3xt/AaxrIaS9POgxyndNM=;
        h=From:To:Cc:Subject:Date:From;
        b=PfwezK4rFJehXOOQv2x5mraHEPS79bcf/S4+on48ctVU3HhBn5KTrIlUklVxeHog9
         g8ui1cyw1BiMMyUN7lVvG70goNulapwZfxgrj7U/FcF7Nee5QTwOSPEEnWJ+ZIUrkO
         Wl+2XdlNZXVSlsduaBOI2/m0zWZEdCFfJEMKejkoD6JSPmoVDq/01zBUV0WBu3/9Oy
         ropL2jcNTW0N4Lrixc1O1/woO7oTx0h/Rrq2uWLyO1sWsmQVMqomXX3djecph+0VJR
         gugoMf/kjo8G+MF2BCuUYLkHwtt7Jzin7nmNWhZ6CZmGVg35FS9D+ZHkAPB1ONQwAR
         FuPt+OajZUCWQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     util-linux@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH] mount.8.adoc: note that mandatory locking is fully deprecated in Linux 5.15
Date:   Fri,  1 Oct 2021 08:25:53 -0400
Message-Id: <20211001122553.18345-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 sys-utils/mount.8.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index de97fd568c1a..5cd548caa131 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -525,7 +525,7 @@ Every time the inode is modified, the i_version field will be incremented.
 Do not increment the i_version inode field.
 
 *mand*::
-Allow mandatory locks on this filesystem. See *fcntl*(2).
+Allow mandatory locks on this filesystem. See *fcntl*(2). This option was deprecated in Linux 5.15.
 
 *nomand*::
 Do not allow mandatory locks on this filesystem.
-- 
2.31.1

