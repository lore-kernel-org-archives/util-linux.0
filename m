Return-Path: <SRS0=8KZJ=CG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C9C433E6
	for <util-linux@archiver.kernel.org>; Fri, 28 Aug 2020 20:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4741120825
	for <util-linux@archiver.kernel.org>; Fri, 28 Aug 2020 20:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+TkQeLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgH1UAF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgH1UAC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 28 Aug 2020 16:00:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31652C061264
        for <util-linux@vger.kernel.org>; Fri, 28 Aug 2020 13:00:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so307464wmd.1
        for <util-linux@vger.kernel.org>; Fri, 28 Aug 2020 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=syprSTwU0m85oTCadJizxYZ7sCwIFmtr9cTf3peTGc8=;
        b=t+TkQeLlxUKJ4Ruow5R5Udts6dQBey2v38rOnf7FAl8tF+inkDoQIsKUZNr70epIp8
         4pAyfnQIlUHLmCSRJtMA6gmYfOTKzkvvXAnoybD5cz4i0/lPDdtDTJYptGdoVydcyTZ/
         6iNRJG9RSSIH6nSihRV5hL8uZZiFnwWrMFPOzxgiqjtdY+TJ0EaVL7WVCGPf01SuryNy
         upeV/4SCPjESFxOvLZz5JTYokoTrD0AO+udmmXouRfzI/VrQQwgQTY4akyRvxrsc6b9S
         sRyrr6rWguZZRvaZtcLa6WIMD3H/lXW6SEbeaQCX7NaasyHMJhC3cC1nxkJOR6QeYM/I
         g9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=syprSTwU0m85oTCadJizxYZ7sCwIFmtr9cTf3peTGc8=;
        b=khmovTABvEBEbohZ7YeS+kI0EJM5oph0jcbAFkXuwlEVMGXrvHA+3vBQI4p4Gt6m/j
         GNyibO3rD9AmmAtz0QsIGIVprJ1JkGIcYrhnZz+353t7193Dts0Oun/cllw8E2ITHas0
         WUTTZgOZwdaR01PmGGJRP5/Wnhlqa2E8lsc7yW0eDyC/OsJvBeFN2UuKBVkvJZL9XCje
         Nodd97ZfLNX/8aLr/XESuMPrcNw0F+P+RfGCfkf26FkeAmb6ClIjd3PQi0vhsdJgMxBz
         MyuJveS4/H2Z5WzWK6ZI5nXiGEx2NNeW86NOwD/b6jFLpP/TIVxMhZZZq3YVjuQQCBlN
         9xpQ==
X-Gm-Message-State: AOAM532591CgwmUEQ6nMwBMNQigW/C7SCYt9TQu234D+Rh+LJg2skNQu
        /pnsKxM6hpXhuzdu/sjMBHFVjai94hsOwQ==
X-Google-Smtp-Source: ABdhPJx7nDlyBb5z9tu/71h3eFzoXim+B5bQjK7ZQrMSc/Dk2cb7sa7lGmZguNu5Vlm2PyjTyNUF3A==
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr281438wma.61.1598644800532;
        Fri, 28 Aug 2020 13:00:00 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:a8d8:38f:5807:ac47])
        by smtp.gmail.com with ESMTPSA id p6sm674643wmg.0.2020.08.28.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:59:59 -0700 (PDT)
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] libmount: do not use pointer as an integer value
Date:   Fri, 28 Aug 2020 20:59:57 +0100
Message-Id: <20200828195957.24195-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Fix couple "initialization of ‘long int’ from ‘void *’ makes integer from
pointer without a cast" warnings.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/python/fs.c  | 2 +-
 libmount/python/tab.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmount/python/fs.c b/libmount/python/fs.c
index 0ba78bed0..e9891241d 100644
--- a/libmount/python/fs.c
+++ b/libmount/python/fs.c
@@ -836,7 +836,7 @@ PyTypeObject FsType = {
 	sizeof(FsObject), /*tp_basicsize*/
 	0, /*tp_itemsize*/
 	(destructor)Fs_destructor, /*tp_dealloc*/
-	NULL, /*tp_print*/
+	0, /*tp_print*/
 	NULL, /*tp_getattr*/
 	NULL, /*tp_setattr*/
 	NULL, /*tp_compare*/
diff --git a/libmount/python/tab.c b/libmount/python/tab.c
index e3185065e..5fce90aef 100644
--- a/libmount/python/tab.c
+++ b/libmount/python/tab.c
@@ -735,7 +735,7 @@ PyTypeObject TableType = {
 	sizeof(TableObject), /*tp_basicsize*/
 	0, /*tp_itemsize*/
 	(destructor)Table_destructor, /*tp_dealloc*/
-	NULL, /*tp_print*/
+	0, /*tp_print*/
 	NULL, /*tp_getattr*/
 	NULL, /*tp_setattr*/
 	NULL, /*tp_compare*/
-- 
2.28.0

