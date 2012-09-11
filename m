Return-Path: mail@bernhard-voelker.de
Date: Tue, 11 Sep 2012 11:40:11 +0200 (CEST)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: Ludwig Nussel <ludwig.nussel@suse.de>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <1098712216.1298354.1347356412043.JavaMail.open-xchange@email.1und1.de>
In-Reply-To: <20120911084908.GA30228@x2.net.home>
References: <1339747456-30761-1-git-send-email-ludwig.nussel@suse.de> <20120911084908.GA30228@x2.net.home>
Subject: Re: [PATCH] remove obsolete encryption support from losetup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On September 11, 2012 at 10:49 AM Karel Zak <kzak@redhat.com> wrote:

> On Fri, Jun 15, 2012 at 10:04:16AM +0200, Ludwig Nussel wrote:
> >  include/loopdev.h              |    3 --
> >  lib/loopdev.c                  |   56
> > ----------------------------------------
> >  libmount/src/context_loopdev.c |   22 +++-------------
> >  mount/mount.8                  |    9 +-----
> >  mount/mount.c                  |   26 +++---------------
> >  sys-utils/losetup.8            |   29 +-------------------
> >  sys-utils/losetup.c            |   37 ++++++--------------------
> >  sys-utils/mount.c              |   42 +----------------------------
> >  8 files changed, 23 insertions(+), 201 deletions(-)
>
>  Applied, thanks.

I think there are still a few fragments left, aren't there?
At least in include/loopdev.h, in lib/loopdev.c and in
tests/ts/mount/ecrypted.

See 'git grep -i cryptoloop' and 'grep -i crypt */*loop*'.

Have a nice day,
Berny
