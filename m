Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62857 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbcDFOEB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 10:04:01 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 1/2] libuuid: remove HAVE_UUIDD
Date: Wed, 6 Apr 2016 15:03:42 +0100
Cc: util-linux@vger.kernel.org
References: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de> <201604061355.59565.sweet_f_a@gmx.de> <20160406122220.24mkbuz3rrkyuqza@ws.net.home>
In-Reply-To: <20160406122220.24mkbuz3rrkyuqza@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604061603.42976.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 06 April 2016, Karel Zak wrote:
> On Wed, Apr 06, 2016 at 12:55:58PM +0100, Ruediger Meier wrote:
> > On Wednesday 06 April 2016, Karel Zak wrote:
> > > > -#if defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H)
> > > > +#ifdef HAVE_SYS_UN_H
> > >
> > >  So you want uuidd stuff in libuuid although --disable-uuidd has
> > > been specified? Why?
> >
> > Same reason like for the 2nd patch. openSUSE packagers want do
> > disable uuidd in the "first stage build" because of systemd
> > dependency. But they still want full functionality in libbuuid.
> > They build uuidd later in "stage 2".
> >
> > Personally I don't like this openSUSE packaging style. But I see
> > the
>
> Hmm... I thought they rebuild entire package two times with a
> different configure options and the last build (2nd stage) is the
> final package used for distribution.
>
> Why they need fully functional libbuuid in 1st stage?
>
> It sounds like premature optimization if they want to avoid whole
> package rebuild in 2nd stage and the final rpm is created from two
> independent builds (1st + 2nd stage). That's crazy.
>
> > general problem that util-linux as a bunch of low-level tools has
> > already too much dependencies (systemd, python). This can be
> > annoying for certain ways how distros do their bootstrapping.
>
> The dependence are optional, if you avoid crazy creativity in build
> process than bootstrapping is pretty simple.

I know. The suse spec file looks even more crazy because they try to 
build stage 2 against already installed libmount, libblkid, etc.

As far as i understood they try to avoid a "real" bootstrapping and 
simply rebuild all packages again and again until nothing changes 
anymore (reproducible builds). Because this needs a lot of builds they 
try hard to remove as many as possible deps from the low-level packages 
like util-linux. In this case they decided to split util-linux to not 
cause rebuilds of other packages in case of systemd update. The python 
stuff is even later built in a "stage 3" ...

As already said, personally I don't like this suse way. These both 
patches are just to make the suse spec file at least a bit less ugly.

cu,
Rudi
