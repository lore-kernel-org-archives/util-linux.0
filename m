Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D141C433F5
	for <util-linux@archiver.kernel.org>; Mon, 27 Sep 2021 07:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D6260F94
	for <util-linux@archiver.kernel.org>; Mon, 27 Sep 2021 07:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhI0HJx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Sep 2021 03:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhI0HJx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Sep 2021 03:09:53 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 00:08:15 PDT
Received: from mail.namespace.at (mail.namespace.at [IPv6:2a01:190:1801:100::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD518C061570
        for <util-linux@vger.kernel.org>; Mon, 27 Sep 2021 00:08:15 -0700 (PDT)
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Cc:     Eduard Bloch <blade@debian.org>
Subject: [PATCH] Use more passive wording in hardlink.1
Date:   Mon, 27 Sep 2021 09:08:12 +0200
Message-Id: <20210927070812.77020-1-zeha@debian.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Eduard Bloch <blade@debian.org>

And fix "same (basename)".

Signed-off-by: Eduard Bloch <blade@debian.org>
---
 misc-utils/hardlink.1.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index 1fab77d71..f0814da5f 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -39,16 +39,16 @@ Quiet mode, don't print anything.
 Do not act, just print what would happen.
 
 *-f*, *--respect-name*::
-Only try to link files with the same (basename). It's strongly recommended to use long options rather than *-f* which is interpreted in a different way by others *hardlink* implementations.
+Only try to link files with the same (base)name. It's strongly recommended to use long options rather than *-f* which is interpreted in a different way by other *hardlink* implementations.
 
 *-p*, *--ignore-mode*::
-Link/compare files even if their mode is different. This may be a bit unpredictable.
+Link and compare files even if their mode is different. Results may be slightly unpredictable.
 
 *-o*, *--ignore-owner*::
-Link/compare files even if their owner (user and group) is different. It is not predictable.
+Link and compare files even if their owner information (user and group) differs. Results may be unpredictable.
 
 *-t*, *--ignore-time*::
-Link/compare files even if their time of modification is different. You almost always want this.
+Link and compare files even if their time of modification is different. This is usually a good choice.
 
 *-X*, *--respect-xattrs*::
 Only try to link files with the same extended attributes.
-- 
2.33.0

