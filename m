Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11147 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754863Ab2GJLKZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jul 2012 07:10:25 -0400
Date: Tue, 10 Jul 2012 13:10:21 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Mike Frysinger <vapier@gentoo.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] /run directory and swapon
Message-ID: <20120710111021.GE5281@x2.net.home>
References: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
 <201206282338.41501.vapier@gentoo.org>
 <CAG27Bk1ejSJ+N0XWO1u09M1Xojd6Q+NTvHkb6-bTV-yG22H_XA@mail.gmail.com>
 <20120710100825.GD5281@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120710100825.GD5281@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 10, 2012 at 12:08:25PM +0200, Karel Zak wrote:
> On Sat, Jun 30, 2012 at 10:59:11PM +0200, Sami Kerola wrote:
> > > is this last case just so you can AC_DEFINE the value below ?  in general,
> > > this is fragile.  defines should be expanded at make time rather than configure.
> > >
> > > CPPFLAGS="$CPPFLAGS -D_PATH_LOCALSTATEDIR=\"\${localstatedir}\""
> 
>  Good point.
> 
> > The comment was a bit mysterious to me, so I tried to find what you
> > meant by fragility. The
> > 
> > http://www.opensource.apple.com/source/xar/xar-28/xar/configure.ac
> > 
> > has following
> > 
> > dnl Define cpp macros in CPPFLAGS, rather than doing AC_DEFINE(macro), since the
> > dnl definitions need to be seen before and headers are included, which is a pain
> > dnl to make happen otherwise.
> > 
> > which seem to match what you meant. I changed the line to be C
> > preprocessor definition, and added you as patch CC. Benno, I added you
> > to swapon patches CC as well. The changes are in my git.
> 
>  Please, don't use #include "config.h" at all. It's unnecessary,
>  because -D_PATH_LOCALSTATEDIR and it's also necessary because we use
>  -include "config.h" on compiler command line -- both is evaluated
>  before regular "#include".
> 
> 
>  I'm also not sure about
> 
>     /var/lib/libuuid/clock.txt --> /run/libuuid/clock.txt
> 
>  rename, the /var/lib is persistent...

 Oh.. you have moved the file to /run/uuidd, that's really bad place.

 The file is used by libbuid library. (In Fedora we have bug in
 util-linux.spec file, the file should be owned by libuuid rather than
 by uuidd.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
