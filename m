Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29277 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab2IZVBc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Sep 2012 17:01:32 -0400
Date: Wed, 26 Sep 2012 17:01:31 -0400 (EDT)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Kay Sievers <kay@vrfy.org>
cc: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>,
        util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: [PATCH] blkdiscard: add new command
In-Reply-To: <CAPXgP11dpk8n_oBpNAuS7g_kvTJVax_5hAkomr5WjUdS66cUFA@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1209261649420.31136@dhcp-187-45.bos.redhat.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com> <alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com> <CAPXgP11oktXSe3yxdOZCMzNOSrfVawtL95nBuM_NYxB9KPvOdA@mail.gmail.com> <alpine.LFD.2.00.1209261612370.31136@dhcp-187-45.bos.redhat.com>
 <CAPXgP11dpk8n_oBpNAuS7g_kvTJVax_5hAkomr5WjUdS66cUFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="269102523-1842364698-1348693292=:31136"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--269102523-1842364698-1348693292=:31136
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Sep 2012, Kay Sievers wrote:

> Date: Wed, 26 Sep 2012 22:27:49 +0200
> From: Kay Sievers <kay@vrfy.org>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: util-linux@vger.kernel.org, kzak@redhat.com
> Subject: Re: [PATCH] blkdiscard: add new command
> 
> On Wed, Sep 26, 2012 at 10:14 PM, Lukáš Czerner <lczerner@redhat.com> wrote:
> > On Wed, 26 Sep 2012, Kay Sievers wrote:
> >
> >> Date: Wed, 26 Sep 2012 22:04:37 +0200
> >> From: Kay Sievers <kay@vrfy.org>
> >> To: Lukáš Czerner <lczerner@redhat.com>
> >> Cc: util-linux@vger.kernel.org, kzak@redhat.com
> >> Subject: Re: [PATCH] blkdiscard: add new command
> >>
> >> On Wed, Sep 26, 2012 at 9:47 PM, Lukáš Czerner <lczerner@redhat.com> wrote:
> >> > On Wed, 12 Sep 2012, Lukas Czerner wrote:
> >> >
> >> >> Date: Wed, 12 Sep 2012 17:49:15 -0400
> >> >> From: Lukas Czerner <lczerner@redhat.com>
> >> >> To: util-linux@vger.kernel.org, kzak@redhat.com
> >> >> Cc: Lukas Czerner <lczerner@redhat.com>
> >> >> Subject: [PATCH] blkdiscard: add new command
> >> >>
> >> >> blkdiscard is used to discard device sectors. This is useful for
> >> >> solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
> >> >> fstrim this command is used directly on the block device.
> >> >>
> >> >> blkkdiscard uses BLKDISCARD ioctl or BLKSECDISCARD ioctl for the secure
> >> >> discard.
> >> >>
> >> >> All data in the discarded region on the device will be lost!
> >> >
> >> > Hi Karel,
> >> >
> >> > any progress here ?
> >>
> >> Where is the patch for blockdev?
> >
> > There is not.
> >
> >> I'm still convinced randomly named tools per new kernel ioctl is not
> >> what we want. People should get their act together, and not add the
> >> tool of the week to util-linux.
> >
> > And I am still convinced that multiplexing different functionalities
> > together into a single tool is not always the best way to go,
> > especially when they does not have nothing in common.
> 
> They have in common that they operate directly on the raw kernel block device.

And that's where the similarity ends. The BLKDISCARD ioctl is
sufficiently different from the others ioctls and also has different
syntax. Unlike the blockdev commands it also changes the content of
the raw device and it can even take significant time to finish.

Actually it might be even worth adding a warning and ask user to
proceed if not "forced" as this operation will destroy data on
the device.

That said I think that this is different enough to have it's own
binary and manual page.
> 
> This:
>   blockdev <verb> [options] <devices>
> sounds certainly better than than one tool per every new command.

Sure, except we're not creating new tool per every ioctl, do we.

> 
> And it's not only the needlessly duplicated binary, it's primarily
> consistency, but also maintenance, documentation, ... which is all
> needlessly exploded here.
> It's not so much about multiplexing, it's about avoiding needless
> duplication for rather exotic functions applying to one and the same
> domain, a block device, which already has a command.

Again, this is hardly exotic function. And for the sake of
documentation this should have its own manual page instead of being
hidden in the bunch of one-line descriptions as it is in blockdev.

-Lukas

> 
> util-linux is mandatory in every installation, and it is already one
> of the most chaotic and weird collections of random things. We should
> certainly be more careful here when coming up with new stuff than
> people have been in the past.
> 
> Kay
> 
--269102523-1842364698-1348693292=:31136--
