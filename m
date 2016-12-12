Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Date: Mon, 12 Dec 2016 15:31:57 +0100
Cc: util-linux@vger.kernel.org
References: <20161019132505.cumn37cmgazlumcu@ws.net.home> <20161210171510.GH10558@vapier.lan> <20161212102929.5kx3hbgoh4a5tfte@ws.net.home>
In-Reply-To: <20161212102929.5kx3hbgoh4a5tfte@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201612121531.57375.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 12 December 2016, Karel Zak wrote:
> On Sat, Dec 10, 2016 at 12:15:10PM -0500, Mike Frysinger wrote:
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
> > > https://github.com/karelzak/util-linux/commit/e5cc93b5a8854fce805
> > >37f86a244977df212dcb5
> > >
> > > with ncurses-config and fallback to old good AC_CHECK_LIB.
> > >
> > > We can add fallback to pkg-config too, but it sounds like
> > > overkill if ncurses-config is everywhere.
> >
> > ugh, this change makes things worse.  the point of using pkg-config
> > is also to get sane cross-compiling.  by always running
> > `xxx-config`, it now breaks cross-compiling.
>
> Does it mean that you have system (build root) where is no
> ncurses-config{5,6}, but you have pkg-config only?

Usually cross-compiled libs to be used by a cross compiler are installed 
in a prefix like

 /usr/i686-w64-mingw32/sys-root/mingw/

So you would probaby have such an ncurses5-config (which is not in 
PATH):

  /usr/i686-w64-mingw32/sys-root/mingw/bin/ncurses5-config

Simply adding this bin dir to PATH wouldn't be a good idea because it 
may contain binaries build for another target.

The "advantage" of pkg-config is 
that "configure --host=i686-w64-mingw32" is smart and tries to use a 
host-prefixed "i686-w64-mingw32-pkg-config" instead of 
just "pkg-config". The prefixed pkg-config is searching .pc files in 
the right sysroot. Though the smartness ends if you have 
PKG_CONFIG_PATH in your env ... 


> The argument for ncurses-config has been that it seems it's preferred
> solution by ncurses upstream.
>
> It will be simple to extend UL_NCURSES_CHECK() function to support
> also pkg-config.
>
> > why can't we just tell distros to fix their ncurses install ?  it's
> > not like 2.29, released a month ago, is getting rolled out to old
> > distros where people can't update their ncurses systems.
>
> Well, it's pretty common that people recompile any package on the
> current system. I think our goal is to support as much as possible
> scenarios (yes, nothing is unlimited including my patience with
> obscure installations ;-)

> > "it's hard" is a pretty weak argument for distro maintainers.
>
> That's true.
>
>     Karel
