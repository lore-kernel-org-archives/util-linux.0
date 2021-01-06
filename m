Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24738C433DB
	for <util-linux@archiver.kernel.org>; Wed,  6 Jan 2021 12:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA8F23117
	for <util-linux@archiver.kernel.org>; Wed,  6 Jan 2021 12:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbhAFMFV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Jan 2021 07:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbhAFMFU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Jan 2021 07:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609934634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VReX4T4xaOdIVLdwgatR0Yvq5vj9gc+y8osrfxyfzOM=;
        b=THhiIXnHY6Z4uYBkLcw1YNMp/tbGn2lrvDluKOSKtPb3ptJ567XGX2FGzhO/LfQAvooTqQ
        s4uDVgWyf+4e1cVUMCcKe2nhXVIpZaYwtZ4zfflAn7mnvd8OiwJSuowvsDRLF9/SXlQFE8
        fzybD2rIh6g/pkHmDOAbxccWyievShQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-cSbppx2BO9yvI5FePl0ORQ-1; Wed, 06 Jan 2021 07:03:47 -0500
X-MC-Unique: cSbppx2BO9yvI5FePl0ORQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75F86190B2A3;
        Wed,  6 Jan 2021 12:03:46 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B9995D9CA;
        Wed,  6 Jan 2021 12:03:45 +0000 (UTC)
Date:   Wed, 6 Jan 2021 13:03:42 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Bill Unruh <unruh@physics.ubc.ca>
Cc:     David O'Brien <daobrien@redhat.com>, util-linux@vger.kernel.org
Subject: Re: Bug in lsblk command or man page?
Message-ID: <20210106120342.6gky5r42nq2sjrnf@ws.net.home>
References: <ed3332cf-794f-b0d3-caca-16fb65dfd5ac@redhat.com>
 <20210105102730.w5qxkr3qg353evlr@ws.net.home>
 <c04e1ccc-4053-bb3e-3479-512f263f679e@redhat.com>
 <alpine.LMD.2.11.2101050900440.19402@physics.ubc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LMD.2.11.2101050900440.19402@physics.ubc.ca>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 05, 2021 at 09:05:48AM -0800, Bill Unruh wrote:
> Of course it being "common" does NOT mean that everyone knows the convention,
> especially people new to Linux. And is NOT an excuse for the man page being
> wrong. So, yes, you should be explicit about it, and not be wrong about it in
> the man page.

There is nothing wrong in the man page.

> It is -o list and --output=list

It is "-o list", "--output list" and "--output=list".

And this is valid for 99% options in all our man pages. Not sure if we
want to explicitly describe it in all the pages ... and it's also libc
specific where the command line parser is implemented.

We recommend "=" only for optional arguments (--foo[=<argument>]), and 
on all other paces in the man pages (and in --help outputs) we do not
use "=" at all as it's not required.

So, use "-o list" and "--output list" and forget "=", you do not need it.
That's the message we want to deliver to user by man pages.

    Karel

> On Wed, 6 Jan 2021, David O'Brien wrote:
> 
> > On 1/5/21 8:27 PM, Karel Zak wrote:
> > > On Thu, Dec 24, 2020 at 11:14:04AM +1000, David O'Brien wrote:
> > > > I don't know if this is expected or not, but it seems very odd:
> > > > 
> > > > # lsblk -o=UUID /stratis/labpool/labfs
> > > > lsblk: unknown column: =UUID
> > > > 
> > > > [root@serverb ~]# lsblk -o UUID /stratis/labpool/labfs
> > > > UUID
> > > > 0118efb8-66fe-406a-837c-725961bdad4d
> > > > 
> > > > [root@serverb ~]# lsblk --output=UUID /stratis/labpool/labfs
> > > > UUID
> > > > 0118efb8-66fe-406a-837c-725961bdad4d
> > > > 
> > > > 
> > > > From the man(8) page:
> > > > -o, --output list
> > > >               Specify which output columns to print.  Use --help to get
> > > >               a list of all supported columns.  The columns may affect
> > > >               tree-like output.  The default is to use tree for the
> > > >               column 'NAME' (see also --tree).
> > > > 
> > > >               The default list of columns may be extended if list is
> > > >               specified in the format +list (e.g., lsblk -o +UUID).
> > > > 
> > > > There is no mention of "=" being required, causing failures, etc. I found this quite frustrating.
> > > > 
> > > 
> > > This is common getopt_long() behavior where equal sign is usable only for
> > > long options (and sometimes for optional arguments).
> > > 
> > >  lsblk -o UUID
> > >  lsblk --output UUID
> > >  lsblk --output=UUID
> > > 
> > > this is how "=" works in almost all commands and I don't see reason
> > > why we need to be explicit about it for "lsblk -o".
> > > 
> > >     Karel
> > > 
> > ok. If it's common and expected that's fine. I don't spend a lot of time with this class/type of command and it was just
> > new to me and seemed odd.
> > 
> > cheers
> > -- 
> > David
> > Introvert/Unclubbable/Cool
> > 
> > Red Hat's core values are freedom, courage, commitment, and accountability.
> > 
> > 
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

