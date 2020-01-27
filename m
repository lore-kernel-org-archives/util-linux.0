Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716ADC2D0DB
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416C32467B
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 20:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4AefD20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0UTB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:19:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32955 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726083AbgA0UTB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 15:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580156339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QhqYikxaWqMjf4Ol84V62QXdzSF8u7uvxUxm8QArvTE=;
        b=d4AefD20WKzS2xb4hYEutvCL+/QxFsLgJfW78i9b7+QhUUeB1TDuOTkQ9xuQ6apiOBRXpd
        xqv66Zh4CDHxNcM8Vqr/2/B/oBukGaHJ2A+iyz8fkApjqdVkeAgEkNSJ1gfLfGbJ810FoV
        RFpw3/quHLAvaDI6aITglgNd3b8XzAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-yfbGGtphN76HxMJmIgblOg-1; Mon, 27 Jan 2020 15:18:53 -0500
X-MC-Unique: yfbGGtphN76HxMJmIgblOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D73F189F762;
        Mon, 27 Jan 2020 20:18:52 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A783C3DA3;
        Mon, 27 Jan 2020 20:18:51 +0000 (UTC)
Date:   Mon, 27 Jan 2020 21:18:49 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <unixmania@gmail.com>
Cc:     J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35
Message-ID: <20200127201849.l4la3kcdzy7j7wa5@ws.net.home>
References: <20200121105711.zzeeolydlivqnik7@ws.net.home>
 <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200125105126.xaopgydc7dlrpztt@x2.net.home>
 <nycvar.YAK.7.76.2001261131130.3053@zhn.tzk.pbz>
 <20200127161317.wwyupvqbighx3rqx@ws.net.home>
 <CAJ4jsaf+s71UB9YOS_jeAn79t=2vSsY+7b-UvGPUEne87+ohPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ4jsaf+s71UB9YOS_jeAn79t=2vSsY+7b-UvGPUEne87+ohPQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 27, 2020 at 01:38:37PM -0300, Carlos Santos wrote:
> On Mon, Jan 27, 2020 at 1:13 PM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Sun, Jan 26, 2020 at 11:59:59AM -0500, J William Piggott wrote:
> > > You do realize that I had to heavily modify that file to remove its
> > > gnulib dependencies (because you said no to gnulib). If I recall
> >
> > I know, this is why we keep it in the tree (and thanks for all the
> > work!).
> >
> > > correctly I had newer and older versions to chose from and picked that
> > > one due to it having the most bugs fixed while still being practical to
> > > strip its gnulib dependence.
> > >
> > > The reasons for making the change were:
> > >  * remove hwclock's dependence on date(1)
> > >  * remove an insecure call to date(1)
> > >  * I thought there would be to many complaints if the accepted input
> > >    date formats were changed
> > >
> > > As to the last bullet point; personally I think having the --date option
> > > accept every date syntax know to history is nonsense.
> >
> > Yes, I agree it's probably overkill.
> >
> > > Or you could just use the existing utillinux date parser.
> >
> > This is what I have implemented for --disable-hwclock-gplv3 to have
> > anything ASAP for the next 2.35.1 update... Maybe we can make it the
> > default for the next release v2.36 and later remove the gnulib code at
> > all.
> >
> > > The question is, do you want to deal with any pushback for
> > > changing the long established accepted --date formats?
> >
> > IMHO the existing utillinux date parser is good enough, but I have no
> > clue how people use --date.
> 
> This is a bit disturbing. People should know in advance what date/time
> formats hwclock supports. They should be described in the man page, at

man hwclock: "This option is capable of understanding many time and
date formats." :-) 

It was for decade exec(date), so it supports almost whatever and it's 
reason why we have ported the code from gnulib to uti-linux. 

The question is if we really need to support it. Maybe it's time to
make it more restricted and rely only on simple format like
'2525-08-14 07:11:05'.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

