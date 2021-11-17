Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC5C433F5
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877D861BE1
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhKQCNm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhKQCNl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Nov 2021 21:13:41 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB5BC061570
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:44 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id n15so1252543qta.0
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kXi66GDReFYcOF6MCI599hXUJFULCnL1qg/q1hUma1c=;
        b=F8PS6s+fg4WixZTNkyRXGuofdEItljr98iQFAZas6Ke/qn9SBBd7vWn9e1XWcBrKA0
         8c/TWZMsR6DLQOnjncMYIkIAdfAzuVglg0LN1IAJR+tfqXqMXyYNYZRfX1FmSHyI//Ya
         DQWy3hCZEEiuflX5mKFvG7fmDg96vVoMdIXByPAphFKmI+4nqPsW3vInVvDoHA+2YMV5
         Dm7MqQV8PG9sd06uDTUVqCk6TgUGXRtj2azQclMo/cuFTsPYBFOVSe80vhmUjKtDK/wa
         6JYDgeTFI7N5dHCCGvYJ0EbU/hz9iW0DRa2S2qaaQELImdjE6avDyukwgIespEuhi9M+
         rjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kXi66GDReFYcOF6MCI599hXUJFULCnL1qg/q1hUma1c=;
        b=QM1CbQZIxVZ6IkgCAb/RIIPcPbdI4wH3tlpoP7ew8OXwow/qAElyiOgT4SHHH3yos9
         ILsR3P0LESOKZ8xDnxioFVomPVELbGJVXzIZZWm3c0NdfBQxYXyqrgmq5D3OtZPQQ478
         xgUNRgyT3JYcJeYR2dFQWdAxrwjSQhNAiu6+W2F8d5PaKUTh0w4bGDq//JZRFbRyvt66
         WX/A0ckQRUDrnIIVUGk0s6jP2SEXcm8O8ENkQLsMlKeOqLwGBNQ55aoX7ZZAavDSLN7P
         N832MUJ7Z3cuD68jDtuTVsTYLfBGJ7jxka36tahnSowxUvIUTSq+CBRt3bMFsIbrGO99
         9uVQ==
X-Gm-Message-State: AOAM53120/HqRB7ld/LTjT8WZXSgdQB31GOvKpWU9QkHbBojAtdFk6/v
        XwxVP5r1+S+SXQwa6a94IyLBH52RZcg=
X-Google-Smtp-Source: ABdhPJwBewWhKNQo5OAmshnfAvVSyKF+wPDaJaBYPAtF5yaFxrsHwiG+CCc2qI9C8DhZIDvsV+smcw==
X-Received: by 2002:ac8:7e88:: with SMTP id w8mr12849999qtj.357.1637115043200;
        Tue, 16 Nov 2021 18:10:43 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id t11sm9326200qkm.96.2021.11.16.18.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:10:42 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 0/5] unshare: Add support for mapping ranges of user/group IDs
Date:   Tue, 16 Nov 2021 21:10:33 -0500
Message-Id: <20211117021038.823851-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This series adds support for mapping ranges of user/group IDs using the
newuidmap and newgidmap programs from shadow. The intent is to allow
for root-less bootstrapping of Linux root filesystems with correct
ownership. My primary inspiration is mmdebstrap [1], which uses
unshare(2) to create Debian root filesystems without needing root
access.

[1] https://gitlab.mister-muffin.de/josch/mmdebstrap


Sean Anderson (5):
  include/c: Add abs_diff macro
  unshare: Add waitchild helper
  unshare: Add options to map blocks of user/group IDs
  unshare: Add option to automatically create user and group maps
  unshare: Document --map-{groups,users,auto}

 include/c.h              |   8 +
 sys-utils/unshare.1.adoc |  32 ++++
 sys-utils/unshare.c      | 374 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 399 insertions(+), 15 deletions(-)

-- 
2.33.0

