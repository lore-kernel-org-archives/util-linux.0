Return-Path: <SRS0=IkIy=TH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EA2C004C9
	for <util-linux@archiver.kernel.org>; Tue,  7 May 2019 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B9420578
	for <util-linux@archiver.kernel.org>; Tue,  7 May 2019 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmhe/K8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfEGMzz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 7 May 2019 08:55:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33537 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGMzz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 7 May 2019 08:55:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so9156402wrs.0
        for <util-linux@vger.kernel.org>; Tue, 07 May 2019 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVffNenMJj6n+ZPRKnuofP1ln7UkLaiMwpx1dUSC4Qc=;
        b=rmhe/K8dX5A0Xys1HTlgRL0DZh1SoFfkm6S5e6rSQ5QA1YvkTSaWh+wJGBTefnmx4a
         TIGei782xMPIdE+YqbK+Tb5l67LqrH2Z2VpW99N5vzTtfFShsL0AiLVVyih3X2Sf736A
         ajHXGYNKKTmdEiE+Qs99sVpVf8QcbUtsGw7u9bYJwUz+mvR/pIAANNPVhZKN6G6J6E2U
         yGJWVmieIRRqzXKR8tEk3JpkQg6qtio2VEiyfXxUKaLKqhp4653NqEhjzlEJlyKcHnht
         4EY9F9xdmNFmelzoeOyTBwHqvAI8vvQHbsWXjpWN+sJeApEQLyszhh+gZNa1aBBy0IXU
         j0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVffNenMJj6n+ZPRKnuofP1ln7UkLaiMwpx1dUSC4Qc=;
        b=jMlbQe6hJxZYNKEww6byD9pSgaZCo/Uk2983/X8nAr8wH8wltbNpbbdojy7R81x3YH
         mJrnl574uQ8GrfMr0+qFRWytLpuYEe4pTq4UiySYGzRNexUQUX1K2obOJCVsSACgz8aV
         BTo53aNqS7tXfyd7/li3vGcLYN0V2X+slbGuKuAOTY1KXeuVcTf3FiUL5wrNyOMTJ0vg
         aNnrkk1t8ZwmtjZkHjm5zSc2LfEwbHtxuHJJTGZPdCofz8UkKVywzVIJpXPStbpZh5bz
         8wkV4nGqA157+jsJiBmrehUs+2HmuSD2Zv5ZP+1L7wjjzq1jT+6e3ZCHITdO+d6EyMSR
         0t0g==
X-Gm-Message-State: APjAAAVEWiRKFrvIa2lDyEj6S/8aZax8N25d0iq1WpmkxcrjHWbunk3m
        JxtYGDMKMVakLwQxR6SdeibPsUATpkm0RzK4ths=
X-Google-Smtp-Source: APXvYqxJbVPv+hwQJd0r5QaI8VitQQesAdYc3GKBwHSTlw5ZXFObkoa5Ay5omDRBzJSaeM7hd22Yo9xJ3Roo1SyUFN4=
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr4203494wru.260.1557233753701;
 Tue, 07 May 2019 05:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ4jsae=RUFEX2+2+8YG_tspTzqghMgupMfT_adYnG9b_xUVxg@mail.gmail.com>
 <20190507103055.lqamhi3qbbp4er7l@ws.net.home>
In-Reply-To: <20190507103055.lqamhi3qbbp4er7l@ws.net.home>
From:   "Carlos A. M. dos Santos" <unixmania@gmail.com>
Date:   Tue, 7 May 2019 09:55:42 -0300
Message-ID: <CAJ4jsacmP4e4EpnXSPL_C0Zd7GuwJvyrTqmPeirukDAYW7L5ow@mail.gmail.com>
Subject: Re: Building util-linux libraries and utilities as separated operations
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, May 7, 2019 at 7:31 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Mon, May 06, 2019 at 10:22:51AM -0300, Carlos A. M. dos Santos wrote:
> > Would it be possible to build/install the libraries first and the
> > utilities later, using the previously installed libraries? That would
> > help to solve a chicken-egg problem between lsblk, and libudev, as
> > described in
> >
> >     https://bugs.busybox.net/show_bug.cgi?id=11811
>
>  It always uses in-tree libs to compile in-tree utilities.
>
>  Anyway, all external dependencies are optional. For example you can
>  compile lsblk without udev. It's also possible to specify wanted stuff,
>  for example:
>
>      ./configure --disable-all-programs --enable-libmount \
>                  --enable-libblkid --enable-libuuid
>
>  to compile only libs.
>
>  The best way is probably do it in two steps, in the first step
>  without dependencies, and in the second step rebuild all with
>  dependencies. For example:
>
>  stage 1:
>     ./configure  --without-ncurses --without-tinfo \
>                  --without-python --without-systemd \
>                  --without-udev
>
>     make install
>
>     ... compile udev, install libudev ...
>
>  stage 2:
>     ./configure
>     make install

This works but the libraries are build and installed twice, which is
undesirable. Is there a way to skip the library installation in the
second step?

>
>  If I good remember distro bootstrap with util-linux is nothing unique
>  and it's used by Fedora, Suse, linuxfromscratch.org, ...
>
>
>  IMHO distro bootstrap is very special situation. For regular updates
>  is probably better to build util-linux in build root where are
>  already installed all dependencies (e.g. libudev) from previous
>  versions.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

-- 
Carlos Santos <unixmania@gmail.com>
