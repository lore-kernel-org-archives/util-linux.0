Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2303EC2D0A3
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05842064C
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 18:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSj9MhSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgKISvb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 9 Nov 2020 13:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgKISvb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 9 Nov 2020 13:51:31 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF948C0613CF
        for <util-linux@vger.kernel.org>; Mon,  9 Nov 2020 10:51:30 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so6761329qts.5
        for <util-linux@vger.kernel.org>; Mon, 09 Nov 2020 10:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MgOecWcksXzCXgMzcVJDeYtqUlKdg1CtC51oS5mMjRc=;
        b=KSj9MhSM6zzomq6NxeYs3cnmY/K+4Su0YSaGGZrei16COILg6ph/1BViDhn/M8X0P6
         zhTZWKzjIRECq9QMVbG+fuZ6ZfjpsBPEUKcoYrKyHc8yVXraHq8VRbjzkwcEG7jNAEeR
         uLA6fr5mfUqpOHqCnqCRwuxvBdN3d1Mh1LzQEzXI0/9wYvwyGoiQ633rNNqYV2xLRY41
         /mKZtgr6uFehD0g127hyRPq1BY9vuaaME9qmdp0CVsa9agdcIrcsm+ZQRqIIcdzhLe61
         tONi54JYHjnWXgouk1cF9IjcMgF5ztyM9FwKuVv3KccVlRRqxM1yF8hCrfZ2nIyVzZTT
         rY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MgOecWcksXzCXgMzcVJDeYtqUlKdg1CtC51oS5mMjRc=;
        b=f+r7FBquWOKa7WO8xKgj5svNcEy4qWkKx7SRD2odAH5UISbsEoI0ZYtGw6o6pKp/ET
         r+vdgr5S5tWtCrCd7JR12m3UlPQwLXqikQiphDXgGn9gQyOTN4aCfj12KEa66RACpOue
         F1Pm7EZSaSaiH4onlFM69rstoKctRLdbXsWwFzwE6mkVpCqoYj/p1tDwT/qz0p8oQqBE
         UsuvSTsUNR2RSNqDdycf2yW+syhxEuy79LAxtnhctGGW/1GD97dTTDJFly8fXV6ipm3z
         9hF23e1lGPXZ9Ibph9lWO0Lo3LUt9oGnuavJBu3gxGUesRrqpAn9EC0bTJDck1HQzZ3Y
         IkWw==
X-Gm-Message-State: AOAM530uzInabnlT5dF+MCy5TLkJiw6mH+AMB/Mob89zqLcASVIKwAsV
        8aNLJZADrlM2rErlbGBilw==
X-Google-Smtp-Source: ABdhPJzFt3r2x/zbbxrZrFdUoXidAvMsb+kCJTW+/Nrm4vIsDj5ADa3Q6wniVrMjrtlW+Io7Ugkp6Q==
X-Received: by 2002:a05:622a:d4:: with SMTP id p20mr14392872qtw.172.1604947890249;
        Mon, 09 Nov 2020 10:51:30 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id a20sm5635566qta.6.2020.11.09.10.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 10:51:29 -0800 (PST)
Date:   Mon, 9 Nov 2020 13:51:27 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, jbastian@redhat.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v4 2/2] lscpu-arm: Remove hard corded model name of
 Cortex family and X-Gene
Message-ID: <20201109185127.imanchj6texi6lyn@gabell>
References: <20201109030403.26821-1-msys.mizuma@gmail.com>
 <20201109030403.26821-2-msys.mizuma@gmail.com>
 <20201109162331.blv7jd3gtui7es4o@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109162331.blv7jd3gtui7es4o@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 09, 2020 at 05:23:31PM +0100, Karel Zak wrote:
> On Sun, Nov 08, 2020 at 10:04:03PM -0500, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > Remove hard corded model name of Cortex family and X-Gene so that
> > lscpu can show the model name using Processor Version of SMBIOS Type4.
> 
> Now I see on my system (Fedora) that:
> 
>  $ll /sys/firmware/dmi/entries/4-0/raw
>  -r-------- 1 root root 0 Nov  9 17:19 /sys/firmware/dmi/entries/4-0/raw
> 
> it means it's not readable for non-root users. So, I guess the
> hardcoded table can be still usable as a fallback solution if we want
> to provide readable information for non-root.

Thanks, it's a really good point...
lscpu changes the Vendoer ID and Model name depends on the user privilege.
I think it may confuse users.

Why don't we remove Vendor ID and Model name when non-root runs lscpu?
Or add a message to get Vendor ID and Model name like as follows?

    $ lscpu
    ...
    Vendor ID:                       (Need to run as root to show)
    Model name:                      (Need to run as root to show)
    ...

Thanks,
Masa
