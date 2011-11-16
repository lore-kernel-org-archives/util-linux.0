Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab1KPMgg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:36:36 -0500
Date: Wed, 16 Nov 2011 13:36:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/15] prlimit: add opt_id array to match short options
	to limit ids
Message-ID: <20111116123633.GB7916@nb.net.home>
References: <4EC07354.8000803@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC07354.8000803@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:04AM +0100, Bernhard Voelker wrote:
> +	static const size_t opt_id[] = {
> +		['c'] = CORE,
> +		['d'] = DATA,
> +		['e'] = NICE,
> +		['f'] = FSIZE,
> +		['i'] = SIGPENDING,
> +		['l'] = MEMLOCK,
> +		['m'] = RSS,
> +		['n'] = NOFILE,
> +		['q'] = MSGQUEUE,
> +		['r'] = RTPRIO,
> +		['s'] = STACK,
> +		['t'] = CPU,
> +		['u'] = NPROC,
> +		['v'] = AS,
> +		['x'] = LOCKS,
> +		['y'] = RTTIME
> +		/* h = help, o = output columns, p = pid, V = version */
> +	};

 Sorry, not applied. This change does not make the code more robust or
 readable and does not fix any error.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
