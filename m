Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752288AbcLLO2g (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Dec 2016 09:28:36 -0500
Date: Mon, 12 Dec 2016 15:28:34 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161212142834.jnspem6oeqqbly4g@ws.net.home>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <20161020151948.3y47rv5lwmqppubf@ws.net.home>
 <20161210171510.GH10558@vapier.lan>
 <201612121501.57462.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201612121501.57462.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 12, 2016 at 03:01:57PM +0100, Ruediger Meier wrote:
> On Saturday 10 December 2016, Mike Frysinger wrote:
> > On 20 Oct 2016 17:19, Karel Zak wrote:
> > > On Thu, Oct 20, 2016 at 01:34:24PM +0200, Ruediger Meier wrote:
> > > > For me it looks like the even the ncurses authors do not like
> > > > their own pc files. Disabled by default and it's a pain to get
> > > > them built with correct names and installed in the right
> > > > location. Even --prefix does not work for their pc files. Plus
> > > > the backward compatibility problem ...
> > >
> > > OK, I have applied:
> > >   
> > > https://github.com/karelzak/util-linux/commit/e5cc93b5a8854fce80537
> > >f86a244977df212dcb5
> > >
> > > with ncurses-config and fallback to old good AC_CHECK_LIB.
> > >
> > > We can add fallback to pkg-config too, but it sounds like overkill
> > > if ncurses-config is everywhere.
> >
> > ugh, this change makes things worse.  the point of using pkg-config
> > is also to get sane cross-compiling.  by always running `xxx-config`,
> > it now breaks cross-compiling.
> 
> Works for me, when adding the ncurses5-config to the PATH
> $ /usr/i686-w64-mingw32/sys-root/mingw/bin/ncurses5-config  --libs
> -L/usr/i686-w64-mingw32/sys-root/mingw/lib -lncurses -ltinfo
> 
> > why can't we just tell distros to fix their ncurses install ?  it's
> > not like 2.29, released a month ago, is getting rolled out to old
> > distros where people can't update their ncurses systems.
> 
> I guess we should better fix ncurses upstream, to avoid having ncurses 
> packages on any distros broken in different ways.
> 
> > "it's hard" is a pretty weak argument for distro maintainers.
> 
> No, no. This was about installing plain ncurses as a normal user 
> (./configure --prefix ...). If upstream does not provide .pc files by 
> default then we should not rely on them. You can't blame users nor 
> package maintainers for installing a lib in a way like upstream 
> recommends.
> 
> To re-add pkg-config plus fallback we could try AX_WITH_CURSES from 
> autoconf-archive:
> https://www.gnu.org/software/autoconf-archive/ax_with_curses.html#ax_with_curses

I have add one AC_IF and PKG_CHECK_MODULES to our UL_NCURSES_CHECK to
prefer pkg-config and fallback to ncurses-config. It's trivial fix and
it seems it works as expected.

No problem to support AX_WITH_CURSES (go ahead if you want), but I'm
lazy :-) to test this completely new solution.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
