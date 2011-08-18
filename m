Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22270 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199Ab1HRJcC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Aug 2011 05:32:02 -0400
Date: Thu, 18 Aug 2011 11:31:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Nick Erdmann <erdmann@date.upb.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] ddate: St. Tib's Day in other languages
Message-ID: <20110818093157.GG699@nb.net.home>
References: <1976757.PW98uZrV7g@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1976757.PW98uZrV7g@arch>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 17, 2011 at 08:35:02PM +0200, Nick Erdmann wrote:
> In other languages than english, the translation of "St. Tib's Day" may not
> be 13 bytes long. Example of what happens in german:
> $ ddate 29 2 2008
> St. Tib’s D, 3174 YOLD
> 
> Signed-off-by: Nick Erdmann <erdmann@date.upb.de>
> --- a/misc-utils/ddate.c	2011-07-20 21:55:23.000000000 +0200
> +++ b/misc-utils/ddate.c	2011-08-17 18:11:12.437504258 +0200
> @@ -223,6 +223,7 @@
>      int tib_start=-1, tib_end=0;
>      int i, fmtlen=strlen(fmt);
>      char *bufptr=buf;
> +    char *foo;
>  
>  /*    fprintf(stderr, "format(%p, \"%s\", dt)\n", buf, fmt);*/
>  
> @@ -249,7 +250,9 @@
>      for(i=0; i<fmtlen; i++) {
>  	if((i==tib_start) && (dt.day==-1)) {
>  	    /* handle St. Tib's Day */
> -	    strcpy(bufptr, _("St. Tib's Day")); bufptr += 13;
> +	    foo = _("St. Tib's Day");
> +	    while((*bufptr++=*foo++));
> +	    --bufptr;
>  	    i=tib_end;

        strcpy(bufptr, _("St. Tib's Day"));
        bufptr += strlen(bufptr);

seems more readable.

Anyway, the horrible code does not check the size of the bufptr, etc.

I'm still surprised that we have this crazy thing in util-linux
package and it's enabled by default. I'll probably add --enable-ddate.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
