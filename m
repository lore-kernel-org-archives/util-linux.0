Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3DZLxK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Apr 2013 07:53:10 -0400
Date: Fri, 26 Apr 2013 13:53:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/33] build-sys: add --disable-setterm to ./configure
Message-ID: <20130426115300.GF4839@x2.net.home>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
 <1365882901-11429-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365882901-11429-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 13, 2013 at 08:54:35PM +0100, Sami Kerola wrote:
> +AC_ARG_ENABLE([setterm],
> +  AS_HELP_STRING([--disable-setterm], [do not build setterm]),
> +  [], enable_setterm=yes
> +)
> +UL_BUILD_INIT([setterm])
> +AM_CONDITIONAL(BUILD_SETTERM, test "x$build_setterm" = xyes)
>  
>  AC_ARG_ENABLE([schedutils],
>    AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, teskset]),
> diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
> index f4fa92d..fdf4d98 100644
> --- a/term-utils/Makemodule.am
> +++ b/term-utils/Makemodule.am
> @@ -24,7 +24,7 @@ agetty_LDADD = $(LDADD) libcommon.la
>  endif # BUILD_AGETTY
>  
>  
> -# TODO: add BUILD_SETTERM to configure.am
> +if BUILD_SETTERM
>  if HAVE_NCURSES
>  if LINUX
>  usrbin_exec_PROGRAMS += setterm
> @@ -37,6 +37,7 @@ else
>  setterm_LDADD = $(LDADD) @NCURSES_LIBS@
>  endif
>  endif
> +endif

 I have applied a little different version.

 The reason for BUILD_* is to describe and evaluate dependencies
 in ./configure rather than in makefiles. So if you have
 BUILD_SETTERM than "if LINUX" or "if HAVE_NCURSES" is usually
 unwanted, because you can use

  UL_BUILD_INIT([setterm])
  UL_REQUIRES_LINUX([setterm])
  UL_REQUIRES_HAVE([setterm], [ncurses], [ncurses library])
  AM_CONDITIONAL(BUILD_SETTERM, test "x$build_setterm" = xyes)

in the configure file.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
