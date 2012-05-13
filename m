Return-Path: util-linux-owner@vger.kernel.org
Received: from 220-245-31-42.static.tpgi.com.au ([220.245.31.42]:36339 "EHLO
	smtp.sws.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab2EMNta (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 May 2012 09:49:30 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Petr Uzel <petr.uzel@suse.cz>
Subject: Re: [PATCH 2/3] mkswap: allow creating swap on /dev/hd[ab]
Date: Sun, 13 May 2012 23:38:51 +1000
Cc: "util-linux" <util-linux@vger.kernel.org>, 491021@bugs.debian.org
References: <1336909472-12277-1-git-send-email-petr.uzel@suse.cz> <1336909472-12277-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336909472-12277-2-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201205132338.51614.russell@coker.com.au>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The patch looks good.  Although as /dev/hda seems to be unused it probably 
won't affect anyone.  It would be nice to get this Debian bug closed before it 
turns 4.

On Sun, 13 May 2012, Petr Uzel <petr.uzel@suse.cz> wrote:
> Currently, mkswap does not allow swap to be created on /dev/hda and
> /dev/hdb. There is no reason why /dev/hda and /dev/hdb should be treated
> differently.
> 
> Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=491021
> Cc: Russell Coker <russell@coker.com.au>
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  disk-utils/mkswap.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
> index c7dedd7..dec34e1 100644
> --- a/disk-utils/mkswap.c
> +++ b/disk-utils/mkswap.c
> @@ -596,13 +596,8 @@ main(int argc, char **argv) {
>  		exit(EXIT_FAILURE);
>  	}
> 
> -	/* Want a block device. Probably not /dev/hda or /dev/hdb. */
>  	if (!S_ISBLK(statbuf.st_mode))
>  		check=0;
> -	else if (statbuf.st_rdev == 0x0300 || statbuf.st_rdev == 0x0340)
> -		errx(EXIT_FAILURE, _("error: "
> -			"will not try to make swapdevice on '%s'"),
> -			device_name);
>  	else if (is_mounted(device_name))
>  		errx(EXIT_FAILURE, _("error: "
>  			"%s is mounted; will not make swapspace."),


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
