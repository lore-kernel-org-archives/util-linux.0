Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757332Ab2EWIWc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 May 2012 04:22:32 -0400
Date: Wed, 23 May 2012 10:22:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] text-utils: use min() from c.h
Message-ID: <20120523082203.GK14560@x2.net.home>
References: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
 <1337240469-24539-3-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1337240469-24539-3-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 17, 2012 at 09:41:08AM +0200, Petr Uzel wrote:
>  text-utils/display.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/text-utils/display.c b/text-utils/display.c
> index ad638e7..84ec5d8 100644
> --- a/text-utils/display.c
> +++ b/text-utils/display.c
> @@ -41,14 +41,11 @@
>  #include <string.h>
>  #include "hexdump.h"
>  #include "xalloc.h"
> +#include "c.h"
>  
>  static void doskip(const char *, int);
>  static u_char *get(void);
>  
> -#ifndef MIN
> -#define MIN(a,b) ((a)<(b)?(a):(b))
> -#endif
> -
>  enum _vflag vflag = FIRST;
>  
>  static off_t address;			/* address/offset in stream */
> @@ -262,7 +259,7 @@ get(void)
>  			return(curp);
>  		}
>  		n = fread((char *)curp + nread, sizeof(unsigned char),
> -		    length == -1 ? need : MIN(length, need), stdin);
> +		    length == -1 ? need : min(length, need), stdin);

 It seems that the macro works as expected and detects some
 disadvantages :-)

 display.c: In function ‘get’:
 display.c:262:117: warning: comparison of distinct pointer types
 lacks a cast [enabled by default]

 Fixed and applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
