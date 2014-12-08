Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055AbaLHLhS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Dec 2014 06:37:18 -0500
Date: Mon, 8 Dec 2014 12:37:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] mkfs.cramfs: fix unsigned integer overflow
 [AddressSanitizer]
Message-ID: <20141208113706.GD19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
 <1417355862-16935-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417355862-16935-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 30, 2014 at 01:57:39PM +0000, Sami Kerola wrote:
> --- a/disk-utils/mkfs.cramfs.c
> +++ b/disk-utils/mkfs.cramfs.c
> @@ -619,7 +619,10 @@ do_compress(char *base, unsigned int offset, unsigned char const *name,
>  	/* TODO: Arguably, original_size in these 2 lines should be
>  	   st_blocks * 512.  But if you say that, then perhaps
>  	   administrative data should also be included in both. */
> -	change = new_size - original_size;
> +	if (new_size <= original_size)
> +		change = new_size - original_size;
> +	else
> +		change = new_size;

Is it correct?

>  	if (verbose)
>  		printf(_("%6.2f%% (%+ld bytes)\t%s\n"),
>  		       (change * 100) / (double) original_size, change, name);

The verbose message reports difference between old and new size (in
{+,-} bytes) Your patch use complete new_size if this number is bigger
that original_size.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
