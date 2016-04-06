Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbcDFMWW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 08:22:22 -0400
Date: Wed, 6 Apr 2016 14:22:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libuuid: remove HAVE_UUIDD
Message-ID: <20160406122220.24mkbuz3rrkyuqza@ws.net.home>
References: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de>
 <20160406113552.6nrd4xnqjjrwqbrc@ws.net.home>
 <201604061355.59565.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201604061355.59565.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 06, 2016 at 12:55:58PM +0100, Ruediger Meier wrote:
> On Wednesday 06 April 2016, Karel Zak wrote:
> > > -#if defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H)
> > > +#ifdef HAVE_SYS_UN_H
> >
> >  So you want uuidd stuff in libuuid although --disable-uuidd has been
> >  specified? Why?
> 
> Same reason like for the 2nd patch. openSUSE packagers want do disable 
> uuidd in the "first stage build" because of systemd dependency. But 
> they still want full functionality in libbuuid. They build uuidd later 
> in "stage 2".
> 
> Personally I don't like this openSUSE packaging style. But I see the 

Hmm... I thought they rebuild entire package two times with a
different configure options and the last build (2nd stage) is the
final package used for distribution. 

Why they need fully functional libbuuid in 1st stage?

It sounds like premature optimization if they want to avoid whole
package rebuild in 2nd stage and the final rpm is created from two
independent builds (1st + 2nd stage). That's crazy.

> general problem that util-linux as a bunch of low-level tools has 
> already too much dependencies (systemd, python). This can be annoying 
> for certain ways how distros do their bootstrapping.

The dependence are optional, if you avoid crazy creativity in build
process than bootstrapping is pretty simple.

> >  The --disable-uuidd is (or should be) pretty common for desktop-only
> >  distros.
> 
> I thought why shouldn't libbuuid always try the uuidd socket? Like glibc 
> always tries nscd, regardless if that evil beast is running or not. 

Yes, this is possible way. The problem is that uuidd is necessary for
0.01% of all Linux boxes ;-) 

It would be probably better to disable it by default and require 
--enable-uuidd for Suse/RHEL ;-) Maybe good idea for v2.29.

> Does it matter that nscd or uuidd was not built? Maybe one wants to use 
> another implementations of these daemons.
> 
> >  IMHO the current behaviour is correct.
> 
> What about adding --enable-libuuid-force-uuidd without changing any 
> current behavior?

Yes, it seems like a good idea for v2.28.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
