Return-Path: <SRS0=om+s=W6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C27CC3A5A2
	for <util-linux@archiver.kernel.org>; Tue,  3 Sep 2019 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E716F23400
	for <util-linux@archiver.kernel.org>; Tue,  3 Sep 2019 16:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0dOv98H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfICQlS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:41:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36133 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbfICQlS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 3 Sep 2019 12:41:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id g24so19168644edu.3
        for <util-linux@vger.kernel.org>; Tue, 03 Sep 2019 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlQVJWnNxf6e9ka47favFbkJgpQ1M35SL6MQEFN/peI=;
        b=s0dOv98HTPPmbYK04UorKBjlb0NwHetZoKfyHw1LYuQU392rTCXgk3aF477xOvRMkJ
         PGTksnXRni6fc+qR91JPAVhP+yIaX75ydku/Zd1rHK2oO8t74ODUTdGDwBlPvIVlalzP
         3mXIvQnJhMolRigZMSGJTv8amkdR5eP8vMEk6/uudRHn0UHar+qgkLOT4wR8k88Qtlvb
         OX8fldChXAM5SHKr1X7u+klOiqbP7TOTyxA5rCKEum/JKStANgOdvAtGV4FqVa1d08cD
         LUOdgTIdcfkf6sLLlFdaKahZRRL9ydPo3+6tiMMepMriQ3qjUgAbb/5B6u4trnYxKH6x
         lMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlQVJWnNxf6e9ka47favFbkJgpQ1M35SL6MQEFN/peI=;
        b=pv8DSE3WbFpCIx8xz+G2lBHpVOFPuwSBqGRR20uiFyyb/cx5taF4H4wvKDbVg9k/XI
         QxCDbB/qERss20otABYoyQW5qniE1ZZrglvTBmy9zLEgVt0a35oZVbWx4hU/7kxdD15r
         MUeHgSyH7GZ9lOqUl2+r+i5jC61NJElR/05m4cF8SsdVwz/ZNqyj51TIx9+Cb7wciJA3
         OsAAZaCLdWmcf8LYVNT8V0a0LkWmCKZmB7kUApegUcxkeVjZnCC7KqJcEgWUFgHMykMX
         c2+0RwLvqqVOcumwiT+MISCY5XPP4qWGh51CJ+ujLC07Gjxr4gBFyV1Nv1BAnYoAGuoi
         ZMMw==
X-Gm-Message-State: APjAAAXN00pSP8oZiE1srZrJRsqLcTZLF1HKfUAcR40RIq1LimjFfHRO
        lcWp2ffYO29EBE28j8zfY4ewEPLI9Js8TeqVjMI=
X-Google-Smtp-Source: APXvYqyZl2GrGJXLGY15NPe13iYoCaZhw3kp+z38At0MetiFCthwFO0Gduz15f3I5016QrFRmhEhdNsY0VoMCVjmKqg=
X-Received: by 2002:a05:6402:1594:: with SMTP id c20mr36946295edv.130.1567528876170;
 Tue, 03 Sep 2019 09:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1908291142470.17653@file01.intranet.prod.int.rdu2.redhat.com>
 <20190902105909.ah4pi4nwjefygskd@10.255.255.10> <CADxRZqwURQJMCCAkY8TvjBaQnCL9j1AHN3mY6b1q3bN-VCZRyA@mail.gmail.com>
 <20190903130150.iatqincnxf4re7ce@10.255.255.10>
In-Reply-To: <20190903130150.iatqincnxf4re7ce@10.255.255.10>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 3 Sep 2019 19:41:05 +0300
Message-ID: <CADxRZqz0-yfEk1qg7xtVCS0GEdXqM7JEwzz_FXkZLW9Ovd0HDg@mail.gmail.com>
Subject: Re: [PATCH] blkid: retport block size of a filesystem
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 3, 2019 at 4:02 PM Karel Zak <kzak@redhat.com> wrote:
> > $ xfs_info output/blkid/images-fs/xfs.img
> > xfs_info: V1 inodes unsupported. Please try an older xfsprogs.
>
> or we need to add another xfs image. I guess we want to support all
> versions.

Karel,

i've created PR about newer version of xfs.img
https://github.com/karelzak/util-linux/pull/856
