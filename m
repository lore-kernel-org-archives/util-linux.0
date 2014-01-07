Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f50.google.com ([209.85.128.50]:44969 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbaAGSv4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Jan 2014 13:51:56 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so753645qec.37
        for <util-linux@vger.kernel.org>; Tue, 07 Jan 2014 10:51:56 -0800 (PST)
Date: Tue, 7 Jan 2014 13:51:54 -0500
From: Dave Reisner <d@falconindy.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Karel Zak <kzak@redhat.com>,
        Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Message-ID: <20140107185154.GB580@rampage>
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
> 
> if that were in play, the circular loop would be easy to address -- build 
> util-linux once just for its libs, then udev/systemd, then util-linux again.
> -mike

We do this in Arch already to provide a 32bit libraries on 64bit
systems:

https://projects.archlinux.org/svntogit/community.git/tree/trunk/PKGBUILD?h=packages/lib32-util-linux

A quick grep through the git repo shows that I could get rid of the
--without-ncurses flag, too.
