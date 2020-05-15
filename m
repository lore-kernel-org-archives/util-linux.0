Return-Path: <SRS0=YmJi=65=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C021DC433DF
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 07:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3C2205CB
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 07:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBHLZGqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgEOHuO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 May 2020 03:50:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726706AbgEOHuN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2020 03:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589529012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x5lyL9GEFdemyzPMJ9qJwU57nAVDyZhWdISkU1yAlTg=;
        b=YBHLZGqudr69YtYjGku3iEJAunpGEy1Rq/rwPctBtQnUARnYxHbV8imFwmFWbFyhsHDHv2
        3oqW1ZoBo/w5bszLa02eTm1Q8vciYCwBh5if1uvVd9OHa259VfLb1kCW83Icgt4RjL3Hh+
        /ay62WsB3rmSAy28lRtVISL7zKN8ZuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-Pp1dN3hYOdeUurRizKY4jw-1; Fri, 15 May 2020 03:50:09 -0400
X-MC-Unique: Pp1dN3hYOdeUurRizKY4jw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E11CE835B43;
        Fri, 15 May 2020 07:50:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93C1412A4D;
        Fri, 15 May 2020 07:50:06 +0000 (UTC)
Date:   Fri, 15 May 2020 09:50:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Helge Kreutzmann <debian@helgefjell.de>,
        util-linux@vger.kernel.org,
        Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Re: Errors in util-linux man pages, here: adjtime_config.5: Wording
Message-ID: <20200515075003.szuxgob6qy63imva@ws.net.home>
References: <20200514185116.GA25596@Debian-50-lenny-64-minimal>
 <5372295b-b74b-2bf9-a8d1-bf1b38edcb30@physik.fu-berlin.de>
 <CALxWeYqwYyOAMHaoWnoKKL2O4BvYu8-m-DyBap5eYn=2stzXyQ@mail.gmail.com>
 <fa40b05f-7050-c5ee-a0ea-5af2d104a1bc@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa40b05f-7050-c5ee-a0ea-5af2d104a1bc@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, May 14, 2020 at 10:15:47PM +0200, John Paul Adrian Glaubitz wrote:
> On 5/14/20 10:09 PM, Michael Kerrisk wrote:
> >> On 5/14/20 8:51 PM, Helge Kreutzmann wrote:
> >>> I'm now reporting the errors for your project. If future reports should
> >>> use another channel, please let me know.
> >>
> >> I think you should send your changes as patches, preferably with a git pull
> >> request as the current form of submitting these changes requires a lot of
> >> manual editing due to the large number of changes involved.
> > 
> > Well, yes, but see
> > https://lore.kernel.org/util-linux/CAKgNAkgqKs=Q4qvPHirHa6KjW3qOqyyNG7sCxHX2RfWiOBqRbg@mail.gmail.com/
> 
> Doesn't convince, me really. I don't think it's too much to ask for to
> read the documentation of git and then create a set of patches.

Helge's way provides opportunity for other mailing list members to
contribute :-) 

> I wouldn't accept such mass mails for my own projects, it's just way too
> much work to import all these changes manually. And I also haven't seen
> any other project do that in the past 20 years, so I'm not sure how successful
> this strategy is.

Sharing is caring ... better report bugs than ignore.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

