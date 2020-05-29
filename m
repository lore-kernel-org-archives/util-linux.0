Return-Path: <SRS0=/i5r=7L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968CAC433DF
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 13:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B0A20721
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 13:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwkMgDVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgE2NWg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 May 2020 09:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgE2NWg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 29 May 2020 09:22:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40EC03E969
        for <util-linux@vger.kernel.org>; Fri, 29 May 2020 06:22:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k11so2044513ejr.9
        for <util-linux@vger.kernel.org>; Fri, 29 May 2020 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRm1HDrbEltfTPN1ULzdtEiBjm/S+2QCF6oF7O1t1mo=;
        b=LwkMgDVUi9vPLhg16WtdHGNXN4pZX8Mnd18BrziYRXvkJhqzWEJI81SSxU3vWZ0lV2
         7k2NNDsDuS+ubTVjK3FhwmTL7GBnxzd7dFmXiUcpSBX5DyCom7bL316zUH1TqvranK71
         bAyagL/ADFiopU7c3fzQEmxJnM9hJN8YrcK7zZIw2KffFdnrNsDJuEmxIHBjU5r0e1ou
         z3IdGeygxrbQtuaYc0AnkcSqYNA3xLdvEXLO6mR/aGxp3VtPomW0/YCh6DaDJZAJoCxJ
         IMi3T8SehjkQGhaWkU46+cg4Ypnd/unNSd8yZC4NFcp63LpQbq8OdgWZ3d8WAz81ZDmr
         bWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRm1HDrbEltfTPN1ULzdtEiBjm/S+2QCF6oF7O1t1mo=;
        b=sq8b74ufxS2HIFFYasTiiZRJ3/+AICbTrE+bu+OVrbXdaGWLHBHS5xQvSpuxyvJwzc
         nS7PFz0s2K7hFrQ5XfevOuoRBQAgDh0q3yGjcZThvp8RyvOD8QRQSUEE/p0VhSFRJSl7
         ct6vz+GmG0vdZ9R0DBq9Rwe3wg6eDetdruUwXf+EQ7SrvxHUFEev25aokpLuD7EN60U4
         iJHsl6vTACEXv77fRr1STHeTbQejxnLttR4ViuLNTANJfYtR0ErNTOMptnc9C0f9EMPh
         moXCy0Ka+txbZH/CLIH5OgDM86A0Ga7hRXi/N63ub9C62He7kQYyUdmcr5ViZleAN4dJ
         qgHQ==
X-Gm-Message-State: AOAM530Lms+wHsYXxsush/tHcTaGGsucfXXXnsf8EYWC9RXYJSqI2C2l
        9JF3LiTSzZ5mwtQWSCQ2xiVTL84CCjFVSPltqY4=
X-Google-Smtp-Source: ABdhPJzG6FnCuCyQMTtgRcAu13yRvnX6SkYqDyhrkJuwiFcTdonpxlQWzrYfITU2RYeOaTtbQHiB7XbxwAS/h/hP08k=
X-Received: by 2002:a17:906:a88:: with SMTP id y8mr6838581ejf.68.1590758554657;
 Fri, 29 May 2020 06:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200528145823.978508-1-mtk.manpages@gmail.com> <20200529074611.kjzmhxyvee6jxe7g@ws.net.home>
In-Reply-To: <20200529074611.kjzmhxyvee6jxe7g@ws.net.home>
From:   Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Fri, 29 May 2020 15:22:23 +0200
Message-ID: <CALxWeYrnibs7XfoyDWyX9wjAf-n8JUqSpXerQLaDAA7Df=0PVg@mail.gmail.com>
Subject: Re: [PATCH 01/10] Manual pages: unshare.1: EXAMPLES: improve
 persistent mount namespace example
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Thanks, Karel!

On Fri, May 29, 2020 at 9:47 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Thu, May 28, 2020 at 04:58:15PM +0200, Michael Kerrisk (man-pages) wrote:
> >  sys-utils/unshare.1 | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
>
> All 10 patches applied. Thanks!
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>
