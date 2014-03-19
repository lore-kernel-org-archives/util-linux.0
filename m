Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbaCSRzs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Mar 2014 13:55:48 -0400
Date: Wed, 19 Mar 2014 18:55:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] blkid: convert superblocks to new calling convention
Message-ID: <20140319175541.GB31824@x2.net.home>
References: <1395237056-26595-1-git-send-email-hare@suse.de>
 <1395237056-26595-3-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395237056-26595-3-git-send-email-hare@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 19, 2014 at 02:50:56PM +0100, Hannes Reinecke wrote:
> --- a/libblkid/src/partitions/bsd.c
> +++ b/libblkid/src/partitions/bsd.c
> @@ -42,14 +42,18 @@ static int probe_bsd_pt(blkid_probe pr, const struct blkid_idmag *mag)
>  		return 0;
>  
>  	data = blkid_probe_get_sector(pr, BLKID_MAG_SECTOR(mag));
> -	if (!data)
> -		goto nothing;
> +	if (!data) {
> +		if (errno) 
> +			goto err;
> +		else
> +			goto nothing;
> +	}

 It would be nice to return the error code (-errno) from the function.

 Maybe you can use something like:

          int rc = 1;   /* default is nothing */

          data = blkid_probe_get_sector(pr, BLKID_MAG_SECTOR(mag));
          if (!data) {
              rc = error ? -errno : 1;
              goto done;
          }
         
          ...
          rc = 0;   /* success, all probing stuff pass */

        done:
          return rc;


 to reduce number of the code lines and number of goto labels and to return the 
 proper return code.


>  	ls = blkid_probe_get_partlist(pr);
>  	if (!ls)
> -		goto err;
> +		goto nothing;

 hmm.. it usually means malloc() error, I have doubts we want to
 ignore such errors, it would be probably better to return -ENOMEM
 in this case.

     if (!ls) {
        rc = -ENOMEM;
        goto done;
     }

 If you do the cleanup then do it for all errors, not for I/O only ;-)
  
> +		if (!data) {
> +			if (errno)
> +				goto err;
> +			else
> +				goto leave;	/* malformed partition? */
> +		}

  BTW, "else" after "goto" is probably unnecessary, just

    if (foo)
        goto y;
    goto x;

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
