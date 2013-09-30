Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079Ab3I3NHW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Sep 2013 09:07:22 -0400
Date: Mon, 30 Sep 2013 15:07:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] clean up term lib handling
Message-ID: <20130930130718.GN5101@x2.net.home>
References: <1380429883-25187-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380429883-25187-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 I have applied the patch, but now when play with it I see that

On Sun, Sep 29, 2013 at 12:44:43AM -0400, Mike Frysinger wrote:
> With a minor tweak to how tinfo is handled, we can do the same thing -- we
> just always use TINFO_LIBS in the Makefile's.

you have introduced unnecessary dependence on ncurses for utils where
was "ifdef tinfo *else* ncurses"

>  AC_CHECK_LIB([tinfo], [tgetent], [have_tinfo=yes])
> -AM_CONDITIONAL([HAVE_TINFO], [test "x$have_tinfo" = xyes])
> +AS_IF([test "x$have_tinfo" = xyes], [
> +  TINFO_LIBS="-ltinfo"
> +])
> +AC_SUBST([TINFO_LIBS])

...

> -if HAVE_TINFO
> -setterm_LDADD = $(LDADD) -ltinfo
> -else
> -setterm_LDADD = $(LDADD) @NCURSES_LIBS@
> -endif
> +setterm_CFLAGS = $(AM_CFLAGS) $(NCURSES_CFLAGS)
> +setterm_LDADD = $(LDADD) $(NCURSES_LIBS) $(TINFO_LIBS)
>  endif

...

> -ul_LDADD = $(LDADD)
> -if HAVE_TINFO
> -ul_LDADD += -ltinfo
> -else 
> -ul_LDADD += @NCURSES_LIBS@
> -endif
> +ul_CFLAGS = $(AM_CFLAGS) $(NCURSES_CFLAGS)
> +ul_LDADD = $(LDADD) $(NCURSES_LIBS) $(TINFO_LIBS)
>  endif # BUILD_UL

...

> -if HAVE_TINFO
> -more_LDADD += -ltinfo
> -else
> -if HAVE_NCURSES
> -more_LDADD += @NCURSES_LIBS@
> -else
> +more_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS) $(NCURSES_CFLAGS)
> +more_LDADD = $(LDADD) $(NCURSES_LIBS) $(TINFO_LIBS)
> +if HAVE_TERMCAP
>  more_LDADD += -ltermcap
>  endif
> -endif

 old version:

./more:
	linux-vdso.so.1 =>  (0x00007fff2af9d000)
	libtinfo.so.5 => /lib64/libtinfo.so.5 (0x0000003e8d200000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003e77200000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003e76e00000)
./setterm:
	linux-vdso.so.1 =>  (0x00007fff5cd5e000)
	libtinfo.so.5 => /lib64/libtinfo.so.5 (0x0000003e8d200000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003e77200000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003e76e00000)
./ul:
	linux-vdso.so.1 =>  (0x00007fffa070b000)
	libtinfo.so.5 => /lib64/libtinfo.so.5 (0x0000003e8d200000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003e77200000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003e76e00000)


your version:


./more:
	linux-vdso.so.1 =>  (0x00007ffff21fe000)
	libncursesw.so.5 => /lib64/libncursesw.so.5 (0x0000003e7ba00000)
	libtinfo.so.5 => /lib64/libtinfo.so.5 (0x0000003e8d200000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003e77200000)
	libdl.so.2 => /lib64/libdl.so.2 (0x0000003e77600000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003e76e00000)
./setterm:
	linux-vdso.so.1 =>  (0x00007fff1455b000)
	libncursesw.so.5 => /lib64/libncursesw.so.5 (0x0000003e7ba00000)
	libtinfo.so.5 => /lib64/libtinfo.so.5 (0x0000003e8d200000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003e77200000)
	libdl.so.2 => /lib64/libdl.so.2 (0x0000003e77600000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003e76e00000)
./ul:
	linux-vdso.so.1 =>  (0x00007fff274ee000)
	libncursesw.so.5 => /lib64/libncursesw.so.5 (0x0000003e7ba00000)
	libtinfo.so.5 => /lib64/libtinfo.so.5 (0x0000003e8d200000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003e77200000)
	libdl.so.2 => /lib64/libdl.so.2 (0x0000003e77600000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003e76e00000)


 Maybe we need to revert back to 

   AM_CONDITIONAL([HAVE_TINFO], [test "x$have_tinfo" = xyes])

 or introduce something like $TINFO_OR_CURSES_{LIBS,CFLAGS} to keep 
 the makefiles simple and define the variable in ./configure :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
