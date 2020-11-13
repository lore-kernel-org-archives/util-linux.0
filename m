Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD7C55ABD
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26D920759
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 17:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcXUy5lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgKMRMt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMRMt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 12:12:49 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15284C0613D1
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 09:13:03 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id h15so9406607qkl.13
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JRXAFEjIpi7i+zZU+/sJnxobej5au+0aE7Uw02QX/e0=;
        b=YcXUy5lWKMSI5/UL2/0MXVg65f/7HcCl7ZTljG9FD3HX6g+cJxHqPrkTPb0Zg7DJcj
         DC2koSwKSKZIvK0FH3fUrBxrWar7CCnq4/4mTi+mYNRp5/d5vof5K9vPOU++Uk2B0/BN
         +L6IzSU+BfCWOogoMJrsCGe6SaFZXpq/Cga1LN38VmRc5vtdU/w/AWHdugDL4dkZvGvU
         SekPFK4BzmtKVRzrVOwLn2L2vv7N+bwynEJDbonHIuPxU6Y6PD9eNOBsFKqnW2b+eE9U
         z5pX30aJCDAzlOi1Yhhefi9lq8+1x0rzBL8l5/HdmsShcsywS/gwUtG4jEMQZLTaR7Jw
         B1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRXAFEjIpi7i+zZU+/sJnxobej5au+0aE7Uw02QX/e0=;
        b=I4NnIGlexjeK8jAQDjsrmI1erFkA8xyQYS2UJ+n5wDxMZmy7+Gy90p5rg1xzDJPu5X
         8jroXayxPdJuZ7kWQp4w8rpDdxhwEwq8mHM6+dkN5XiHw2uOCCQwup1Y7d90y2L6aqcq
         WHQpaKyzTcEIoYfdmnWxIw2aUU0JuJrMMonsWi1vix3tazU3LviOSURHho///UESfyB5
         2HtRvMbMR1OHCFx0zTAQDfJvPzLQ1MipUCEWwns+ZI7uy1CjFtpjrdr+9eNdwSnc15ET
         I+6LlYrbekLNPza9fd9yh3xKk91VP/zlsKW9StrbZ94HgDn/bQq2NytJlwYuKGRs/Qr0
         2+KQ==
X-Gm-Message-State: AOAM530NheMMKOKvo8EmRb5E6smJod67+pLPCMtDCBUVsLukVWBohNhs
        +E4v6NOyKkIzJsxa0m2zQg==
X-Google-Smtp-Source: ABdhPJyYQd8I5jhrL6xsZ470oIeRWPUSLtnwX7aeeRdXoSVHlBP8JMj7mO+DZwqhX7fchEvoNdfmBQ==
X-Received: by 2002:ae9:e20e:: with SMTP id c14mr3042607qkc.452.1605287578363;
        Fri, 13 Nov 2020 09:12:58 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id v204sm7390505qka.4.2020.11.13.09.12.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Nov 2020 09:12:53 -0800 (PST)
Date:   Fri, 13 Nov 2020 12:12:52 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] lscpu: Fix socket information on aarch64 machine
Message-ID: <20201113171252.ffy6brgxmdm6lt53@gabell>
References: <20200911135328.1465-1-msys.mizuma@gmail.com>
 <20200914101032.y3dn2oksf4jnbmvz@ws.net.home>
 <20200914123209.hantcnayp6gzswvc@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914123209.hantcnayp6gzswvc@gabell>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Sep 14, 2020 at 08:32:09AM -0400, Masayoshi Mizuma wrote:
> On Mon, Sep 14, 2020 at 12:10:32PM +0200, Karel Zak wrote:
> > On Fri, Sep 11, 2020 at 09:53:24AM -0400, Masayoshi Mizuma wrote:
> > > lscpu may show the wrong number of physical sockets on aarch64 machine
> > > as 'Socket(s)'.
> > 
> > I'm working on new lscpu (to make it more extendible and ready for
> > systems with different CPUs types on the same board). I'll apply
> > your changes later. Thanks!
> 
> Great, thanks!

Hi Karel,

Could you apply the patches?
Let me know if I should rebase the patches to the latest lscpu and resend them.

Thanks!
Masa
