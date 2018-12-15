Return-Path: <SRS0=8C/H=OY=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B9C43387
	for <util-linux@archiver.kernel.org>; Sat, 15 Dec 2018 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20CA2080F
	for <util-linux@archiver.kernel.org>; Sat, 15 Dec 2018 16:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB+PlWV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeLOQFt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:05:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52238 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbeLOQFs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Dec 2018 11:05:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so8402840wml.2
        for <util-linux@vger.kernel.org>; Sat, 15 Dec 2018 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=Ap74sjrFsLzXp7Jk1bqadgU4RsnvEyrh1sMA2a83bw0=;
        b=mB+PlWV1U/4JLYtZz5+D+fmdOEvCZXNnCylkKeqBeMy6rZixNJYEE9kdWgdsgyg/ck
         dxD10QORkRnita+yhzj58yzpwWo5DXyVNU8+Gmz7JKMGhduim2h57lo0D9VtcEQZUtgO
         kapQNClJAVPgp9Wml3h4gNM/++eKNqNsEY3wgIiBVa50XPg5HfnL8SbiPK1Eyvcy/rK3
         3FR/p9jtue46cmW1Qyqz5zriRigq0qoAaaEHiuoU1OoMWUvl4WzAYgCO7SKfcxoOSi1q
         SMb9A3C4MtOaqJ4kRJlWymXo72SxFhvC4rTVu/MkUDBAjIXtUsh1b+APZCQEydqP8CpG
         TgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=Ap74sjrFsLzXp7Jk1bqadgU4RsnvEyrh1sMA2a83bw0=;
        b=U1/BSTrf+PGlSpJOziEDk0DZJv4iCLStlg7atJj9h5pA+DcwZBypumcOibQnWk0l0N
         I1kEb2ARE4gr98DqX/SZ0jD7PO8YIPsFHAiR5qbsVDseih1gESjN6qMBio0ghdAtd6UO
         t4qz6tRNTKe8sgqlooTNcR+09nPmdvyjBRfK4DNqqftdSHzh+PL3r+3FW0UA+pb8iDqB
         F7x1nEHnubhUMmPdkUULQvt0ZLJMHuFUaEtdcoMoUezFyHSC4BZBK6BN7SiI1V/n8JQ9
         hNDhyejpReRoRwJAhUfPhI8iQuMXf+l9pvdxxJ5iM5LA3fsK00GUznE0OdqcOdAL9R7I
         GUSA==
X-Gm-Message-State: AA+aEWYkaWaSQ3GCCv86HlJFea5TE/gWZ7qoGd4mXctfvMR3IYRquSai
        u1UHxnt5ft2o69qjy7F38OJAdHJLRnE=
X-Google-Smtp-Source: AFSGD/UcFsTqhPECKvGj1JLsSHgfprgwHJo3cWlqfV//Enyg83bZaBlA4i7/xqSxVr0mYDUyLv02zw==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr6485737wmf.14.1544889946903;
        Sat, 15 Dec 2018 08:05:46 -0800 (PST)
Received: from localhost (82-71-26-41.dsl.in-addr.zen.co.uk. [82.71.26.41])
        by smtp.gmail.com with ESMTPSA id 199sm9258808wmh.21.2018.12.15.08.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 08:05:45 -0800 (PST)
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] README: add link to mail list archive
Date:   Sat, 15 Dec 2018 16:05:40 +0000
Message-Id: <20181215160540.27647-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 README | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 565693287..7f07d7d3f 100644
--- a/README
+++ b/README
@@ -7,8 +7,9 @@
 
 MAILING LIST:
 
-      E-MAIL: util-linux@vger.kernel.org
-      URL:    http://vger.kernel.org/vger-lists.html#util-linux
+      E-MAIL:  util-linux@vger.kernel.org
+      URL:     http://vger.kernel.org/vger-lists.html#util-linux
+      ARCHIVE: https://lore.kernel.org/util-linux/
 
       The mailing list will reject email messages that contain:
        - more than 100K characters
-- 
2.20.0

