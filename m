Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:38664 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965076Ab2EPIwn convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 May 2012 04:52:43 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Date: Wed, 16 May 2012 10:52:40 +0200
Subject: RE: [PATCH 2/2] blkid: introduce symbolic names for different blkid
 exit codes
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F1E5D2336@MCHP058A.global-ad.net>
References: <1337157512-31920-1-git-send-email-petr.uzel@suse.cz>
 <1337157512-31920-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1337157512-31920-2-git-send-email-petr.uzel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Petr Uzel wrote:

> Subject: [PATCH 2/2] blkid: introduce symbolic names for different blkid exit codes
> 
> 
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  misc-utils/blkid.c |   32 ++++++++++++++++++--------------
>  1 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
> index 4f7050f..52b2a4b 100644
> --- a/misc-utils/blkid.c
> +++ b/misc-utils/blkid.c
> @@ -34,11 +34,15 @@ extern int optind;
>  #define LOWPROBE_TOPOLOGY	(1 << 1)
>  #define LOWPROBE_SUPERBLOCKS	(1 << 2)
>  
> +#define BLKID_EXIT_NOTFOUND	2	/* token or device not found */
> +#define BLKID_EXIT_OTHER	4	/* bad usage or other error */
> +#define BLKID_EXIT_AMBIVAL	8	/* ambivalent low-level probing detected */
> +
>  #include <blkid.h>
>  
>  #include "ismounted.h"
>  
> -#define STRTOXX_EXIT_CODE	4		/* strtoxx_or_err() */
> +#define STRTOXX_EXIT_CODE	BLKID_EXIT_OTHER	/* strtoxx_or_err() */

STRTOXX_EXIT_CODE is not used in blkid.c. Remove it?
... or if it used in strutils.h, then this is not a nice interface.

>  #include "strutils.h"
>  #include "closestream.h"
>  #include "ttyutils.h"
> @@ -484,7 +488,7 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
>  	fd = open(devname, O_RDONLY);
>  	if (fd < 0) {
>  		fprintf(stderr, "error: %s: %m\n", devname);
> -		return 2;
> +		return BLKID_EXIT_NOTFOUND;
>  	}
>  	if (blkid_probe_set_device(pr, fd, offset, size))
>  		goto done;
> @@ -551,9 +555,9 @@ done:
>  	close(fd);
>  
>  	if (rc == -2)
> -		return 8;	/* ambivalent probing result */
> +		return BLKID_EXIT_AMBIVAL;	/* ambivalent probing result */
>  	if (!nvals)
> -		return 2;	/* nothing detected */
> +		return BLKID_EXIT_NOTFOUND;	/* nothing detected */
>  
>  	return 0;		/* success */
>  }

These are not exit() codes, but return codes. That value doesn't seem
to be of much interest anyway, because it's used only here in main()
in a for-loop, forgetting the return value of the previous iteration:

               for (i = 0; i < numdev; i++)
                        err = lowprobe_device(pr, devices[i], lowprobe, show,
                                        output_format,
                                        (blkid_loff_t) offset,
                                        (blkid_loff_t) size);

Have a nice day,
Berny

