Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6740AC433E0
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3232081A
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA0JpVaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgESMwz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgESMwy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 May 2020 08:52:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF8C08C5C0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:52:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so3448802wmd.0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PkUk/Y5RYBo0dmQeXUhu3BuHbXeEBYSB6y7pZ0v5/vo=;
        b=HA0JpVaapHPIWFhg/a5nU+JeFtalzkLYXR45MdfF0pxQvMRYmKTqRx/yyxfgQIVg+N
         GSMKiR0KFhIWrieC4XiZeNoj/PmVEU64b1GoaJf9uz7+oulOJ02hCJoiu1uDRJDx1gKw
         XWdsmPPTA4Qjk3og+1eTLku7k/mNE5PdVwsej2fmEG+/FU/HD10wnyYmS4khB4nRdpdN
         w00jU8u1rQwnHqLF0tZTBvLAN+eNEl0S7UWjX4aowIdEiGNWS0XpHN9J9JUOQm+KpADJ
         AWB63vqo/6aEV+jg6M23V0iGkdiipMYyQNY4epTwz4/VqJvd0Ls5HYuTO1xkITSYdaqY
         Ot8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PkUk/Y5RYBo0dmQeXUhu3BuHbXeEBYSB6y7pZ0v5/vo=;
        b=q50fuLCnNo8QkTeqPhNTWpVE4o9Xv16xc/Isn+c1JM0TTYMAdTZReQCGVSTV8ph1nC
         Q0/dmnc48SQ/ECSPljhLSp7oRynHdDjtQTrrmueJoh31QlOrTZtJtqSHnl+0E4yceP4j
         f5Es6aWYQ+crzyLP1bIAtbwv3L+ap+HvmZUQKZtkH/QiJctww/57qV3fFNajqT/Yi1rI
         SNjZQtYsE2yi6vHKnf2vqLLcL2zPhAqjT/Hva5I+W2BzgfZSqX6XfwAF07ulbfs5mBH2
         Lvpikbafxxi1CGLTnVhBvjdrP1O3FLtvSv1rjRssfKISD6v2tIFTi214+yo1JzK1gMwt
         A1uw==
X-Gm-Message-State: AOAM530f3nsX1W7h9T1490Uiwakx2h+QN8/LRGS7TBACXsn0HR4u6mRF
        lFezrVnQ3h9Mx74zHYFvfpO6jGnE7uk=
X-Google-Smtp-Source: ABdhPJyMB/uQ3jAkV1SC4iJLMKlVFO3utiZKpIBj89PuwQ4BmqKFAX2ch+zfjEz38oFolQpg7v3l+g==
X-Received: by 2002:a1c:f211:: with SMTP id s17mr5795978wmc.168.1589892772799;
        Tue, 19 May 2020 05:52:52 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id l19sm3942022wmj.14.2020.05.19.05.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:52:52 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 5/7] Manual pages: Standardize on ENVIRONMENT as section title
Message-ID: <d3f9cd5d-cf80-25a6-7cc6-0ebfc4fe83ff@gmail.com>
Date:   Tue, 19 May 2020 14:52:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There is quite some value (in terms of readability and user
expectations) if consistent names are used for the sections
within manual pages. This patch is one of a series to bring
about this consistency.

But, let's make sure that the section is consistently titled
across pages. Currently we have ENVIRONMENT (many) or ENVIRONMENT
VARIABLES (3).  Let's standardize on ENVIRONMENT (which is also
what is suggested in man-pages(7)).

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/fsck.8     | 2 +-
 login-utils/sulogin.8 | 2 +-
 text-utils/pg.1       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 10728c861..e53333bca 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -345,7 +345,7 @@ with
 Options to different filesystem-specific fsck's are not standardized.
 .SH FILES
 .I /etc/fstab
-.SH ENVIRONMENT VARIABLES
+.SH ENVIRONMENT
 The
 .B fsck
 program's behavior is affected by the following environment variables:
diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
index d5b24383d..7e77cd541 100644
--- a/login-utils/sulogin.8
+++ b/login-utils/sulogin.8
@@ -72,7 +72,7 @@ will wait forever.
 Display help text and exit.
 .IP "\fB\-V\fR, \fB\-\-version\fP"
 Display version information and exit.
-.SH ENVIRONMENT VARIABLES
+.SH ENVIRONMENT
 .B sulogin
 looks for the environment variable
 .B SUSHELL
diff --git a/text-utils/pg.1 b/text-utils/pg.1
index 4c9a759eb..a7fd60134 100644
--- a/text-utils/pg.1
+++ b/text-utils/pg.1
@@ -196,7 +196,7 @@ input file or writes on the terminal,
 will immediately display the prompt.
 In all other situations these keys will terminate
 .BR pg .
-.SH ENVIRONMENT VARIABLES
+.SH ENVIRONMENT
 The following environment variables
 affect the behavior of
 .BR pg :
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
