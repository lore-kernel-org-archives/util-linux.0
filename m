Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F785C4332F
	for <util-linux@archiver.kernel.org>; Wed,  6 Apr 2022 04:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiDFEAD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 00:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573175AbiDESIv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Apr 2022 14:08:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47C1F623
        for <util-linux@vger.kernel.org>; Tue,  5 Apr 2022 11:06:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so2127627wms.2
        for <util-linux@vger.kernel.org>; Tue, 05 Apr 2022 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lP7JVLIk85dMBYzGQIDTQ1sj5hZvvmHWW8L/kedb2A=;
        b=GvcyYVrSM9N58PfWHxJQ/dHV+BIIaTK5X/0TtvCSUbqKSZ0JtLSfJNfCKzDFmjSXY9
         ONFC7rUm7ic7LcbMA093vm+5Vpx9pAwonlGZPY7WOd0KmiEvUhxPqzuvdhjNp3tK6ad3
         P3Nj9/j1Dpzxl0YgsaPgprP+MWLcECHi8flKxwMTCcyutGRE7q9PwytRH2S02WNGahUa
         hdFm80XiC/6WXUDSwxTx70xzJxvXZpW5AtLXVy4T2cP3Ahvfm+4Im+v+MUWapjyhVu2D
         Hs2E1b+Y/A6Qf6HFSVAmpXtPbPRA284+QWcyJFJMRJSWfVJ/NLgt37dyNNhzLDS1m7Vw
         1cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lP7JVLIk85dMBYzGQIDTQ1sj5hZvvmHWW8L/kedb2A=;
        b=5NWcG/4fit7OBaFbA8X2nRFbvRDKbeWxrSLQWf2ykoRC7UhldzXURpaLU7nuUb38KM
         1kOfuwGGOGg3il15ETGNp6AGGuI6yGz75e6HCWNsybHxny+iWKwiisB6srYqKkT0fmDX
         iRlsa6GaVNSqwy3alUQIENk67EXG4XXpMZQmS8J/RzpIjf9x38Yq5MhiyWJrabpPYar8
         PVCUqAPPTNGaQ0hGPmkCgvvcaXaazBf5VPTghC5+iPQtqn74dGQZGuPNSx0U/3UcNfzu
         wSwDN9kS4Mv6IhAUIAH168qXacHQ/VqJqk9hm66Q08uGPnFkoCfnkFUAxs24iKba/3Sb
         j4lQ==
X-Gm-Message-State: AOAM530iIxNzTzuF9B1jZO4a5ovAHilC/jXCi2UEwq8miVgvuSYhqH2f
        aGE9IbU5Xk7HtzZ138GXrYpJy1UbMDU=
X-Google-Smtp-Source: ABdhPJzIhySScEjo0uvldOPNANNGYVgGKty07MBp5OK631fjFndBYmWcp5BxvJ8freBw5U8ep76vaA==
X-Received: by 2002:a05:600c:34d4:b0:38c:5ec7:1e38 with SMTP id d20-20020a05600c34d400b0038c5ec71e38mr4064870wmq.184.1649182007242;
        Tue, 05 Apr 2022 11:06:47 -0700 (PDT)
Received: from kali.home (2a01cb088e0b5b002be75de2a1caa253.ipv6.abo.wanadoo.fr. [2a01:cb08:8e0b:5b00:2be7:5de2:a1ca:a253])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b0038cc9096507sm3034867wmq.3.2022.04.05.11.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:06:46 -0700 (PDT)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] configure.ac: add lsns option
Date:   Tue,  5 Apr 2022 20:04:59 +0200
Message-Id: <20220405180459.944658-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

lsns unconditionally uses NS_GET_NSTYPE since version 2.38 and
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=de72df79d72fa906e71e2ac922d8745ff22deee5
which is only available since kernel 4.11 and
https://github.com/torvalds/linux/commit/e5ff5ce6e20ee22511398bb31fb912466cf82a36
resulting in the following build failure:

sys-utils/lsns.c: In function 'add_namespace_for_nsfd':
sys-utils/lsns.c:719:25: error: 'NS_GET_NSTYPE' undeclared (first use in this function)
  719 |  clone_type = ioctl(fd, NS_GET_NSTYPE);
      |                         ^~~~~~~~~~~~~

So add an option to allow the user to disable lsns

Fixes:
 - http://autobuild.buildroot.org/results/572ecf8e37ac733a4e4265f4f78f35230337278e

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 configure.ac | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 11c86b9a7..52c5b280a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1922,7 +1922,11 @@ UL_REQUIRES_LINUX([lsipc])
 UL_REQUIRES_BUILD([lsipc], [libsmartcols])
 AM_CONDITIONAL([BUILD_LSIPC], [test "x$build_lsipc" = xyes])
 
-UL_BUILD_INIT([lsns], [check])
+AC_ARG_ENABLE([lsns],
+  AS_HELP_STRING([--disable-lsns], [do not build lsns]),
+  [], [UL_DEFAULT_ENABLE([lsns], [check])]
+)
+UL_BUILD_INIT([lsns])
 UL_REQUIRES_LINUX([lsns])
 UL_REQUIRES_BUILD([lsns], [libsmartcols])
 UL_REQUIRES_BUILD([lsns], [libmount])
-- 
2.35.1

