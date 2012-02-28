Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24478 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965392Ab2B1RSm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Feb 2012 12:18:42 -0500
Date: Tue, 28 Feb 2012 18:18:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: do not overwrite ddate.1 manual
Message-ID: <20120228171832.GF22034@x2.net.home>
References: <1330292740-7737-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330292740-7737-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 26, 2012 at 10:45:40PM +0100, Sami Kerola wrote:
> The following warning meant either english manual page overwrote ru
> version, or otherway around.  Neither way that not intented.  This
> patch will change ru version of the manual page to be installed to
> <prefix><mandir>/ru/man1 directory.
> 
> man/ru/Makefile.am:4: warning: mandir was already defined in condition TRUE, which includes condition BUILD_DDATE ...
> configure.ac:1: ... `mandir' previously defined here
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  configure.ac       |    2 ++
>  man/ru/Makefile.am |    5 ++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index d3b298c..be9da27 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -833,6 +833,8 @@ AC_ARG_ENABLE([ddate],
>  )
>  UL_BUILD_INIT([ddate])
>  AM_CONDITIONAL(BUILD_DDATE, test "x$build_ddate" = xyes)
> +rumandir='${mandir}/ru/man1'
> +AC_SUBST([rumandir])
>  
>  
>  AC_ARG_ENABLE([agetty],
> diff --git a/man/ru/Makefile.am b/man/ru/Makefile.am
> index 31fafb9..64e88fd 100644
> --- a/man/ru/Makefile.am
> +++ b/man/ru/Makefile.am
> @@ -1,7 +1,6 @@
>  include $(top_srcdir)/config/include-Makefile.am
>  
>  if BUILD_DDATE
> -mandir = @mandir@/ru
> -dist_man_MANS =
> -dist_man_MANS += ddate.1
> +ruman_DATA = ddate.1
> +EXTRA_DIST = $(ruman_DATA)

 Ah... that's dirty, but ddate(1) users don't expect anything other :-)
 
 I'm not able to found a better solution (it would be nice to use
 *_MANS as it automatically creates the man<N> subdir, but...)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
