Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FB5C433F5
	for <util-linux@archiver.kernel.org>; Thu,  9 Sep 2021 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FEC6108D
	for <util-linux@archiver.kernel.org>; Thu,  9 Sep 2021 00:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhIIAJu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 8 Sep 2021 20:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347902AbhIIAJs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 8 Sep 2021 20:09:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D4C061575
        for <util-linux@vger.kernel.org>; Wed,  8 Sep 2021 17:08:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w6so1929968pll.3
        for <util-linux@vger.kernel.org>; Wed, 08 Sep 2021 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDfdpnyVAhmIl56pup3aYoLlwsvmlQyQ/hlVK4dDSh4=;
        b=cQM81lyuwtzhYaRwGONJGdbAMe8mHQKJMGC2U+M5NOLPTXkYguY4gGm0gYfxprSeIM
         PhAfvBzyuZuqNQP/CQlau1l7+Jus6HhKHL/hri/byxyMcQKp6bKMxROQ1ewZ4zpjPI/j
         JtMFckm7gYSjEuF9OxvqJHoAPw+N+3UPzjGU6lRFrlmz4tFKZn0obXzptu7EyFvu8CtR
         p65Dw1vsgO9RWAKSB8yXcK7ppPHrcHRj0u8TryehaHbxMa1rdX+lQ0EkvHYAK879Hl1p
         uYdTqJwvIUwGIayU7x/uuRJ6NtaF2znt6JT0gSllIuhDkBXI6R80FXEo8EkFvCn2c9Co
         ikdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDfdpnyVAhmIl56pup3aYoLlwsvmlQyQ/hlVK4dDSh4=;
        b=CoaSrkmCm4MAn9yjxzMlS3nKJ41geSefZxpWlZP0Bsbuc2uHhNiqT+Rclay1AP+/5Q
         B2xN3qHBdVVTQBEHlKR76q79n0b9MCM1Pwq1cp2em9mOkSwVuTCPzRdPSpoV2ZHfLNTB
         ZWe4KjIdkK4QecsfsxgmagBdagSukPxCBb0Gq5H4IYxiDFlCAM/UCuMixp+DAJZwziFf
         +H1prO2+sWvLnesJe8eBKnJKfwNNVQmfkR816cUqQA2tC+kiS5MZ7ux4AQIXALCqOeFp
         y4uVo+74QsDiUCOZ8FSa/6FCXVHxbB9l3/tL/VRwX7oBr5WdAHa19qNaBTMGd2H1WbG9
         c2SA==
X-Gm-Message-State: AOAM533UH6QA8xYkhFzt2mvxKOg3AViPuR/J8+Za4FPMcrAFGCiFhu5R
        lguw6jHNF0dJF5thV5MT+ptm9uE89sY=
X-Google-Smtp-Source: ABdhPJzF/WXZXVu1ZXXBiokDfia6Qa7RD3lFN3Oy3qtIU1yXPZwGHjtkrKwrZIZPtxyVLVtjLCtYKQ==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr254871plq.59.1631146119738;
        Wed, 08 Sep 2021 17:08:39 -0700 (PDT)
Received: from localhost.localdomain (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id r8sm73677pgp.30.2021.09.08.17.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 17:08:39 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 1/2] unshare.1.adoc: Improve wording re namespace creation
Date:   Thu,  9 Sep 2021 02:08:27 +0200
Message-Id: <20210909000828.203994-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The terminonoly "unshare the namespace" is not very helpful.
Instead, use wording that explains what these options actually
fo: "create a new namespace".

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1.adoc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index f0fdf506f..2f1be8fc3 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -53,30 +53,30 @@ The process can have a distinct view of *CLOCK_MONOTONIC* and/or *CLOCK_BOOTTIME
 == OPTIONS
 
 *-i*, *--ipc*[**=**__file__]::
-Unshare the IPC namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
+Create a new IPC namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
 
 *-m*, *--mount*[**=**__file__]::
-Unshare the mount namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. Note that _file_ must be located on a mount whose propagation type is not *shared* (or an error results). Use the command *findmnt -o+PROPAGATION* when not sure about the current setting. See also the examples below.
+Create a new mount namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. Note that _file_ must be located on a mount whose propagation type is not *shared* (or an error results). Use the command *findmnt -o+PROPAGATION* when not sure about the current setting. See also the examples below.
 
 *-n*, *--net*[**=**__file__]::
-Unshare the network namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
+Create a new network namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
 
 *-p*, *--pid*[**=**__file__]::
-Unshare the PID namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. (Creation of a persistent PID namespace will fail if the *--fork* option is not also specified.)
+Create a new PID namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. (Creation of a persistent PID namespace will fail if the *--fork* option is not also specified.)
 +
 See also the *--fork* and *--mount-proc* options.
 
 *-u*, *--uts*[**=**__file__]::
-Unshare the UTS namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
+Create a new UTS namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
 
 *-U*, *--user*[**=**__file__]::
-Unshare the user namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
+Create a new user namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
 
 *-C*, *--cgroup*[**=**__file__]::
-Unshare the cgroup namespace. If _file_ is specified, then persistent namespace is created by bind mount.
+Create a new cgroup namespace. If _file_ is specified, then persistent namespace is created by bind mount.
 
 *-T*, *--time*[**=**__file__]::
-Unshare the time namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. The *--monotonic* and *--boottime* options can be used to specify the corresponding offset in the time namespace.
+Create a new time namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. The *--monotonic* and *--boottime* options can be used to specify the corresponding offset in the time namespace.
 
 *-f*, *--fork*::
 Fork the specified _program_ as a child process of *unshare* rather than running it directly. This is useful when creating a new PID namespace. Note that when *unshare* is waiting for the child process, then it ignores *SIGINT* and *SIGTERM* and does not forward any signals to the child. It is necessary to send signals to the child process.
-- 
2.31.1

