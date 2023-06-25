Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C156EB64DC
	for <util-linux@archiver.kernel.org>; Sun, 25 Jun 2023 11:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjFYLbq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 25 Jun 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjFYLbp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 25 Jun 2023 07:31:45 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA750F9
        for <util-linux@vger.kernel.org>; Sun, 25 Jun 2023 04:31:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3fde8e4d321so17174861cf.2
        for <util-linux@vger.kernel.org>; Sun, 25 Jun 2023 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687692704; x=1690284704;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRhlhob3SRy0urAeFiE2lQNKLq/cjsHAdmBY4irNHc0=;
        b=PreafI3EssE1+1zd2u/quqwyLWLod7+XMdbVtyEZ879BHrrWKW6zgkX3wN+QFSUgWP
         kMPwSDt8hMHiWMsAZWnSyfPKssljBmNguMjXTAw3QJEemZ38tRWTuaEdNVGXvLIAv5CQ
         a6Jp1Y+sRgcRyvPUYeQOdORfbFbHJHPl4V+6q7trzkwiLck8UlAl5MUxmnRL2fhVBIGW
         E8uz0vXPKg9CxwMpj14ofBK/9KGzXT9MQutfMOI7tQBHkpIKWMS9ulH02QfcBZHuPsEG
         BEjTfwpdMTyGxn0/y0jMdod6r1zN9WtY/87ZE/NDWFkgYFItXmfLAwQ+9Un8cONn4STA
         e6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687692704; x=1690284704;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRhlhob3SRy0urAeFiE2lQNKLq/cjsHAdmBY4irNHc0=;
        b=bjcupEyI2TL0ZSGt5YRgyhOcx5sqYdAMzT9jF+zbb/7V+VtSRVhyQS4iPupeZKbLz7
         20OjbhoYjiCWNK9PUfa617osCyx0nXpt0erbeBxQzU5Z2fT7+PUzbTu0FjrtFZ2RPxF0
         4JOZPMC9QLCybiwsD5WtM9H4YvNKI8bxeBV4akueBCb0+la2ppNKnBLBFvG+jeBj3Wa7
         w4OYd9mAoUseP3hTZsOMOr572Pun6SGSzsrlwPnmK38SX0sBWE+UH7E3/8FP1qwHnfQl
         f2aJXjUyVudIfpnvS8y2MSbbB87w6yDMxWoh6FZHt07BCzxyz2TbbKIDs4B2Njl4TR7b
         jXIA==
X-Gm-Message-State: AC+VfDwiST+KwCqdZHv7jubky/Puw4hxn+wtZyud7sYv3jufVir6+Lj+
        qZgJWE5HwviqMZVnd9/oF7MigKS4qJ6VJJK9kIhe/d3/wUl9mg==
X-Google-Smtp-Source: ACHHUZ4p5l0wdYewu5K5APwlZmmtyllwk45CqTlKrUeGc3KjFh8oxpD5W3QkurH+9abF2zIbs71W7ZeqBQ2PLPVmJU8=
X-Received: by 2002:ac8:5750:0:b0:400:994b:2183 with SMTP id
 16-20020ac85750000000b00400994b2183mr3038137qtx.67.1687692703857; Sun, 25 Jun
 2023 04:31:43 -0700 (PDT)
MIME-Version: 1.0
From:   Florian Zimmermann <florian.zimmermann@gmail.com>
Date:   Sun, 25 Jun 2023 13:31:33 +0200
Message-ID: <CAJed8sMYhw9iYSBN5XqdJiJkiqrciT+yudDBZBRhN8pnfc6CaA@mail.gmail.com>
Subject: [PATCH] cfdisk, fix behavior after writing changes
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

after a successful write, cfdisk remains on the "Write" cursor and furthermore
when navigating to "Quit" will continue to  show "...without writing changes",
despite there were writes. This patch addresses that.

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=927041

Signed-off-by: Florian Zimmermann <florianzimmermann@duck.com>
---
 disk-utils/cfdisk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 2e29421d7..a05a50f3e 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -2530,6 +2530,7 @@ static int main_menu_action(struct cfdisk *cf, int key)
                        else
                                fdisk_reread_partition_table(cf->cxt);
                        info = _("The partition table has been altered.");
+                      ui_menu_goto(cf, 2); /* after writing reset
next action to Quit by default */
                }
                cf->nwrites++;
                break;
-- 
2.39.2
