Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754125AbcLLK3h (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Dec 2016 05:29:37 -0500
Date: Mon, 12 Dec 2016 11:29:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161212102929.5kx3hbgoh4a5tfte@ws.net.home>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <201610201225.31755.sweet_f_a@gmx.de>
 <20161020110003.if5kjodyjqezynzp@ws.net.home>
 <201610201334.24945.sweet_f_a@gmx.de>
 <20161020151948.3y47rv5lwmqppubf@ws.net.home>
 <20161210171510.GH10558@vapier.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161210171510.GH10558@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Dec 10, 2016 at 12:15:10PM -0500, Mike Frysinger wrote:
> On 20 Oct 2016 17:19, Karel Zak wrote:
> > On Thu, Oct 20, 2016 at 01:34:24PM +0200, Ruediger Meier wrote:
> > > For me it looks like the even the ncurses authors do not like their own 
> > > pc files. Disabled by default and it's a pain to get them built with 
> > > correct names and installed in the right location. Even --prefix does 
> > > not work for their pc files. Plus the backward compatibility 
> > > problem ... 
> > 
> > OK, I have applied:
> >    https://github.com/karelzak/util-linux/commit/e5cc93b5a8854fce80537f86a244977df212dcb5
> > 
> > with ncurses-config and fallback to old good AC_CHECK_LIB. 
> > 
> > We can add fallback to pkg-config too, but it sounds like overkill if
> > ncurses-config is everywhere.
> 
> ugh, this change makes things worse.  the point of using pkg-config
> is also to get sane cross-compiling.  by always running `xxx-config`,
> it now breaks cross-compiling.

Does it mean that you have system (build root) where is no
ncurses-config{5,6}, but you have pkg-config only?

The argument for ncurses-config has been that it seems it's preferred
solution by ncurses upstream.

It will be simple to extend UL_NCURSES_CHECK() function to support also
pkg-config.

> why can't we just tell distros to fix their ncurses install ?  it's
> not like 2.29, released a month ago, is getting rolled out to old
> distros where people can't update their ncurses systems.

Well, it's pretty common that people recompile any package on the
current system. I think our goal is to support as much as possible
scenarios (yes, nothing is unlimited including my patience with
obscure installations ;-)

> "it's hard" is a pretty weak argument for distro maintainers.

That's true.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
