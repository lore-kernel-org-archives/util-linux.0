Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59044 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946042AbcBRNVd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:21:33 -0500
Date: Thu, 18 Feb 2016 14:21:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/15] include: provide MAP_ANONYMOUS on OSX
Message-ID: <20160218132130.i3egpqw3lv7i653w@ws.net.home>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
 <1455801169-10470-8-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455801169-10470-8-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 18, 2016 at 02:12:47PM +0100, Ruediger Meier wrote:
> +#if defined __APPLE__
> +# define _DARWIN_C_SOURCE
> +#endif
> +
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <stdint.h>
> @@ -62,6 +66,10 @@
>  #define XALLOC_EXIT_CODE FSCK_EX_ERROR
>  #include "xalloc.h"
>  
> +#if !defined MAP_ANONYMOUS && defined MAP_ANON
> +# define MAP_ANONYMOUS  (MAP_ANON)
> +#endif

What about to move this to include/c.h where we already have some
portability ifdefs?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
