Return-Path: util-linux-owner@vger.kernel.org
Received: from hotei.ga-group.nl ([138.201.147.219]:44252 "EHLO
        hotei.ga-group.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbcLAKhH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Dec 2016 05:37:07 -0500
Received: from mail.ga-group.nl (p5780706c.dip0.t-ipconnect.de [87.128.112.108])
        by hotei.ga-group.nl (Postfix) with ESMTPS id 97567307D
        for <util-linux@vger.kernel.org>; Thu,  1 Dec 2016 11:29:18 +0100 (CET)
From: Ruediger Meier <ruediger.meier@ga-group.nl>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/11] agetty: re-add utmp.h for Debian GNU/kFreeBSD
Date: Thu, 1 Dec 2016 11:29:07 +0100
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de> <1480582671-17627-1-git-send-email-sweet_f_a@gmx.de> <1480582671-17627-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582671-17627-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201612011129.07977.ruediger.meier@ga-group.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 01 December 2016, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> It's needed there to get login_tty(). On normal FreeBSD we would
> need libutil.h.
>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  configure.ac        | 2 ++
>  term-utils/agetty.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index afb255e..e9901bc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -208,6 +208,7 @@ AC_CHECK_HEADERS([ \
>  	getopt.h \
>  	inttypes.h \
>  	lastlog.h \
> +	libutil.h \
>  	linux/btrfs.h \
>  	linux/cdrom.h \
>  	linux/falloc.h \
> @@ -257,6 +258,7 @@ AC_CHECK_HEADERS([ \
>  	sys/un.h \
>  	unistd.h \
>  	shadow.h \
> +	utmp.h \
>  	utmpx.h \
>  ])
>
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 46eea01..95236ce 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -55,7 +55,13 @@
>  #endif
>
>  #if defined(__FreeBSD_kernel__)
> -#include <pty.h>
> +# include <pty.h>

BTW I think that pty.h is not needed here at all. It was added in
c32270d4 for login_tty() probably because in "man login_tty" it's hard 
to see that you only need utmp.h. There is no pty.h on non-GNU FreeBSD.

> +# ifdef HAVE_UTMPX_H
> +#  include <utmp.h>
> +# endif
> +# ifdef HAVE_LIBUTIL_H
> +#  include <libutil.h>
> +# endif
>  #endif
>
>  #ifdef __linux__


