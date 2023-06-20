Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B34FEB64D7
	for <util-linux@archiver.kernel.org>; Tue, 20 Jun 2023 10:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjFTKYT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjFTKXs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Jun 2023 06:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A799DE6E
        for <util-linux@vger.kernel.org>; Tue, 20 Jun 2023 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687256559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/CIANpEebjR/V7Tpo7udK2uGhERjfb6191jT2vwEzsk=;
        b=X/o4sH33C6E4YP5VRwD1GND2yoy4YMjAy6jfsWG0A9Seke61DAAgRo5pWBwJ0grNmC/gGP
        SVNL23zbnK3R8wkFfTdfCjZIAY5NoTVk2OGGSgHbqZlkRqgdbzvIBo94TY+XhY6Eqkn5Xm
        u8hY69xwFvu6Z5aqAWc3ConJKp4xBXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-uM5ofpK0PKKUhO1grO_Wyw-1; Tue, 20 Jun 2023 06:22:38 -0400
X-MC-Unique: uM5ofpK0PKKUhO1grO_Wyw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FAAD89C7F1;
        Tue, 20 Jun 2023 10:22:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D38D492B02;
        Tue, 20 Jun 2023 10:22:37 +0000 (UTC)
Date:   Tue, 20 Jun 2023 12:22:35 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: add support for RTC_VL_READ/RTC_VL_CLR ioctls
Message-ID: <20230620102235.x4ltsqsaw5gtnvib@ws.net.home>
References: <20230613101428.294827-1-rasmus.villemoes@prevas.dk>
 <20230620092628.klpqbr5qw2rdysqh@ws.net.home>
 <e5407336-9330-01f6-1f40-f70c92a256ad@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5407336-9330-01f6-1f40-f70c92a256ad@prevas.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 20, 2023 at 11:30:07AM +0200, Rasmus Villemoes wrote:
> On 20/06/2023 11.26, Karel Zak wrote:
> > On Tue, Jun 13, 2023 at 12:14:28PM +0200, Rasmus Villemoes wrote:
> >>  sys-utils/hwclock-rtc.c | 86 +++++++++++++++++++++++++++++++++++++++++
> >>  sys-utils/hwclock.c     | 35 +++++++++++++++++
> >>  sys-utils/hwclock.h     |  5 +++
> >>  3 files changed, 126 insertions(+)
> > 
> > The patch looks good. Can we also get something for sys-utils/hwclock.8.adoc
> > (man page) and bash-completion/hwclock? ;-)
> 
> Absolutely. I just didn't want to spend too much time on docs if the
> feature was deemed out-of-scope or if significant changes to e.g. the
> option names or other API was required.

Good point. Option names are always the funny part ;-). 

At first glance, I thought that --voltage-low-clear was too long and
that it would be better to follow the ioctl names. However, upon
further consideration, I realize that we already have longer options
in util-linux. So perhaps, choosing --voltage-low-clear and
--voltage-low-read wouldn't be such a bad choice after all.

What do you think?

> Can I send the docs as a separate follow-up patch, or should I send a v2
> with all changes in one?

Select what is better for you ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

