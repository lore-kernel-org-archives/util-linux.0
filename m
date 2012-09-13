Return-Path: lczerner@redhat.com
Date: Thu, 13 Sep 2012 11:52:11 -0400 (EDT)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Kay Sievers <kay@vrfy.org>
cc: Karel Zak <kzak@redhat.com>,
        =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
In-Reply-To: <CAPXgP11u=6j6U8zjvgSr11K6WjAsP+aumBQmZ6R++tb7bxHOnw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1209131140060.15781@dhcp-196-88.bos.redhat.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com> <CAPXgP12NSLGBJGejiE2L0bfHTRL3f9RObAse=A6b5_2OqJ+RhA@mail.gmail.com> <alpine.LFD.2.00.1209130934290.2222@new-host-2> <20120913135727.GC13016@x2.net.home>
 <CAPXgP11u=6j6U8zjvgSr11K6WjAsP+aumBQmZ6R++tb7bxHOnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="269113540-1240749223-1347551532=:15781"
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--269113540-1240749223-1347551532=:15781
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 13 Sep 2012, Kay Sievers wrote:

> Date: Thu, 13 Sep 2012 17:33:49 +0200
> From: Kay Sievers <kay@vrfy.org>
> To: Karel Zak <kzak@redhat.com>
> Cc: Lukáš Czerner <lczerner@redhat.com>, util-linux@vger.kernel.org
> Subject: Re: [PATCH] blkdiscard: add new command
> 
> On Thu, Sep 13, 2012 at 3:57 PM, Karel Zak <kzak@redhat.com> wrote:
> 
> >  It's UNIX, it's not so unusual that utils do one thing and do it well ;-)
> 
> How about looking at the sensible part of UNIX? I can provide you an
> endless list of crazy ideas in UNIX if you need that. And one tool per
> ioctl is certainly in that list. :)

Not necessarily. blockdev(8) is meant to provide user with a tool to
invoke simple block device ioctl which usually does not require any
arguments (except few with one argument). Changing its format to be

blockdev <options> <command> <options>

and extend it would certainly take away some of the nifty simplicity
of that tool. That said, there is nothing wrong with having small
and simple tool doing one thing and doing it right, in fact quite
the opposite - it _is_ a good thing.

And BTH I am not really suggesting one tool per ioctl, but
blkdiscard is sufficiently different then those found in blockdev
anyway (mostly -get, few -set and one -flush). In fact thinking
about it some more, I am really in favour of separate tool for this
functionality.

BTW since when it's wrong to have such small and simple tools instead
of multiplexing everything into one blob (Core OS anyone ?:)) ?

-Lukas

> 
> Kay
> 
--269113540-1240749223-1347551532=:15781--
