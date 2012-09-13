Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64877 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532Ab2IMN53 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 13 Sep 2012 09:57:29 -0400
Date: Thu, 13 Sep 2012 15:57:27 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Kay Sievers <kay@vrfy.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
Message-ID: <20120913135727.GC13016@x2.net.home>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com>
 <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com>
 <alpine.LFD.2.00.1209130934290.2222@new-host-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LFD.2.00.1209130934290.2222@new-host-2>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 13, 2012 at 09:37:30AM -0400, Lukáš Czerner wrote:
> On Thu, 13 Sep 2012, Kay Sievers wrote:
> 
> > Date: Thu, 13 Sep 2012 00:43:01 +0200
> > From: Kay Sievers <kay@vrfy.org>
> > To: Lukas Czerner <lczerner@redhat.com>
> > Cc: util-linux@vger.kernel.org, kzak@redhat.com
> > Subject: Re: [PATCH] blkdiscard: add new command
> > 
> > On Wed, Sep 12, 2012 at 11:49 PM, Lukas Czerner <lczerner@redhat.com> wrote:
> > > blkdiscard is used to discard device sectors. This is useful for
> > > solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
> > > fstrim this command is used directly on the block device.
> > 
> > Should this maybe live in blockdev(8)?
> > 
> > It's kind of unfortunate to create standalone tools for every other
> > rather exotic block device feature.
> 
> Discard is hardly exotic feature nowadays :). But anyway, I was not aware of
> blockdev(8) and indeed it seems like a better place to put this
> functionality. I'll look into it.

 That's question ... we already have fstrim which is also wrapper for
 one ioctl and it seems that your blkdiscard requires some logic
 (devsize, sectorsize, align ranges, ...). We usually use blockdev
 for pretty primitive ioctls, add something more complex will be hack
 (like --getsz or --report).

 It's UNIX, it's not so unusual that utils do one thing and do it well ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
