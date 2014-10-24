Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbaJXJhh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 05:37:37 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9O9bbQv003912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 05:37:37 -0400
Date: Fri, 24 Oct 2014 11:37:33 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Federico Simoncelli <fsimonce@redhat.com>
cc: util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: [PATCH 2/2] blkdiscard: fail on sector misalignment
In-Reply-To: <1414078476-11007-2-git-send-email-fsimonce@redhat.com>
Message-ID: <alpine.LFD.2.00.1410241127260.2242@localhost.localdomain>
References: <1414078476-11007-1-git-send-email-fsimonce@redhat.com> <1414078476-11007-2-git-send-email-fsimonce@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 23 Oct 2014, Federico Simoncelli wrote:

> Date: Thu, 23 Oct 2014 15:34:36 +0000
> From: Federico Simoncelli <fsimonce@redhat.com>
> To: util-linux@vger.kernel.org
> Cc: kzak@redhat.com, lczerner@redhat.com,
>     Federico Simoncelli <fsimonce@redhat.com>
> Subject: [PATCH 2/2] blkdiscard: fail on sector misalignment
> 
> ---
>  sys-utils/blkdiscard.c            | 10 +++++++---
>  tests/expected/blkdiscard/offsets | 12 ++++++------
>  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
> index 1eb2b285..76c72b8 100644
> --- a/sys-utils/blkdiscard.c
> +++ b/sys-utils/blkdiscard.c
> @@ -144,9 +144,9 @@ int main(int argc, char **argv)
>  	if (ioctl(fd, BLKSSZGET, &secsize))
>  		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), path);
>  
> -	/* align range to the sector size */
> -	range[0] = (range[0] + secsize - 1) & ~(secsize - 1);
> -	range[1] &= ~(secsize - 1);
> +	/* check offset alignment to the sector size */
> +	if (range[0] % secsize)
> +		errx(EXIT_FAILURE, _("%s: offset %" PRIu64 " is not aligned"), path, range[0]);
>  
>  	/* is the range end behind the end of the device ?*/
>  	if (range[0] > blksize)
> @@ -155,6 +155,10 @@ int main(int argc, char **argv)
>  	if (end < range[0] || end > blksize)
>  		range[1] = blksize - range[0];
>  
> +	/* check length alignment to the sector size */
> +	if (range[1] % secsize)
> +		errx(EXIT_FAILURE, _("%s: length %" PRIu64 " is not aligned"), path, range[1]);
> +

Looks good, however remember that the tool is intended to be used by
the end user, can we be a bit more helpful ? We already know the
secsize it should be aligned to, so we can print that as well.

However it just occurred to me that aligning it to secsize is not
enough. It should be aligned to discard_granularity.

Thanks!
-Lukas

>  	if (secure) {
>  		if (ioctl(fd, BLKSECDISCARD, &range))
>  			err(EXIT_FAILURE, _("%s: BLKSECDISCARD ioctl failed"), path);
> diff --git a/tests/expected/blkdiscard/offsets b/tests/expected/blkdiscard/offsets
> index 766c39d..abedb08 100644
> --- a/tests/expected/blkdiscard/offsets
> +++ b/tests/expected/blkdiscard/offsets
> @@ -1,16 +1,16 @@
>  create loop device from image
>  testing offsets with full block size
>  Discarded 10485760 bytes from the offset 0
> -Discarded 10485248 bytes from the offset 512
> -Discarded 10485248 bytes from the offset 512
> +blkdiscard: offset 1 is not aligned
> +blkdiscard: offset 511 is not aligned
>  Discarded 10485248 bytes from the offset 512
>  Discarded 10484736 bytes from the offset 1024
>  testing offsets with specific length
>  Discarded 5242880 bytes from the offset 0
> -Discarded 5242880 bytes from the offset 0
> -Discarded 5242880 bytes from the offset 0
> -Discarded 5242880 bytes from the offset 512
> -Discarded 5242880 bytes from the offset 512
> +blkdiscard: length 5242881 is not aligned
> +blkdiscard: length 5243391 is not aligned
> +blkdiscard: offset 1 is not aligned
> +blkdiscard: offset 511 is not aligned
>  Discarded 5242880 bytes from the offset 512
>  Discarded 5242880 bytes from the offset 1024
>  detach loop device from image
> 
