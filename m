Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1245DC0015E
	for <util-linux@archiver.kernel.org>; Tue,  4 Jul 2023 09:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjGDJXL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jul 2023 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjGDJWb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jul 2023 05:22:31 -0400
X-Greylist: delayed 471 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 02:22:25 PDT
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE35B6
        for <util-linux@vger.kernel.org>; Tue,  4 Jul 2023 02:22:25 -0700 (PDT)
From:   Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1688462072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GF1sZf0dCRV1g14EBu7W0ID8KdQ1bGOKgyXEW9iFISQ=;
        b=HMogBFXsfUYj7SN+mOasY2g0pBGhG7KEjvVmcZO/WtlcyA2VCqw3aF+lxoAzbQ1xoZyA3Q
        vR0aHKhzyJbWkBpMHOmxqlywS3G3/gOP70Ugy5T6nZix8CZ4rfnA8VHNlCb94iHR+xn+lI
        Jd1aPxdOU3U0jPEZVKYLlSsz3ph483opuapzkz2ta4QZCJyiB9o+20zsazsjdq4BCV2Mao
        ebPBRQuMivL9Ykg95AlcC3B7Kij954sZCO6iqw2BB2lBPQo4vIaVzM2add/kMZGMRIEq1b
        9xwJCGBSyhNWPBoF5drchqKroB4aOJY7i456Nilc4EJ4iyhvYhdlSDbF9VBnPw==
To:     util-linux@vger.kernel.org
Subject: [PATCH 2/3] dmesg: Delete redundant pager setup
Date:   Tue,  4 Jul 2023 11:14:29 +0200
Message-Id: <20230704091430.3555428-2-dsimic@manjaro.org>
In-Reply-To: <20230704091430.3555428-1-dsimic@manjaro.org>
References: <20230704091430.3555428-1-dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The setup of the pager is already performed a few lines of code above,
so it's safe to delete the repeated setup, which actually does nothing.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 sys-utils/dmesg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 02358e449..971712b56 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1646,8 +1646,6 @@ int main(int argc, char *argv[])
 		/* only kmsg supports multi-line messages */
 		if (ctl.force_prefix && ctl.method != DMESG_METHOD_KMSG)
 			ctl.force_prefix = 0;
-		if (ctl.pager)
-			pager_redirect();
 		n = read_buffer(&ctl, &buf);
 		if (n > 0)
 			print_buffer(&ctl, buf, n);
-- 
2.33.1

