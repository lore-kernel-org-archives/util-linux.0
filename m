Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751307AbeFVJwz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 22 Jun 2018 05:52:55 -0400
Date: Fri, 22 Jun 2018 11:52:52 +0200
From: Karel Zak <kzak@redhat.com>
To: kmahlkuc@linux.vnet.ibm.com
Cc: util-linux@vger.kernel.org, KyleMahlkuch <Kyle.Mahlkuch@ibm.com>
Subject: Re: [PATCH] libfdisk: Fix multipath partition seperators for
 user-friendly names
Message-ID: <20180622095252.ik5n2oki4ekcsnbg@ws.net.home>
References: <1529597254-1342-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529597254-1342-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 21, 2018 at 11:07:34AM -0500, kmahlkuc@linux.vnet.ibm.com wrote:
> diff --git a/libfdisk/src/utils.c b/libfdisk/src/utils.c
> index 5ba9e04..031c783 100644
> --- a/libfdisk/src/utils.c
> +++ b/libfdisk/src/utils.c
> @@ -153,7 +153,18 @@ char *fdisk_partname(const char *dev, size_t partno)
>  	if ((strncmp(dev, _PATH_DEV_BYID, sizeof(_PATH_DEV_BYID) - 1) == 0) ||
>  	     strncmp(dev, _PATH_DEV_BYPATH, sizeof(_PATH_DEV_BYPATH) - 1) == 0 ||
>  	     strncmp(dev, "/dev/mapper", sizeof("/dev/mapper") - 1) == 0) {
> -	       p = "-part";
> +		asprintf(&res, "%.*s%zu", w, dev, partno);
> +		if (access(res, F_OK) == 0){
> +			p = "";
> +		} else {
> +			/* check for partition seperator "p" */
> +			p = "p";
> +			asprintf(&res, "%.*s%s%zu", w, dev, p, partno);

asprintf() always allocates a new string, right? ... in this case I
see a memory leak :-)

    Karel

> +			if (access(res, F_OK) != 0){
> +				/* otherwise, default to "-path" */
> +				p = "-part";
> +			}
> +		}
>  	}
>  
>  	if (asprintf(&res, "%.*s%s%zu", w, dev, p, partno) <= 0)
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
