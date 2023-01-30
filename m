Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F0EC54EED
	for <util-linux@archiver.kernel.org>; Mon, 30 Jan 2023 10:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjA3KfM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Jan 2023 05:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbjA3KfF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Jan 2023 05:35:05 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3542705
        for <util-linux@vger.kernel.org>; Mon, 30 Jan 2023 02:35:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml19so6810295ejb.0
        for <util-linux@vger.kernel.org>; Mon, 30 Jan 2023 02:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uut1M0x6IfDOP1/LkVWweuBYm4lLvDoAx45VLYsSDTU=;
        b=GMT2a0f6NCc7UCoWNI4ahLn7GrS8JVj4TzhgZ61ICPdQ60KZKOjTsFzsVXegKOxoPo
         puqvVWRF+yjbGn2PfzRNoix3QJRtNED9GatZrRKpWb1WjBogF7PT3VFZzxaM9jG/Ipsz
         EqoDRCmZoIEpASwI06HRPQ0YbQBWEZIB/4/UAu7d8V4KzKcNxSkaBRVk+HDAly6WK85x
         F3FxZAVkaqx6UEvvYi/mURiemobmlqTeykPRMrHUwAvOv90LAXHasI4mqjzLWA94zMNR
         M6mu6sRmHdOaVcJPO41w6NFtbrDwXBTmF1F8LxVn5Fl+w1TF9i/WbuC+2VYVpqIO4ymk
         aslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uut1M0x6IfDOP1/LkVWweuBYm4lLvDoAx45VLYsSDTU=;
        b=khZpbyiZbkwkBN++WQ4eAIrZ0vMCW6cezyBi6p4a5FJGl2kK1MnSzxSa2ar7ZOO6nC
         ob2oK5RmIvnUehtHXjx/fdKR9piCmRkBLXydrLzQbFqBfJN67MKvkAlAJLYfUnhrsqe+
         uYSQ3MOCnJgTD8ZR6X2qwmL/uNiIlN0juhV60R5GUVdEHqyNTLgphTXQQucsGHTUaZuY
         lS08t50RN7UrBHH2TXwW/RyoZroiUyjF4Sz8ZD8zYNErjcJkG5Smuz43lujXralCkleH
         T+ppmfqmwtQH9Ye2Csw6nGb+IkuZL/2cX0KlaneWxKegINl2G9Pipilkbi/jwEH3PEFd
         SkJQ==
X-Gm-Message-State: AFqh2kr10UOm8R44w7nmXZYGCSKn0pXglY80FbsEZgQSvuiRITadZVRH
        yunWUN8QKA36mWMGlBuJz8lWA5z26Go=
X-Google-Smtp-Source: AMrXdXu8dupH09tgvFmkHExVDryfgs+opmbM4Li0inD5P9HuuW4dZSTcgd9JVI1J28nNaOPbKLwq/Q==
X-Received: by 2002:a17:906:6843:b0:86c:a3ed:1442 with SMTP id a3-20020a170906684300b0086ca3ed1442mr51707228ejs.4.1675074902245;
        Mon, 30 Jan 2023 02:35:02 -0800 (PST)
Received: from development1.visionsystems.de (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id c20-20020aa7df14000000b00499b3d09bd2sm2182796edy.91.2023.01.30.02.35.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2023 02:35:01 -0800 (PST)
From:   yegorslists@googlemail.com
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] git: ignore m4/libtool.m4.orig
Date:   Mon, 30 Jan 2023 11:34:53 +0100
Message-Id: <20230130103453.1080-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 68ed0d9a3..3e2164420 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@ INSTALL
 install-sh
 libtool
 m4/*.m4
+m4/libtool.m4.orig
 Makefile
 Makefile.in
 missing
-- 
2.17.0

