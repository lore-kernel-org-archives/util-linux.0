Return-Path: <SRS0=QCn3=6Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C8C47255
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 09:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4C6206E6
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOj46XIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgEKJ1q (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 May 2020 05:27:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59187 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728260AbgEKJ1p (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 May 2020 05:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589189264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YA8Pn6SnIlGKIFC2h9xV0YgGtxQj8YO7qogkZJOy9YM=;
        b=SOj46XIcSdb/3+t3HEIr6lv0GMF9R2rjERVmHtF+MhhoVN+fNQwsxs86DEgR2QIgH6eL/z
        8/GJQ7n63m51/n5or1DaPowGRBiLo0d08Ki6Hdoh6mNUy98Pv93eiUEgK8BWrxU0+/MSF6
        nyhRbJdGsh6711rlA3CGKZeENlI+p9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-xaYt2OQ9NyuCUFvWw5oTsA-1; Mon, 11 May 2020 05:27:39 -0400
X-MC-Unique: xaYt2OQ9NyuCUFvWw5oTsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46DE3107ACCA;
        Mon, 11 May 2020 09:27:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D538C7526B;
        Mon, 11 May 2020 09:27:36 +0000 (UTC)
Date:   Mon, 11 May 2020 11:27:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Helge Kreutzmann <debian@helgefjell.de>,
        util-linux@vger.kernel.org,
        Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Re: Errors in man pages of util-linux
Message-ID: <20200511092734.6izjgahtz37iya6v@ws.net.home>
References: <20200503191335.GB27970@Debian-50-lenny-64-minimal>
 <CALxWeYrDdow1y2oA1VkcCyiQH1Vm9jNN79o541FPRaHYom=pAg@mail.gmail.com>
 <20200509190020.GA28852@Debian-50-lenny-64-minimal>
 <CALxWeYpxvs+fcXzbExJ0n5ebeFtBdzm53ucPndW475CKe2KR0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALxWeYpxvs+fcXzbExJ0n5ebeFtBdzm53ucPndW475CKe2KR0Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, May 09, 2020 at 09:05:50PM +0200, Michael Kerrisk wrote:
> On Sat, May 9, 2020 at 9:00 PM Helge Kreutzmann <debian@helgefjell.de> wrote:
> >
> > Hello Michael,
> > On Sat, May 09, 2020 at 08:53:31PM +0200, Michael Kerrisk wrote:
> > > Hello Helge ;-),

Thanks for your report Helge.

> > > I think no maintainer wants to deal with a 1000-line mail listing 100+
> > > minor bugs. May I suggest making the maintainer's life a little easier
> > > by breaking things up into pieces. For example, one mail per manual
> > > page (which would be 43 mails by my count).  But maybe Karel has
> > > another suggestion on how you could make his life easier.

Well, that's simple, send patches ;-)))

> > Sure, I can do this, it did not see this mentioned for reporting bugs
> > in util-linux, hence I did not do so.
> >
> > Will do so soon, probably tomorrow.

I think Michael is right. If we will split it then more volunteers can 
work on it and it will be more easy to maintain all the task.

> Maybe hold off for a day or three before investing effort on this.
> Karel may have a better idea than mine re his preferred method of
> reporting.

I have no another idea (maybe github issue(s), but it will be invisible
for many contributors).
 
  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

