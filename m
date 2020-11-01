Return-Path: <SRS0=Doaa=EH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208A9C2D0A3
	for <util-linux@archiver.kernel.org>; Sun,  1 Nov 2020 14:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DBC2158C
	for <util-linux@archiver.kernel.org>; Sun,  1 Nov 2020 14:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPQTy9jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgKAOQM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 1 Nov 2020 09:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgKAOQM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 1 Nov 2020 09:16:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD85CC0617A6
        for <util-linux@vger.kernel.org>; Sun,  1 Nov 2020 06:16:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w1so11584876wrm.4
        for <util-linux@vger.kernel.org>; Sun, 01 Nov 2020 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=lnpj2oVjg1wyK3/p88LvP52mIL2AwMRd5asaqtK1Wp4=;
        b=hPQTy9jmWwvXlzUS/JYJXyrNL+6Q1PU+GCYHrPixP8cklK0+N8kywg9jo0I06uIjaM
         QI9wEarrsBNkz4pcQh2RAbVyzLmA0OuP0wqptnXGCeO5KUBB6XgfbwpuxmuPNLo6JKIA
         FkLqdKzfQJHqbgSB2dk3gAolYBJX6nTrpeXm5E7b7Yb0OyeH85zq0mT+nu941B1yXSi+
         XtVqYfwMlhPiXCoNzGoVax6fyHUbJml6D9urVJOu1Y/+JugIUv0hcGs5WbZI56WHnF1B
         bt8+sQog9rlMS0CQy08fy+O7jC1zC4U78LRMzMwB79ra55QLLYYzvmj8vwlLELXDyipN
         drYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=lnpj2oVjg1wyK3/p88LvP52mIL2AwMRd5asaqtK1Wp4=;
        b=jXvM4mkF4w3MQ0tBOHG6wcNuwkZdsO7+net5cNYjzX+woJoJ+dDbXr7QHKJjGmO95M
         Q/PbP6eCWFk6OnKDNoSHXR/NhTOPfLYxnz3VLXItk6p8EFtpKCAglkn8+DLSZirRr854
         Ue/xwF0H534TTZk727HlfBZieqC3fIS5G8S7S0epuzxLbMjtLBmccwGtBcobAcb+YYyo
         1H/xwXJ+aSqYYQtXRwLy5S2hoClr5IINAZiFAYTbyEO/enkwGXvqgZtXJYs1xFgyQN4f
         mNOFQ76uwh7ZzNKLHsBvfliScVZkgC71R7uXkIM1qghiLPqDWFfcQIwgWbUmgJ/T9QvG
         0hsg==
X-Gm-Message-State: AOAM532+ZwCr92xYV5FlW9QlFwM6C8VHXss4CTClX0whfQBCTml6ho39
        k5Yk7MrjWBvRVYf4TnNjDL9RTyYrPZ39Zw==
X-Google-Smtp-Source: ABdhPJyJpaWdge84uYLemx+okqfxiuYwsB4Op3pz3kRfKRdLsaQK/Xa++H2MG0oBaeG4cQv23TkHrg==
X-Received: by 2002:adf:a551:: with SMTP id j17mr15616734wrb.217.1604240170074;
        Sun, 01 Nov 2020 06:16:10 -0800 (PST)
Received: from z600.home.lan ([213.31.227.225])
        by smtp.gmail.com with ESMTPSA id b4sm10471758wro.57.2020.11.01.06.16.09
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 06:16:09 -0800 (PST)
Date:   Sun, 1 Nov 2020 14:16:08 +0000
From:   Sad Clouds <cryintothebluesky@gmail.com>
To:     util-linux@vger.kernel.org
Subject: Bug report - Solaris 11.3 conflicting types for 'random_get_bytes'
Message-Id: <20201101141608.ba365cf67d92ee3973226de9@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mcookie fails to build on Solaris 11.3 since it already has
random_get_bytes() function with a different signature. Please rename
it to something different.

===> Building for mcookie-2.32.1
/opt/pkg/bin/bmake  all-recursive
Making all in po
  CC       lib/libcommon_la-randutils.lo
In file included from lib/randutils.c:29:
/usr/include/sys/random.h:71:12: error: conflicting types for 'random_get_bytes'
   71 | extern int random_get_bytes(uint8_t *dbuf, size_t dlen);
      |            ^~~~~~~~~~~~~~~~
In file included from lib/randutils.c:19:
./include/randutils.h:14:13: note: previous declaration of 'random_get_bytes' was here
   14 | extern void random_get_bytes(void *buf, size_t nbytes);
      |             ^~~~~~~~~~~~~~~~
*** [lib/libcommon_la-randutils.lo] Error code 1

bmake[2]: stopped in /opt/pkgbuild/objects/x11/mcookie/work/util-linux-2.32.1


