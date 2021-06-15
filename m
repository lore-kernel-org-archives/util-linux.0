Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7391EC48BDF
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4804361452
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhFOJtf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231455AbhFOJtf (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 15 Jun 2021 05:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623750450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+O4FQ9RGysV1SrJbllcWMAYgG4QriQEAnJHV/0dR9pI=;
        b=BO7SAoRFR6Hhkks0a8p0/SA+yrN7i9wFz4JKLpWthkjuCLcVSCTIgt5nqQAP1bXhVWxhFe
        BNABxRhFj+jn0RJQIaNuB2Dg1XPmcysT6iPAy8rJM4HLB+7zZ43F3xLMzzFLG8JbzaQrX2
        mUwWJEoVLt1tBl7j+mb7lGYkgiHWanQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-SrdVQzBQNPef7pCc3TvcnQ-1; Tue, 15 Jun 2021 05:47:29 -0400
X-MC-Unique: SrdVQzBQNPef7pCc3TvcnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23EA814EE;
        Tue, 15 Jun 2021 09:47:28 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0687260CCC;
        Tue, 15 Jun 2021 09:47:26 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:47:24 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Alyssa Ross <hi@alyssa.is>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libblkid: match uppercase UUIDs
Message-ID: <20210615094724.eujfuqsvfquhunm5@ws.net.home>
References: <20210614204017.49499-1-hi@alyssa.is>
 <20210614210433.p62vxkx3cm7ynwbk@eve.qyliss.net>
 <CADxRZqyyy2U1czTggBmSFz19BX5Jeg+hQk9ac+91ovkgsAc6RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqyyy2U1czTggBmSFz19BX5Jeg+hQk9ac+91ovkgsAc6RQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 15, 2021 at 12:19:51PM +0300, Anatoly Pugachev wrote:
> On Tue, Jun 15, 2021 at 12:07 AM Alyssa Ross <hi@alyssa.is> wrote:
> >
> > On Mon, Jun 14, 2021 at 08:40:17PM +0000, Alyssa Ross wrote:
> > > In a script, I wanted to look up the device node for the booted EFI
> > > partition.  systemd-boot exposes this in an EFI variable but it's
> > > uppercase, so when I tried to do this, it didn't work:
> > >
> > >     findfs "(< /sys/firmware/efi/vars/LoaderDevicePartUUID-4a67b082-0a4c-41cf-b6c7-440)"
> >
> > Bogus command here, sorry.  It should have been:
> >
> >     findfs PARTUUID="$(cat /sys/firmware/efi/vars/LoaderDevicePartUUID-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f/data)"
> >
> > But my point stands. :)
> 
> probably could use a pipe after cat, like:
> 
> cat ... | tr [:lower:] [:upper:]
> 
> or patch util-linux docs, to implicitly state that comparison is done
> with upper case letters (UUID)... Not sure which way is better
> (including your patch).

There is no guaranty that the UUID will be the upper or lower case
although in fstab.5 and mount.8 man pages we have "should be based on
lower case characters".                                            
                                                                   
libblkid itself does not modify UUID/PARTUUID when reading it from the
filesystem. It depends on FS-specific prober in the library or in some
cases on the filesystem superblock if UUID is stored as a string there.

And it's also important to support 3rd party UUID from another source as
you can write whatever to your udev rules and use others tools to get
UUIDs.     
                                                                   
So, I think your request to compare UUIDs in a case-insensitive way
makes sense. The library should be smart enough to accept whatever.


I'll think about it and try to improve the current situation.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

