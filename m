Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A2C433EF
	for <util-linux@archiver.kernel.org>; Sun,  6 Feb 2022 06:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiBFGMN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 6 Feb 2022 01:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBFGMN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 6 Feb 2022 01:12:13 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A79EC06173B
        for <util-linux@vger.kernel.org>; Sat,  5 Feb 2022 22:12:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id og43so8514933ejc.0
        for <util-linux@vger.kernel.org>; Sat, 05 Feb 2022 22:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJNplkduRkwArIJLwhgWwaoFpxt+TkYbd0CiNXfgt6E=;
        b=Dga1aMl4KRmU3Y8AZC0nwfa5oU7IiUxNs+UAw1k4ZS69Ikn63XqrfSQOuC2bMo/khO
         yn3FBMNppgB+Ai7MLnpPt2zgzZalFMHY3ye8HQtTPLVBNkg21TicoVdM5fSc7ptUcOto
         n+jqgwWXfsIPBX0hMwI8hG3RPzqNw+9M2tl//Xazm0sAWNWN2OMhOGu8J7EcNM2K97Eb
         3sGaW5CiBZHs9jBCr52LW0K/z7HTzzR/vUCAb5NRCA6ovTn+LZXAxkMXlcP8hs0f2zFa
         w66RuopfmwsDxAQdajkE6MHYA+FsF9J9/5LvLDbTOKODNsgeGf91rtWIQZC4+LOX6f8N
         Eh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJNplkduRkwArIJLwhgWwaoFpxt+TkYbd0CiNXfgt6E=;
        b=dzSL1IYbpo9ygyGiXalaO+Ft3vREDz4BSrEWbx73b3sqma1A2KQWFYuX1kV8fbM8qq
         +a8IzzWZpitbgQs6zhbG5f/InltFI/jgaEiNq4DB2ZVEaSYOzqeA7fk7H67/9qczlk+8
         Dz9tsKT5iZ3nDO02T6KeC0E+0iUgL7++Y+qhTk51MOC7EGR2j93Y6C9UDfpmOPfLqh8+
         3w4QmnYKtKIDfPWLGzAZbVBnrcrbN/GFE8k2nakbuamkgbACMCiDH+aM1PVhf4zTGp4l
         OwCuuNeXrhhv8uBcqb9SbUF2VavE3q+L2KhHLcHwFjTSP6mvYnPMvWjzFpT5Ww3itjrn
         pWcg==
X-Gm-Message-State: AOAM530Yl3y2vWdkdtUoCImrlNsjNWOL9ZLJlVsm3vx4Q8tAdj3Djddf
        HYdU/XmU3gSf+RvcgxvvSySGzKCKt74=
X-Google-Smtp-Source: ABdhPJzk7tYBjyq6u6wyRVYHaUY1h81p0s1M2v3Fshb4lPEmdaPbI5HTgBbGVws5q45WIg/uPivOiA==
X-Received: by 2002:a17:907:3e0c:: with SMTP id hp12mr5372087ejc.685.1644127930980;
        Sat, 05 Feb 2022 22:12:10 -0800 (PST)
Received: from localhost.localdomain (178.115.71.30.wireless.dyn.drei.com. [178.115.71.30])
        by smtp.gmail.com with ESMTPSA id bv2sm2264420ejb.154.2022.02.05.22.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 22:12:10 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 1/4] newgrp.1.adoc: use bold font for command name in synopsis
Date:   Sun,  6 Feb 2022 07:11:55 +0100
Message-Id: <20220206061158.752262-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.35.1.301.gcdacdcff8b.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

newgrp.1.adoc is our only man page that doesn't use bold font for
the command name in the synopsis. Fix that.

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 login-utils/newgrp.1.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/newgrp.1.adoc b/login-utils/newgrp.1.adoc
index b50b0d5f3..629078b5e 100644
--- a/login-utils/newgrp.1.adoc
+++ b/login-utils/newgrp.1.adoc
@@ -14,7 +14,7 @@ newgrp - log in to a new group
 
 == SYNOPSIS
 
-newgrp [_group_]
+*newgrp* [_group_]
 
 == DESCRIPTION
 
-- 
2.35.1.301.gcdacdcff8b.dirty

