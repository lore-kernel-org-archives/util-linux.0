Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21273C46467
	for <util-linux@archiver.kernel.org>; Sat,  7 Jan 2023 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjAGT43 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjAGT41 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 7 Jan 2023 14:56:27 -0500
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Jan 2023 11:56:25 PST
Received: from aurora.tech (unknown [64.124.54.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 043E3C27
        for <util-linux@vger.kernel.org>; Sat,  7 Jan 2023 11:56:24 -0800 (PST)
Received: by aurora.tech (Postfix, from userid 1001)
        id D8E1E1640178; Sat,  7 Jan 2023 11:47:16 -0800 (PST)
From:   alison@she-devel.com
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, achaiken@aurora.tech, alison@she-devel.com
Subject: [PATCH 1/3] schedutils: clarify confusing mask example in taskset man page
Date:   Sat,  7 Jan 2023 11:47:06 -0800
Message-Id: <20230107194708.6878-2-alison@she-devel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230107194708.6878-1-alison@she-devel.com>
References: <20230107194708.6878-1-alison@she-devel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Alison Chaiken <alison@she-devel.com>

Omit "0x" from a mask example which is clearly hexadecimal rather than omitting
it from "32", which could be a decimal representation.
---
 schedutils/taskset.1.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
index c10cc62a2..efbab08dc 100644
--- a/schedutils/taskset.1.adoc
+++ b/schedutils/taskset.1.adoc
@@ -52,10 +52,10 @@ is processor #0,
 *0x00000003*::
 is processors #0 and #1,
 
-*0xFFFFFFFF*::
+*FFFFFFFF*::
 is processors #0 through #31,
 
-*32*::
+*0x32*::
 is processors #1, #4, and #5,
 
 *--cpu-list 0-2,6*::
-- 
2.32.0

