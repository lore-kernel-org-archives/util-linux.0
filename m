Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755475AbaAHJV3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jan 2014 04:21:29 -0500
Date: Wed, 8 Jan 2014 10:21:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Message-ID: <20140108092116.GA7516@x2.net.home>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
 <52CBCF17.50706@archlinux.org>
 <20140107101935.GA2658@x2.net.home>
 <201401071344.09876.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201401071344.09876.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 07, 2014 at 01:44:07PM -0500, Mike Frysinger wrote:
> On Tuesday 07 January 2014 05:19:35 Karel Zak wrote:
> > On Tue, Jan 07, 2014 at 10:55:35AM +0100, Thomas Bächler wrote:
> > > >> We already have such a cyclic dependency, since udevd depends on
> > > >> libblkid+libuuid, and findmnt (from util-linux) depends on libudev.
> > > >> 
> > > >  .. and nobody complains, good point :-) Thanks!
> > > >  
> > > >     Karel
> > > 
> > > Actually, now that I know you care about these things, I am complaining.
> > > 
> >  :-)))
> >  :
> > > It has caused me (minor) trouble once already.
> > 
> >  It's possible (first time) to compile util-linux without libudev,
> >  compile systemd/udevd and then again recompile util-linux with
> >  libudev.
> > 
> >  IMHO libudev is very useful for findmnt and lsblk to get info about
> >  devices.
> > 
> >  Note that uuidd is absolutely unnecessary if you don't have huge SAP
> >  installation (-- it means unnecessary for 99% of the all Linux users).
> 
> on a semi-related matter, it'd be nice if we could easily build util-linux 
> such that we only get the libraries.  the plethora of configure flags that 
> control utils is a nightmare to manage, and i'm not sure there's a flag for 
> every utility (i haven't checked myself, so i could easily be wrong).

not yet ;-)

> if that were in play, the circular loop would be easy to address -- build 
> util-linux once just for its libs, then udev/systemd, then util-linux again.

Yep, I know about the pain... I guess it would be enough to have
something like

 ./configure --disable-all-builds --enable-libblkid

where --enable/disable-all-builds controls the default of the
enable_<name>= variables (the current default is usually "check")
in configure.

I'll try to implement it later (I'm working on new cfdisk now) -- or
maybe some volunteer...? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
