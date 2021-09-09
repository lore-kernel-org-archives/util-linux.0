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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A812FC433F5
	for <util-linux@archiver.kernel.org>; Thu,  9 Sep 2021 00:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8CB6109F
	for <util-linux@archiver.kernel.org>; Thu,  9 Sep 2021 00:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348043AbhIIAK1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 8 Sep 2021 20:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347902AbhIIAKZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 8 Sep 2021 20:10:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F58C061575
        for <util-linux@vger.kernel.org>; Wed,  8 Sep 2021 17:09:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c6so125176pjv.1
        for <util-linux@vger.kernel.org>; Wed, 08 Sep 2021 17:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQzAQMmX4oz8E7w7uf2rjEOaHMmDgx7LhW/51C5GrqM=;
        b=Y6bUFtE4H3JIwgHJD0O/r2KaUKr8o3O8u7HIF+ofaFgnwREkaDN9Ct0qiedRX0CrZg
         aXaUIr00EOWcZhVBnLiDnRAKfeI/KNg579QxS8APiZMjyLDylhyTnD7RbGSkcaACSdYY
         DQWGAUFDn9VqyLTpII8cOWseXlc1sx4vVMCHrk0L7FH9zy4qx1MiLAtUXEU3eBcIjNoj
         RTlIkzF5IMquWg3UkbKygsdYDKdCMwWx8JQllY7/a2HFv5ix4T8pPpJv9rw2P52qbGQu
         2FW85bZSQo2FbK++pTnu/UWZH6dioIRYY9FkRPqDRqSdvEtv8cxR60qFdv4XRPjsYcqa
         jF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQzAQMmX4oz8E7w7uf2rjEOaHMmDgx7LhW/51C5GrqM=;
        b=478TWuV7G7NOd5GP4ecHVMX/tdiDj/j84jMzwsjw4Qh1TwJelPEixJm8TbPRbYbxI0
         4QfEf6GgPB+4r16I0GpoZWpzm77gi1iCY/eqVkTsG3yAi+byPdG6hIK4mVFbs9H4rc9j
         ETC7aQfutLt3Vl+IGoX0FkVLBPJRWNo7TxwhkKqCswacqZvK/XkxVkIH8Z3LsoUwd9nK
         1lHIpUudojM085cq1VNk05QpTsnFfke2tURI9phaMhU8vZDoqhzJJ/pAPhL5jBKryaXY
         9OfGARMqwEZaMAOPojDii0D8q83r3Ir/jeLhG7So05SWcjk3/KYojEVkLHsTuMuH2gRY
         PP8Q==
X-Gm-Message-State: AOAM532+e2ZWgD55VkTqPp2j93/Kkwgk/L8AVUYl11bhabaBKQkuUIzH
        1jyyTxMsMaTS9tyCbjRg/xo=
X-Google-Smtp-Source: ABdhPJwEjJt+37TtGwibNx7/JVlGrvxOr4EhwGBXzNm5rPgo5jC46EaDNZdMyN+zcrItPloMPROx3Q==
X-Received: by 2002:a17:903:1cb:b0:138:ecff:4030 with SMTP id e11-20020a17090301cb00b00138ecff4030mr35255plh.85.1631146156673;
        Wed, 08 Sep 2021 17:09:16 -0700 (PDT)
Received: from localhost.localdomain (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id h127sm34258pfe.191.2021.09.08.17.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 17:09:16 -0700 (PDT)
From:   Michael Kerrisk <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 2/2] unshare.1.adoc: Improve wording re creation of bind mounts
Date:   Thu,  9 Sep 2021 02:08:28 +0200
Message-Id: <20210909000828.203994-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909000828.203994-1-mtk.manpages@gmail.com>
References: <20210909000828.203994-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Use consistent wording for the options that create
bind mounts, and improve the wording.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1.adoc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 2f1be8fc3..490dfc8b9 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -53,30 +53,30 @@ The process can have a distinct view of *CLOCK_MONOTONIC* and/or *CLOCK_BOOTTIME
 == OPTIONS
 
 *-i*, *--ipc*[**=**__file__]::
-Create a new IPC namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
+Create a new IPC namespace. If _file_ is specified, then the namespace is made persistent by creating a bind mount at _file_.
 
 *-m*, *--mount*[**=**__file__]::
-Create a new mount namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. Note that _file_ must be located on a mount whose propagation type is not *shared* (or an error results). Use the command *findmnt -o+PROPAGATION* when not sure about the current setting. See also the examples below.
+Create a new mount namespace. If _file_ is specified, then the namespace is made persistent by creating a bind mount at _file_. Note that _file_ must be located on a mount whose propagation type is not *shared* (or an error results). Use the command *findmnt -o+PROPAGATION* when not sure about the current setting. See also the examples below.
 
 *-n*, *--net*[**=**__file__]::
-Create a new network namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
+Create a new network namespace. If _file_ is specified, then the namespace is made persistent by creating a bind mount at _file_.
 
 *-p*, *--pid*[**=**__file__]::
-Create a new PID namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. (Creation of a persistent PID namespace will fail if the *--fork* option is not also specified.)
+Create a new PID namespace. If _file_ is specified, then the namespace is made persistent by creating a bind mount at _file_. (Creation of a persistent PID namespace will fail if the *--fork* option is not also specified.)
 +
 See also the *--fork* and *--mount-proc* options.
 
 *-u*, *--uts*[**=**__file__]::
-Create a new UTS namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
+Create a new UTS namespace. If _file_ is specified, then the namespace is made persistent by creating a bind mount at _file_.
 
 *-U*, *--user*[**=**__file__]::
-Create a new user namespace. If _file_ is specified, then a persistent namespace is created by a bind mount.
+Create a new user namespace. If _file_ is specified, then the namespace is made persistent by creating a bind mount at _file_.
 
 *-C*, *--cgroup*[**=**__file__]::
-Create a new cgroup namespace. If _file_ is specified, then persistent namespace is created by bind mount.
+Create a new cgroup namespace. If _file_ is specified, then the namespace is made persistent by creating a bind mount at _file_.
 
 *-T*, *--time*[**=**__file__]::
-Create a new time namespace. If _file_ is specified, then a persistent namespace is created by a bind mount. The *--monotonic* and *--boottime* options can be used to specify the corresponding offset in the time namespace.
+Create a new time namespace. If _file_ is specified, then the namespace is made persistent by creating a bind mount at _file_. The *--monotonic* and *--boottime* options can be used to specify the corresponding offset in the time namespace.
 
 *-f*, *--fork*::
 Fork the specified _program_ as a child process of *unshare* rather than running it directly. This is useful when creating a new PID namespace. Note that when *unshare* is waiting for the child process, then it ignores *SIGINT* and *SIGTERM* and does not forward any signals to the child. It is necessary to send signals to the child process.
-- 
2.31.1

