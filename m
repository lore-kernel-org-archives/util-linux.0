Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbdFTIor (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 04:44:47 -0400
Date: Tue, 20 Jun 2017 10:44:42 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/12] include: update pathnames.h
Message-ID: <20170620084442.5ok4wkwyjikb2sgj@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <154d3dd1-21c1-aa9f-8148-e14e97e10e10@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <154d3dd1-21c1-aa9f-8148-e14e97e10e10@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 18, 2017 at 08:42:55PM -0400, J William Piggott wrote:
> 
> * use /dev/rtc0 (/dev/rtc was for the 'old' driver)
> * remove hwclock Award workaround and alpha cmos paths
> * relocate _PATH_BTMP from hwclock to login-utils
> * add a comment for _PATH_BTMP and fix other login-utils comments
> * add a comment for proc/cpuinfo
> * remove empty shutdown.c comment from 4d43977f
> 
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
>  include/pathnames.h | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/include/pathnames.h b/include/pathnames.h
> index de6abe6..c07f9a6 100644
> --- a/include/pathnames.h
> +++ b/include/pathnames.h
> @@ -57,12 +57,10 @@
>  #define _PATH_TERMCOLORS_DIRNAME "terminal-colors.d"
>  #define _PATH_TERMCOLORS_DIR	"/etc/" _PATH_TERMCOLORS_DIRNAME
>  
> -/* used in login-utils/shutdown.c */
> -
> -/* used in login-utils/setpwnam.h and login-utils/islocal.c */
> +/* used in login-utils/{setpwnam.h,islocal.c} */
>  #define _PATH_PASSWD		"/etc/passwd"

Frankly, do we really need "used in ..." messages in this file? I
guess everyone is able to use "git grep" (etc). 

It's header file, it should be used everywhere, from this point of
view the "used in" messages seems strange at all. Maybe we can remove
these comments completely.

> -/* used in login-utils/newgrp and login-utils/setpwnam.h*/
> +/* used in login-utils/{newgrp.c,setpwnam.h} */
>  #define _PATH_GSHADOW		"/etc/gshadow"
>  
>  /* used in login-utils/setpwnam.h */
> @@ -70,6 +68,11 @@
>  #define _PATH_SHADOW_PASSWD	"/etc/shadow"
>  #define _PATH_SHELLS		"/etc/shells"
>  
> +/* used in login-utils/{login.c,su-common.c,last.c,lslogins.c}  */
> +#ifndef _PATH_BTMP
> +#define _PATH_BTMP		"/var/log/btmp"
> +#endif

 # define 
  ^
It's better to use space behind '#' within #ifdefs. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
