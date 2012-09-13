Return-Path: lczerner@redhat.com
Date: Thu, 13 Sep 2012 10:09:34 -0400 (EDT)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Karel Zak <kzak@redhat.com>
cc: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>,
        Kay Sievers <kay@vrfy.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
In-Reply-To: <20120913135727.GC13016@x2.net.home>
Message-ID: <alpine.LFD.2.00.1209131003291.2222@new-host-2>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com> <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com> <alpine.LFD.2.00.1209130934290.2222@new-host-2> <20120913135727.GC13016@x2.net.home>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="269113540-1317177277-1347545377=:2222"
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--269113540-1317177277-1347545377=:2222
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 13 Sep 2012, Karel Zak wrote:

> Date: Thu, 13 Sep 2012 15:57:27 +0200
> From: Karel Zak <kzak@redhat.com>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: Kay Sievers <kay@vrfy.org>, util-linux@vger.kernel.org
> Subject: Re: [PATCH] blkdiscard: add new command
> 
> On Thu, Sep 13, 2012 at 09:37:30AM -0400, Lukáš Czerner wrote:
> > On Thu, 13 Sep 2012, Kay Sievers wrote:
> > 
> > > Date: Thu, 13 Sep 2012 00:43:01 +0200
> > > From: Kay Sievers <kay@vrfy.org>
> > > To: Lukas Czerner <lczerner@redhat.com>
> > > Cc: util-linux@vger.kernel.org, kzak@redhat.com
> > > Subject: Re: [PATCH] blkdiscard: add new command
> > > 
> > > On Wed, Sep 12, 2012 at 11:49 PM, Lukas Czerner <lczerner@redhat.com> wrote:
> > > > blkdiscard is used to discard device sectors. This is useful for
> > > > solid-state drivers (SSDs) and thinly-provisioned storage. Unlike
> > > > fstrim this command is used directly on the block device.
> > > 
> > > Should this maybe live in blockdev(8)?
> > > 
> > > It's kind of unfortunate to create standalone tools for every other
> > > rather exotic block device feature.
> > 
> > Discard is hardly exotic feature nowadays :). But anyway, I was not aware of
> > blockdev(8) and indeed it seems like a better place to put this
> > functionality. I'll look into it.
> 
>  That's question ... we already have fstrim which is also wrapper for
>  one ioctl and it seems that your blkdiscard requires some logic
>  (devsize, sectorsize, align ranges, ...). We usually use blockdev
>  for pretty primitive ioctls, add something more complex will be hack
>  (like --getsz or --report).
> 
>  It's UNIX, it's not so unusual that utils do one thing and do it well ;-)
> 
>     Karel

Righ, I've looked at the blockdev(8) and indeed it lacks the ability
to pass more "complex" arguments to the command itself. It would
have to be updated to support this. Most likely to something like
this:

blockdev <blockdev options> <command> <command options>

but I am not sure it worth it. And your UNIX point is quite valid. I
am on the fence about this (with slight inclination to separate blkdiscard),
but you're the maintainer so you have the privilege to decide :)

-Lukas
--269113540-1317177277-1347545377=:2222--
