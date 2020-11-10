Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F826C388F7
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 18:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CEC206F1
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 18:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJQn69pX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgKJSuU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJSuU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Nov 2020 13:50:20 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05FC0613D1
        for <util-linux@vger.kernel.org>; Tue, 10 Nov 2020 10:50:20 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 13so6369533qvr.5
        for <util-linux@vger.kernel.org>; Tue, 10 Nov 2020 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HU8txIXq3Qt6/G+wNwa62yfbjaJw25qlH2VtxdD3hzA=;
        b=dJQn69pXe5bkTPj0jMwQjtcb0dnY+ojprJh2HpPh2/a00yoEtZ1sgoubwyLqkMlyp4
         qpyk70zJ7ddUc1l0rWsNqnCsyEVQRuyZaMhCFfd4w+JjLkdaJs8qJCvF2FebI2KN4SB5
         Lwjh5wmIqzJga34chGrwxwuzrgDRixzlOteUh5IkCVo1HEB3CiRH0L57mVQs/uSVOpow
         f1ziJrtGVeKusH8VU8fU8BiyCKF9pMdm8TqLjcHH03O+vrfP6GVB8rE0d3vK7agYjfnn
         Sa6+jdU4dm6as00GPz1ZMgWbLn4SJQUB8ys8TYV4BPSd5EBffLY+V0pjnb/1gMtVBI5q
         s/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HU8txIXq3Qt6/G+wNwa62yfbjaJw25qlH2VtxdD3hzA=;
        b=DK7NXCkUFBCmYPeis1WKou7ZZNoq64ny/9yqtYeI0Qpbh7iKjp5lSDFI/VXIeE7q5f
         7OqwPU0UZG7TnF8+QMgJqZzY3phld6M6HcWKesFXQBIhPuPh3eYabe7qPh4FUEHDdhYo
         y5xB0k15O0S6QeQo4sRg20dQat5y7C9yQVs2sLC35BQRqd42vgotQtr5hrdm+Bu0oSRn
         Lk6KeB3HGEEDPnsDxuAEZyo46+PFbBXqq/0P/mWZ46xR7pfknViCbIWjuT8QCmVDdVA2
         b1f7IKOImsXdpS6bXp0Moy/Uxjcn5DtTHqdxRUgGrior1tovGFIFHDBjL8l7l14600K2
         NtYg==
X-Gm-Message-State: AOAM533Y1M+0nNil3TYfz4JBCLjL8jv16tRaw0EL98Pvao7QS4Gnz2pb
        JaczjnsvHz5JZemqiUaK9bs02XBTCQ==
X-Google-Smtp-Source: ABdhPJy5PPVri816vSIsbL+p6u4EdgysU/ZkiaUQ5tx/PIZnJei/MDnQRojUfOYQvn6zPPOWWdyUug==
X-Received: by 2002:a0c:fb06:: with SMTP id c6mr20523701qvp.10.1605034217672;
        Tue, 10 Nov 2020 10:50:17 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id g13sm8494497qth.27.2020.11.10.10.50.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 10:50:16 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:50:15 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Karel Zak <kzak@redhat.com>, Jeffrey Bastian <jbastian@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     util-linux@vger.kernel.org, m.mizuma@jp.fujitsu.com
Subject: Re: [PATCH v4 2/2] lscpu-arm: Remove hard corded model name of
 Cortex family and X-Gene
Message-ID: <20201110185015.dk6xhlzdqrurlh7h@gabell>
References: <201fdf4b-5238-6e39-8883-f1ba0dbca4a5@arm.com>
 <20201110083712.kfisfq4yv5yadx4w@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110083712.kfisfq4yv5yadx4w@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 10, 2020 at 09:37:12AM +0100, Karel Zak wrote:
> On Mon, Nov 09, 2020 at 11:19:08PM -0600, Jeremy Linton wrote:
> > I don't agree with this, I think the hard coded table should be the first
> > authority on the manufacture/part number lists. That is because SMBIOS isn't
> > available on a fairly large number of arm systems, and on systems where it
> > does exist, it suffers from the same kinds of problems that exist on many
> > !arm machines. Its not particularly a reliable source of information.
> > 
> > So, maybe if you have a situation where the SMBIOS information is more
> > correct than the hardcoded tables, maybe its a good idea to create a new
> > line?
> > 
> > 
> > Aka:
> > 
> > Vendor Id: ARM
> > Model Name: Cortex-A57
> > BIOS Name: JoeSmithsCore
> 
> I like this idea. 

Yeah, it's s great idea!
SMBIOS Type4 also has Vendor Id (Processor Manufacturer),
so the following is better?

 Vendor Id: ARM
 Model Name: Cortex-A57
 BIOS Vendor Id: Foobar
 BIOS Model Name: JoeSmithsCore

Jeff, does the above idea work for your case? X-Gene(eMAG) will be:

 Vendor Id: APM
 Model Name: X-Gene
 BIOS Vendor Id: Ampere(TM)
 BIOS Model Name: eMAG 

Thanks,
Masa

> 
> Note that for majority of our users know, use and expect names like
> Cortex-A57, but I have doubts about "JoeSmithsCore" :-)
> 
> > In the vast majority of cases I imagine the strings should match. The
> > problematic cases are LTS os's running on newer hardware. For that i'm
> > somewhat of the opinion the Model Name should remain "unknown" rather than
> > being silently updated. That is to avoid cases where the output from newer
> > lscpu's changes during an upgrade.
> > 
> > PS, Having this hardcoded table isn't optimal, but for now I think we are
> > stuck with it. Hopefully at some point we can work out a reliable way to
> > source the info. In the meantime, it looks like I need to submit some table
> > updates, since there are some newer arm models...
> 
> Yes.
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
