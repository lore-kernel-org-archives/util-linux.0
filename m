Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B5CC433E0
	for <util-linux@archiver.kernel.org>; Thu, 31 Dec 2020 04:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2920207C7
	for <util-linux@archiver.kernel.org>; Thu, 31 Dec 2020 04:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgLaEHQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Dec 2020 23:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgLaEHQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Dec 2020 23:07:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CB75207C7
        for <util-linux@vger.kernel.org>; Thu, 31 Dec 2020 04:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609387596;
        bh=h/Ac8HBpZLvOh9NI/nKFpToGZY7aGjIWgrREZrY8Wfc=;
        h=From:To:Subject:Date:From;
        b=jGWr0GGauwGlqbpWdFPAYaNPVc+CUau6ve7jwceXWp8LlYkoPVGT1o8ZXOu5Qw1+H
         nUjCXtMbVeIXllsfI1NlbHnicmvSiOgq+kgn0BM1iWyWSdTF3Qdj1+g9jfhzLRN/vo
         PSOWKbw2rktx8v0hwEe+KkZ6rnskY0U+kfoS7TQWwBDx306FRFY+bCXgKnUME7QzP4
         9wbHE3JZ3G5heL/PCYFf3w/DHDd4YJItdwyct+XqMfBVJ3/pbJhmwqD6HIgIQKaMHf
         gCqZx7kxQDtZ7U37jB3siMJ121ZJWVM8QKXKNW9kaYH05z5hs3JTXefkr3EcfmQ7x4
         DybdgCdlVCrKg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH] sys-utils: mount.8: fix a typo
Date:   Wed, 30 Dec 2020 20:05:57 -0800
Message-Id: <20201231040557.324825-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

It should be "inode", not "i-node".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 sys-utils/mount.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 282a9cbbe..e33689b15 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1300,7 +1300,7 @@ or
 .IP -
 an undeleted inode is evicted from memory
 .IP -
-more than 24 hours have passed since the i-node was written to disk.
+more than 24 hours have passed since the inode was written to disk.
 .RE
 .sp
 .TP
-- 
2.29.2

