Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdHAJ1c (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 05:27:32 -0400
Date: Tue, 1 Aug 2017 11:27:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/9] chfn, chsh: merge auth.h, islocal.h and libuser.h to
 ch-common.h
Message-ID: <20170801092726.jyajaltu5mpihjgo@ws.net.home>
References: <20170731195508.11661-1-kerolasa@iki.fi>
 <20170731195508.11661-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170731195508.11661-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 31, 2017 at 08:55:00PM +0100, Sami Kerola wrote:
> diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
> index 67a0c98ec..2cc91b658 100644
> --- a/login-utils/Makemodule.am
> +++ b/login-utils/Makemodule.am
> @@ -90,20 +90,17 @@ if HAVE_LINUXPAM
>  chfn_chsh_ldadd += -lpam_misc
>  endif
>  chfn_chsh_sources += \
> -	login-utils/auth.c \
> -	login-utils/auth.h
> +	login-utils/auth.c
>  endif # CHFN_CHSH_PASSWORD
>  
>  if HAVE_USER
>  chfn_chsh_ldflags += $(LIBUSER_LIBS)
>  chfn_chsh_cflags += $(LIBUSER_CFLAGS)
>  chfn_chsh_sources+= \
> -	login-utils/libuser.c \
> -	login-utils/libuser.h
> +	login-utils/libuser.c
>  else
>  chfn_chsh_sources += \
>  	login-utils/islocal.c \
> -	login-utils/islocal.h \
>  	login-utils/setpwnam.c \
>  	login-utils/setpwnam.h
>  endif

seems nowhere in the Makefile is our new ch-common.h

> --- a/login-utils/chfn.c
> +++ b/login-utils/chfn.c
> @@ -35,7 +35,6 @@
>  #include "c.h"
>  #include "env.h"
>  #include "closestream.h"
> -#include "islocal.h"
>  #include "nls.h"
>  #include "setpwnam.h"
>  #include "strutils.h"
> @@ -51,9 +50,6 @@
>  
>  #ifdef HAVE_LIBUSER
>  # include <libuser/user.h>
> -# include "libuser.h"
> -#elif CHFN_CHSH_PASSWORD
> -# include "auth.h"
>  #endif

It would be better to include libuser in the ch-common.h
if the function the header file depends on the library.


Frankly, I'm not sure if this patch improves readability of the code.
Now we have to ways (pam and libuser) and both is pretty separated by
.c and .h files. Not sure if merge it makes it better.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
