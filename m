Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14576 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645Ab1INOpn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Sep 2011 10:45:43 -0400
Date: Wed, 14 Sep 2011 16:45:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] mount: use common libs
Message-ID: <20110914144539.GA1829@nb.net.home>
References: <1315926455.3703.2.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315926455.3703.2.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 13, 2011 at 12:07:35PM -0300, Davidlohr Bueso wrote:
> --- a/mount/devname.c
> +++ b/mount/devname.c
> @@ -2,6 +2,7 @@
>  
>  #include "devname.h"
>  #include "sundries.h"		/* for xstrdup */
> +#include "xalloc.h"

 It would be better to include xalloc.h in sunders.h only.

> -static void
> -die_if_null(void *t) {
> -	if (t == NULL)
> -		die(EX_SYSERR, _("not enough memory"));
            ^^^^^^^^
> -}

 it means that you have to use:

 #define XALLOC_EXIT_CODE   EX_SYSERR
 #include "xalloc.h"

 to keep it backwardly compatible.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
