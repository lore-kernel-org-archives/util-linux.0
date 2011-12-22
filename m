Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp14.ono.com ([62.42.230.176]:17386 "EHLO resmaa14.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752683Ab1LVCaB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Dec 2011 21:30:01 -0500
Received: from gaara.hadrons.org (85.136.45.65) by resmaa14.ono.com (8.5.113) (authenticated as guillemj@ono.com)
        id 4EE6D4B4001BD983 for util-linux@vger.kernel.org; Thu, 22 Dec 2011 03:24:44 +0100
Received: from guillem by gaara.hadrons.org with local (Exim 4.77)
	(envelope-from <guillemj@ono.com>)
	id 1RdYKp-00085r-ID
	for util-linux@vger.kernel.org; Thu, 22 Dec 2011 03:24:43 +0100
Date: Thu, 22 Dec 2011 03:24:43 +0100
From: Guillem Jover <guillem@hadrons.org>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/13] fdisk: drop one parameter from try() function
Message-ID: <20111222022443.GA31045@gaara.hadrons.org>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
 <1323975769-21929-4-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323975769-21929-4-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi!

On Thu, 2011-12-15 at 20:02:40 +0100, Francesco Cosoleto wrote:
> @@ -2800,15 +2800,13 @@ gpt_warning(char *dev)
>  }
>  
>  static void
> -try(char *device, int user_specified) {
> +try(char *device)
> +{
>  	int gb;
>  
>  	disk_device = device;
>  	if (setjmp(listingbuf))
>  		return;
> -	if (!user_specified)
> -		if (is_ide_cdrom_or_tape(device))
> -			return;
>  	gpt_warning(device);
>  	if ((fd = open(disk_device, type_open)) >= 0) {
>  		gb = get_boot(try_only);
> @@ -2859,7 +2857,7 @@ tryprocpt(void) {
>  		if (is_whole_disk(devname)) {
>  			char *cn = canonicalize_path(devname);
>  			if (cn) {
> -				try(cn, 0);
> +				try(cn);
>  				free(cn);
>  			}
>  		}
> @@ -3079,7 +3077,8 @@ main(int argc, char **argv) {
>  			dummy(&k);
>  			listing = 1;
>  			for (k = optind; k < argc; k++)
> -				try(argv[k], 1);
> +				if (!is_ide_cdrom_or_tape(argv[k]))
> +					try(argv[k]);
>  		} else {
>  			/* we no longer have default device names */
>  			/* but we can use /proc/partitions instead */

The logic on user_specified is inverted so it seems the checks on the
call sites would need to be swapped?

regards,
guillem
