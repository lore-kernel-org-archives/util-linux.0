Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF7FC3DA7A
	for <util-linux@archiver.kernel.org>; Sun, 25 Dec 2022 16:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiLYQ7x (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 25 Dec 2022 11:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiLYQ7w (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 25 Dec 2022 11:59:52 -0500
X-Greylist: delayed 1510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Dec 2022 08:59:50 PST
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87C6426CC
        for <util-linux@vger.kernel.org>; Sun, 25 Dec 2022 08:59:50 -0800 (PST)
Received: from chris by delta.arachsys.com with local (Exim 4.80)
        (envelope-from <chris@arachsys.com>)
        id 1p9TxN-0008Ve-LV
        for util-linux@vger.kernel.org; Sun, 25 Dec 2022 16:34:37 +0000
Date:   Sun, 25 Dec 2022 16:34:37 +0000
From:   Chris Webb <chris@arachsys.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] unshare: fix a --map-auto error message
Message-ID: <Y6h7nVM0l4mAiBgw@arachsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When --map-auto is used by a user not listed in /etc/subuid, the error

  unshare: no line matching user "foo" in /etc/subuid: No error information

is emitted. Fix the stray ': No error information', correcting err() to
the intended errx().

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 sys-utils/unshare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index f5fe046a8..8313ee0a7 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -485,7 +485,7 @@ static struct map_range *read_subid_range(char *filename, uid_t uid)
 		return map;
 	}
 
-	err(EXIT_FAILURE, _("no line matching user \"%s\" in %s"),
+	errx(EXIT_FAILURE, _("no line matching user \"%s\" in %s"),
 	pw->pw_name, filename);
 }
 
