Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:50512 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbABME6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 2 Jan 2015 07:04:58 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 9DDEFE30F
	for <util-linux@vger.kernel.org>; Fri,  2 Jan 2015 12:39:17 +0100 (CET)
Date: Fri, 2 Jan 2015 12:39:14 +0100
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: exit 2 when no specified tags match
Message-ID: <20150102113914.GA16549@fatal.se>
References: <1420150414-7628-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420150414-7628-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello again!

Sorry, I forgot s-o-b. Added below.

On Thu, Jan 01, 2015 at 11:13:34PM +0100, Andreas Henriksson wrote:
> ,---- [ man blkid ]
> | RETURN CODE
> |        If the specified token was found, or if any tags were shown from (specified) devices, 0 is returned.
> |        If the specified token was not found, or no (specified) devices could be identified, an exit code of 2 is returned.
> |        For usage or other errors, an exit code of 4 is returned.
> |        If the ambivalent low-level probing result was detected, an exit code of 8 is returned.
> `----
> 
> The code doesn't seem to work like described in the (first part of the)
> second sentence. The exit code is only 2 if *no* tokens was identified,
> 0 if tokens was found but none matched the filter.
> 
> This changes the code so that the exit code is 2 if the *specified* tag
> is not found, as described in the manpage.
> 
> Reported-by: Michael Prokop <mika@debian.org>
> Addresses: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=772846

Signed-off-by: Andreas Henriksson <andreas@fatal.se>

> ---
>  misc-utils/blkid.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> 
> WARNING: This is a behaviour change. Maybe it's safer to just change
> the manpage to document the actual behaviour instead of changing it.
> Please review carefully and decide if this patch is safe (and correct
> since it's only been very lightly tested).
> 
> Further work: The mixed usage of 'tokens' and 'tag(s)' in the manpage
> confuses me and unless I'm mistaken is sometimes also wrong. Eg. you
> specify a tag with "-s <tag>", there's no way "specified token" is
> possible, et.al. It would be welcome if anyone wants to review and
> improve the manpage to be easier to understand.
> 
> 
> diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
> index 1bd8646..e605df2 100644
> --- a/misc-utils/blkid.c
> +++ b/misc-utils/blkid.c
> @@ -320,7 +320,7 @@ static void print_value(int output, int num, const char *devname,
>  	}
>  }
>  
> -static void print_tags(blkid_dev dev, char *show[], int output)
> +static int print_tags(blkid_dev dev, char *show[], int output)
>  {
>  	blkid_tag_iterate	iter;
>  	const char		*type, *value, *devname;
> @@ -328,18 +328,18 @@ static void print_tags(blkid_dev dev, char *show[], int output)
>  	static int		first = 1;
>  
>  	if (!dev)
> -		return;
> +		return 0;
>  
>  	if (output & OUTPUT_PRETTY_LIST) {
>  		pretty_print_dev(dev);
> -		return;
> +		return 0;
>  	}
>  
>  	devname = blkid_dev_devname(dev);
>  
>  	if (output & OUTPUT_DEVICE_ONLY) {
>  		printf("%s\n", devname);
> -		return;
> +		return 0;
>  	}
>  
>  	iter = blkid_tag_iterate_begin(dev);
> @@ -362,6 +362,10 @@ static void print_tags(blkid_dev dev, char *show[], int output)
>  			printf("\n");
>  		first = 0;
>  	}
> +
> +	if (num > 1)
> +		return 0;
> +	return BLKID_EXIT_NOTFOUND;
>  }
>  
>  
> @@ -903,8 +907,7 @@ int main(int argc, char **argv)
>  
>  		if ((dev = blkid_find_dev_with_tag(cache, search_type,
>  						   search_value))) {
> -			print_tags(dev, show, output_format);
> -			err = 0;
> +			err = print_tags(dev, show, output_format);
>  		}
>  	/* If we didn't specify a single device, show all available devices */
>  	} else if (!numdev) {
> @@ -916,11 +919,14 @@ int main(int argc, char **argv)
>  		iter = blkid_dev_iterate_begin(cache);
>  		blkid_dev_set_search(iter, search_type, search_value);
>  		while (blkid_dev_next(iter, &dev) == 0) {
> +			int tagerr;
> +
>  			dev = blkid_verify(cache, dev);
>  			if (!dev)
>  				continue;
> -			print_tags(dev, show, output_format);
> -			err = 0;
> +			tagerr = print_tags(dev, show, output_format);
> +			if (err != 0)
> +				err = tagerr;
>  		}
>  		blkid_dev_iterate_end(iter);
>  	/* Add all specified devices to cache (optionally display tags) */
> @@ -929,12 +935,15 @@ int main(int argc, char **argv)
>  						  BLKID_DEV_NORMAL);
>  
>  		if (dev) {
> +			int tagerr;
> +
>  			if (search_type &&
>  			    !blkid_dev_has_tag(dev, search_type,
>  					       search_value))
>  				continue;
> -			print_tags(dev, show, output_format);
> -			err = 0;
> +			tagerr = print_tags(dev, show, output_format);
> +			if (err != 0)
> +				err = tagerr;
>  		}
>  	}
>  
> -- 
> 2.1.4
> 
