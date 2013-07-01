Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21167 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350Ab3GAMF0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Jul 2013 08:05:26 -0400
Date: Mon, 1 Jul 2013 14:05:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] ul: enhance command performance
Message-ID: <20130701120515.GB1946@x2.net.home>
References: <1372581840-18966-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372581840-18966-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 30, 2013 at 09:44:00AM +0100, Sami Kerola wrote:
> Avoid reseting, time after time, the memory which was not used.  Effect
> of the change is below in before and after timings.
> 
> $ time ./ul </etc/services >/dev/null
> real    0m0.320s
> user    0m0.307s
> sys     0m0.010s
> 
> $ time ./ul </etc/services >/dev/null
> real    0m0.068s
> user    0m0.050s
> sys     0m0.017s

 Good catch :-)

> @@ -491,11 +491,11 @@ static void initbuf(void)
>  	if (obuf == NULL) {
>  		/* First time. */
>  		obuflen = BUFSIZ;
> -		obuf = xmalloc(sizeof(struct CHAR) * obuflen);
> +		obuf = xcalloc(obuflen, sizeof(struct CHAR));
>  	}
>  
    else

>  	/* assumes NORMAL == 0 */
> -	memset(obuf, 0, sizeof(struct CHAR) * obuflen);
> +	memset(obuf, 0, sizeof(struct CHAR) * col);

 I think 'maxcol' rather than col is more precise solution ;-) 

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
