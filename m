Return-Path: <SRS0=MRkD=Z4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D26CC43603
	for <util-linux@archiver.kernel.org>; Fri,  6 Dec 2019 10:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FC720707
	for <util-linux@archiver.kernel.org>; Fri,  6 Dec 2019 10:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5VJzR9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfLFKGL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:06:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46172 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFKGL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 6 Dec 2019 05:06:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so7013831wrl.13
        for <util-linux@vger.kernel.org>; Fri, 06 Dec 2019 02:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=7CVud5yfCa/AjwLMzQXZ8g100XdJoqgTz14dCII4BaQ=;
        b=O5VJzR9SuT1L2eHbTjtijV6RFMIa4IYnuhRhesvOmFMEcoQzVeYxbehYKIl7m85CHy
         9Fs0lWMS9aYchcOcrKQFT5jX7fpRwbaMv8exj9ljuOjBuxO9S51G6HYEhsDtcfftby1t
         +K03XhAJu5I+59gkLwQIA6EquLhIhR4wEF/wvafDUAG9oKGQ7bbtjDHvUx9QvTbW667W
         M5D0OO+xr8tb6Ad7kDhTFVQyT4dVn3sTwE9t4DrsAktjGeJ/UY8yE3fgjIw2/cvuT6uz
         22Qdm8W5cwcqEVtVI4xX47d6V9nXNm9UbFDDQLucIhp49+ka5C3KPst8T9MuANbdihoJ
         spEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=7CVud5yfCa/AjwLMzQXZ8g100XdJoqgTz14dCII4BaQ=;
        b=EoIxo/XChxDJwvVTFnoTump5TSyfagxnYJAPbIxXuGUWmN3oC9teqiKXsvS10zWmcG
         GnwhTdhADu4eSAnKFmTCQfXUtXuMsYHd4Ayj/6rGvE1zzpQehyqpq2P/DFlL4v5IyBw4
         H8MeNoJqvwaXwNeAIflN1O7F0QPk21SuC4SY8fQkWvEvJs4YmwcrVN6vkC9WTEt51JXt
         iHm32PSF3AYxlnc2CBbT9665godMS0xpsHHY8X4FbZ50pJIxYQ0lLUphm75VAIy9wGsS
         FW0olhtup/2NF13/MNMHCKtCsVMh1xjiTBPXmIga+T9dJsXNnkJd2SqnpG3BLFtE2rrJ
         rufg==
X-Gm-Message-State: APjAAAXdpGCbDPDSgVSoNuVSJK+VrcciYEuDx35AMWFiXy/rGDgpLD+1
        LnI3rWPCe0SPCh03+avPdSb7uGKLtxc=
X-Google-Smtp-Source: APXvYqzxQhpVhR+qAaqV71n0+bTfIca6QFjBQjO91fFkTMb2hhhczlijBgLyoU7S3JJz/ztp90MxSg==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr15182185wru.119.1575626768705;
        Fri, 06 Dec 2019 02:06:08 -0800 (PST)
Received: from Mindship-03 (81-234-21-31.ftth.glasoperator.nl. [31.21.234.81])
        by smtp.gmail.com with ESMTPSA id l3sm15618369wrt.29.2019.12.06.02.06.08
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:06:08 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:06:03 +0100
From:   Jouke Witteveen <j.witteveen@gmail.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] su: silence a useless warning
Message-ID: <20191206100603.GA948@Mindship-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When the requested shell matches the restricted shell, there is no reason
to issue a warning, since we will be doing precisely as requested.

Signed-off-by: Jouke Witteveen <j.witteveen@gmail.com>
---
 login-utils/su-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 9bf0971b2..e671d822b 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -1149,6 +1149,7 @@ int su_main(int argc, char **argv, int mode)
 			shell = getenv("SHELL");
 
 		if (shell
+		    && strcmp(shell, su->pwd->pw_shell)
 		    && getuid() != 0
 		    && is_restricted_shell(su->pwd->pw_shell)) {
 			/* The user being su'd to has a nonstandard shell, and
-- 
2.24.0

