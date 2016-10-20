Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932582AbcJTLe3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 07:34:29 -0400
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MTwYX-1cNtPk2zxp-00QjD0 for
 <util-linux@vger.kernel.org>; Thu, 20 Oct 2016 13:34:25 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Date: Thu, 20 Oct 2016 13:34:24 +0200
References: <20161019132505.cumn37cmgazlumcu@ws.net.home> <201610201225.31755.sweet_f_a@gmx.de> <20161020110003.if5kjodyjqezynzp@ws.net.home>
In-Reply-To: <20161020110003.if5kjodyjqezynzp@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610201334.24945.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 20 October 2016 at 13:00, you wrote:
> On Thu, Oct 20, 2016 at 12:25:31PM +0200, Ruediger Meier wrote:
> > On Thursday 20 October 2016, Karel Zak wrote:
> > > On Thu, Oct 20, 2016 at 08:03:03AM +0200, Ruediger Meier wrote:
> > > > On Wednesday 19 October 2016, Karel Zak wrote:
> > > > > The util-linux release v2.29-rc1 is available at
> > > > >
> > > > >   http://ftp.kernel.org/pub/linux/utils/util-linux/v2.29/
> > > > >
> > > > > Feedback and bug reports, as always, are welcomed.
> > > > >
> > > > >     Karel
> > > >
> > > > Looks like ncurses(w) detection does not work anymore without
> > > > pkgconfig files, for example on openSUSE <=13.1, SLE 12 and
> > > > openSUSE Leap.
> > >
> > > Ah, I have thought that people already use pkg-config for ncurses
> > > on all current distributions. For example we have .pc for ncurses
> > > on old CentOS/RHEL 6 (year 2011).
> > >
> > > I can add the fallback, but it makes configure messy. Do we
> > > really need it? :-)
> >
> > I've just checked a bit.
> >
> > The pkg-config files were introduced in ncurses 5.9 (2011). But
> > they are still not enabled by default. So many distros may still
> > miss it and users who install ncurses from source will probably
> > also miss it in the first run. That's a bit annoying.
>
> It would be probably nice to report this to Suse maintainers.
>
> > Actually I was not even able to figure out quickly how to install
> > ncursesw.pc. Looks like this would be needed
> >
> > ./configure --enable-pc-files --enable-widec --enable-lib-suffixes
> > --enable-pc-suffixes
> >
> > That also means that ncurses without suffix "w" may have wide char
> > support if not configured with --enable-lib-suffixes
> > and --enable-pc-suffixes. So probably our new error does not really
> > make sense: "wide-char support enabled, but non-wide ncurses
> > selects"
>
> Well, the idea is to keep it simple, "may have wide char" sounds like
> we need compile test to be sure. That's crazy. Maybe assume that
> "w" mean wide is good enough.

I don't think it makes sense because --with-pc-suffix is disabled by 
default. The normal case is that ncurses.pc points to ncursesw lib.

>
> > I wonder why we don't try the config scripts (--libs --cflags) in
> > this order:
> >  ncursesw6-config
> >  ncurses6-config
> >  ncursesw5-config
> >  ncurses5-config
>
> Parallel universe :-)
>
> > Looks like they are always installed by default and also always
> > with the right suffixes. No fallback needed if we don't use
> > pkg-config at all.
>
> I'll try to fix it and use pkg-config and if not available then
> ncurses-config.  Yes, I think that prefer de-facto standard
> pkg-config with generic PKG_* autoconf macros is a good idea.

For me it looks like the even the ncurses authors do not like their own 
pc files. Disabled by default and it's a pain to get them built with 
correct names and installed in the right location. Even --prefix does 
not work for their pc files. Plus the backward compatibility 
problem ... 


cu,
Rudi
