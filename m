Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F9C388F9
	for <util-linux@archiver.kernel.org>; Wed, 11 Nov 2020 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E77C206E3
	for <util-linux@archiver.kernel.org>; Wed, 11 Nov 2020 08:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dM43YDDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgKKImU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgKKImU (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 11 Nov 2020 03:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605084138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nL8UkrM32fsCw3yU7HyKDT+Dc7WEi9QREMc+vxqUYmU=;
        b=dM43YDDmdsgLKC5JC9/AC4e+nssxPSY41z+GoNYVs9hl4EfOq5Gd7sRpZKzRl2f1dFYI/q
        /9UemjLVJClQmte4KaMLxajlj1iI2tUzj6SMl5HJ7z/T+N7XNBnNRjgFZXmO2RaIcfo82B
        z+Er2PsahpdxTYKfaAIG6RPfIJ7dWMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-_FAq5i6tNYiruUVvm9kl0g-1; Wed, 11 Nov 2020 03:42:14 -0500
X-MC-Unique: _FAq5i6tNYiruUVvm9kl0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 563D31084D61
        for <util-linux@vger.kernel.org>; Wed, 11 Nov 2020 08:42:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B759F6115F
        for <util-linux@vger.kernel.org>; Wed, 11 Nov 2020 08:42:12 +0000 (UTC)
Date:   Wed, 11 Nov 2020 09:42:10 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH v4 2/2] lscpu-arm: Remove hard corded model name of
 Cortex family and X-Gene
Message-ID: <20201111084210.lx5dn3b4guegr27l@ws.net.home>
References: <201fdf4b-5238-6e39-8883-f1ba0dbca4a5@arm.com>
 <20201110083712.kfisfq4yv5yadx4w@ws.net.home>
 <20201110185015.dk6xhlzdqrurlh7h@gabell>
 <20201110205052.5nnujoloficzbck3@tarantula.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110205052.5nnujoloficzbck3@tarantula.users.ipa.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 10, 2020 at 02:50:52PM -0600, Jeffrey Bastian wrote:
> On Tue, Nov 10, 2020 at 01:50:15PM -0500, Masayoshi Mizuma wrote:
> > On Tue, Nov 10, 2020 at 09:37:12AM +0100, Karel Zak wrote:
> > > On Mon, Nov 09, 2020 at 11:19:08PM -0600, Jeremy Linton wrote:
> > > > I don't agree with this, I think the hard coded table should be the first
> > > > authority on the manufacture/part number lists. That is because SMBIOS isn't
> > > > available on a fairly large number of arm systems, and on systems where it
> > > > does exist, it suffers from the same kinds of problems that exist on many
> > > > !arm machines. Its not particularly a reliable source of information.
> > > >
> > > > So, maybe if you have a situation where the SMBIOS information is more
> > > > correct than the hardcoded tables, maybe its a good idea to create a new
> > > > line?
> > > >
> > > >
> > > > Aka:
> > > >
> > > > Vendor Id: ARM
> > > > Model Name: Cortex-A57
> > > > BIOS Name: JoeSmithsCore
> > > 
> > > I like this idea.
> > 
> > Yeah, it's s great idea!
> > SMBIOS Type4 also has Vendor Id (Processor Manufacturer),
> > so the following is better?
> > 
> > Vendor Id: ARM
> > Model Name: Cortex-A57
> > BIOS Vendor Id: Foobar
> > BIOS Model Name: JoeSmithsCore
> > 
> > Jeff, does the above idea work for your case? X-Gene(eMAG) will be:
> > 
> > Vendor Id: APM
> > Model Name: X-Gene
> > BIOS Vendor Id: Ampere(TM)
> > BIOS Model Name: eMAG
> 
> 
> This is perfect.  I like the idea of showing both instead of preferring
> one over the other.

Sounds like a plan.

I'd like to merge my topic/lscpu branch to the master branch tomorrow (or
on Friday), the ideal solution will be to continue with this new code. 

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

