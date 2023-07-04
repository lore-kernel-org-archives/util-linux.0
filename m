Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14AFEB64DD
	for <util-linux@archiver.kernel.org>; Tue,  4 Jul 2023 09:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjGDJXJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jul 2023 05:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjGDJWb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jul 2023 05:22:31 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B0136
        for <util-linux@vger.kernel.org>; Tue,  4 Jul 2023 02:22:25 -0700 (PDT)
From:   Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1688462072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2libQMyAUt4YVZRNmaGlu8gTPgKFuq0E6T4y0EWjgdA=;
        b=c5rSQquVgVVq7baVZGgOvzRJy3Qq4yUG6BlbWcLpVx4Px0Kn21jfYPTvtHH7dLWSPc6/48
        3anF/Kp5ZrHuOjFYOpjWgK7cDET76i3Hlg/lGunu+g/ryEAClKUEXiLsoOA4FfVp2BpMG0
        Dp0WtMA2HkadWUOQohnyHG2MhrjQXWJPZPkbL5hdtB8Y7YC7LgiNNuRF0bY+u0hmBDdSXD
        ePCCzlbojqOhmanM4FMHWGU4ON91xZD/27dO7dY7vhQczXwDGdsS+bYJ+1rzIyH3eWHSHR
        9haIZkBwXwhR24HyxK6Iejv+nszuwuZtulF6XSRKWB/5DQeOpBlmvobZzjVfuQ==
To:     util-linux@vger.kernel.org
Subject: [PATCH 3/3] lib/pager: Apply pager-specific fixes only when needed
Date:   Tue,  4 Jul 2023 11:14:30 +0200
Message-Id: <20230704091430.3555428-3-dsimic@manjaro.org>
In-Reply-To: <20230704091430.3555428-1-dsimic@manjaro.org>
References: <20230704091430.3555428-1-dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Currently defined output filter quirk fixes and environment variable
tweaks apply to less(1) only, so let's don't apply them when the pager
is actually configured to something else.

While there, rename the less(1)-specific callback function to make
clear what it applies to, and to make adding any posible additional
pager-specific callback functions a bit easier.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 lib/pager.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/pager.c b/lib/pager.c
index db7a989df..98814b549 100644
--- a/lib/pager.c
+++ b/lib/pager.c
@@ -85,7 +85,9 @@ static int start_command(struct child_process *cmd)
 			close(cmd->in);
 		}
 
-		cmd->preexec_cb();
+		if (cmd->preexec_cb)
+			cmd->preexec_cb();
+
 		execvp(cmd->argv[0], (char *const*) cmd->argv);
 		errexec(cmd->argv[0]);
 	}
@@ -140,7 +142,7 @@ static int finish_command(struct child_process *cmd)
 	return wait_or_whine(cmd->pid);
 }
 
-static void pager_preexec(void)
+static void pager_preexec_less(void)
 {
 	/*
 	 * Work around bug in "less" by not starting it until we
@@ -240,7 +242,11 @@ static void __setup_pager(void)
 	pager_argv[2] = pager;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-	pager_process.preexec_cb = pager_preexec;
+
+	if (!strncmp(pager, "less", 4))
+		pager_process.preexec_cb = pager_preexec_less;
+	else
+		pager_process.preexec_cb = NULL;
 
 	if (start_command(&pager_process))
 		return;
-- 
2.33.1

