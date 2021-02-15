Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D3C433E0
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 16:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A1964DE0
	for <util-linux@archiver.kernel.org>; Mon, 15 Feb 2021 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhBOQB1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:01:27 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:40758 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhBOP5X (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 15 Feb 2021 10:57:23 -0500
Received: by mail-qt1-f177.google.com with SMTP id v10so5101696qtq.7
        for <util-linux@vger.kernel.org>; Mon, 15 Feb 2021 07:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcpQd+6AqffJ4DXyyGprnmnyHdxOIncbBY5BtOe1g10=;
        b=ntWV0CK0gNL4FUD+cG3tw6hRvOs1cJIrfsPFzKdWZ5PSQdV2A8ygUzD0NBUL7h9li/
         SkGFfYTbn+L8+pRZ5dmWzcsXGCo2EvVKGbMbA14Z/gpsSIstXZ5215E9x7sVPnzypPkc
         C46GjRNqy+7kEV01Ng1CsV+zckTBsxMTi5iWi4FDQuyhRbFz2gDF3gmAz3Ll2aR7PxaQ
         doSXMWZLv4Vl3MV/wy20qXpzYexOVpBYzW2Q0GHVx/JW0gsXKuRlqbaCU+UA8oRoCnrP
         D5uRWZ5pIyMK0Xdlx3yt3MdDgn02C8ZN/JwCq1MLwqD3R7h+pUoCTNFuLYwr5BnQZrMb
         G4cA==
X-Gm-Message-State: AOAM530DkNjrke98rm5sOxEQCLjrldnKjd8gx0jz4BmJwl5tpSZrRm5y
        j/MYddeoRFsvKKCSMajKipMWtBSi+0F+EeNIJbQ=
X-Google-Smtp-Source: ABdhPJwNeODEy/iFrFNSlya9pXuBpw1H9li0eiHxYe3I/CIrl8HRJRG+JKs6wVHqrA1K8YIXQl7OgPN2U98tpUVxgk8=
X-Received: by 2002:ac8:47da:: with SMTP id d26mr14419032qtr.28.1613404599787;
 Mon, 15 Feb 2021 07:56:39 -0800 (PST)
MIME-Version: 1.0
References: <CADjQn4h=J-K=HdGc-WJHLeK4WfepRbjsTL3EWbwfwDwJxZosXw@mail.gmail.com>
 <CADxRZqwFoot7RdX0nX6suGu1_9+JUxTVZew0OHQCRObyMvPmNw@mail.gmail.com>
In-Reply-To: <CADxRZqwFoot7RdX0nX6suGu1_9+JUxTVZew0OHQCRObyMvPmNw@mail.gmail.com>
From:   Diego Kreutz <kreutz@acm.org>
Date:   Mon, 15 Feb 2021 12:56:28 -0300
Message-ID: <CADjQn4j7tNwNoRg+3Hf5h=XT=aHQCwhSt4NaYJS0eZ8u-31-fw@mail.gmail.com>
Subject: Re: [bug report] cal command segmentation fault
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

hi Anatoly,

sorry, it's from bsdmainutils. it's ncal, actually.

sudo apt-get install bsdmainutils

best,

diego

On Mon, Feb 15, 2021 at 12:49 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> On Mon, Feb 15, 2021 at 6:31 PM Diego Kreutz <kreutz@acm.org> wrote:
> >
> > Hi,
> >
> > I found a bug in the cal command. It is a segmentation fault for the
> > following input.
> >
> > cal -d 20210516
> > Segmentation fault: 11
>
> where does your 'cal' command comes from? i can't find '-d'
> option/command line switch for util-linux cal
