Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381BDC433F5
	for <util-linux@archiver.kernel.org>; Fri, 17 Sep 2021 14:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1681861130
	for <util-linux@archiver.kernel.org>; Fri, 17 Sep 2021 14:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhIQOU5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 17 Sep 2021 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhIQOU5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 17 Sep 2021 10:20:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA986C061574
        for <util-linux@vger.kernel.org>; Fri, 17 Sep 2021 07:19:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w17so7301717wrv.10
        for <util-linux@vger.kernel.org>; Fri, 17 Sep 2021 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=BkW6REHOf5w0ULuxEbmrpd5vv2yLOqvXAmfbyYA0tRk=;
        b=l7ePGJHp9BL1FZs1Y9/+kpOt4cbCfZzRMWTVp/FkcU1/f81AZNufgOYJMtHyCSZAyb
         VcjKhtJ9cRviM6vnWpqz1UFORW3tdM59iWaf53+s3UUkNvXJlwg8qA4eC/fDnRvjbauv
         2RvEYfu4W52/Lrwxn4XbcaqXkqzIGi5YYKWVaG8hE0tbqVNYswnrw3CGW5dyc867FzGs
         g2uLUZGOfSc/Efh+dHNl74di/pbm+snhxoI9Sw0/zilAuZFy32hdAcrQ8O/l+cW6KUg3
         QmUA/GTCvSFpmVtjkFCzWc4h5FS3O9hPl6RQ6WHoRlj97yCWYLHnMg5E1tD3deSKMk9P
         inlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BkW6REHOf5w0ULuxEbmrpd5vv2yLOqvXAmfbyYA0tRk=;
        b=YGO5Qu2S9beRH2BFhFyG8ssL8wuqqImHSw2IUb4lPjUqO5/24W7s+moogYLnmOr6o6
         9962LZktKBor9XydHbL63MwrB8k7R2CEGDy4nVzudJRsq7RsPt+cbHor3qSvjfmfRfO/
         /s1S2yQ4eTy0ONmSVrp/mmuJ+u1KNC/BKpoiPj3PkL/9czM+YuAYJC1L11e6COEpSbmt
         zr4PawfohWx9uocaj/87uDL4o9hDHi2rqxw+QWjy2R0Gx/dK+SmsA4HXf8y1uj6WOnRI
         9PF8UMexf7h7BRhsgU03WO5S8uaAMVMji1wRgQPTUfcQCWZS4fewxqJcGRcP8nPOtk/n
         O6Yw==
X-Gm-Message-State: AOAM532iIIkJ63eHVqrnOy/2/bCELJlpx56aISmObzflAaR0LTOsd/GC
        1tSfxjALQt+Y7CCRHeJP+zMZpI1/uFMWcNzBRpTdltWLMto=
X-Google-Smtp-Source: ABdhPJxAWepcGEfTqxAG2HAsUj3oji4rj4V8TebltF/pwM2RIqUGS08phnxwsnih4qozX3PgcF7GQjoDyAM3RYLrcuA=
X-Received: by 2002:a05:6000:1a52:: with SMTP id t18mr12156835wry.21.1631888372983;
 Fri, 17 Sep 2021 07:19:32 -0700 (PDT)
MIME-Version: 1.0
From:   Eli V <eliventer@gmail.com>
Date:   Fri, 17 Sep 2021 10:19:22 -0400
Message-ID: <CAJtFHUTWt02hsfqpcDmaw2F+trWwm4yjBZO0FK_jpxX-4QhcSQ@mail.gmail.com>
Subject: Would be nice if lsblk combined multipath disks
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

lsblk is awesome for viewing a system's storage stack. However, it
would be great if it just spit out the list of devices sharing a
multipath name instead of repeating the full tree for each device.
lsblk -i from version 2.29.2, only one tree shown but the exact same
tree appears under sdai as well on my example host.

sdce                             69:32   0 838.4G  0 disk
`-mpathal                       254:44   0 838.4G  0 mpath
  `-md1                           9:1    0     9T  0 raid10
    `-cryptmd1                  254:55   0     9T  0 crypt
      |-cryptdbv-dbthin_tmeta   254:56   0   2.8G  0 lvm
      | `-cryptdbv-dbthin-tpool 254:58   0    15T  0 lvm
      |   |-cryptdbv-dbthin     254:59   0    15T  0 lvm
      |   `-cryptdbv-pg         254:60   0    15T  0 lvm    /var/lib/postgresql
      `-cryptdbv-dbthin_tdata   254:57   0    15T  0 lvm
        `-cryptdbv-dbthin-tpool 254:58   0    15T  0 lvm
          |-cryptdbv-dbthin     254:59   0    15T  0 lvm
          `-cryptdbv-pg         254:60   0    15T  0 lvm    /var/lib/postgresql
