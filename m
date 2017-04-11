Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54722 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbdDKSpP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Apr 2017 14:45:15 -0400
Subject: Re: [PATCH] hwclock: fix non-linux build
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1491897955-22436-1-git-send-email-sweet_f_a@gmx.de>
Cc: Sami Kerola <kerolasa@iki.fi>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <64fc96d4-3e5f-ee6d-2ab9-bc90c8f8c5e9@gmx.com>
Date: Tue, 11 Apr 2017 14:45:02 -0400
MIME-Version: 1.0
In-Reply-To: <1491897955-22436-1-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 04/11/2017 04:05 AM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> There was one missing ifdef since 336f7c5f.

They were both in that 'if' test before 336f7c5f:

-       if (!(show | set | systohc | hctosys | systz | adjust | getepoch
-             | setepoch | predict | compare | get))
-               show = 1;       /* default to show */

But they were defined for all arches then:

-       /* Set option defaults */
-       show = set = systohc = hctosys = systz = adjust = noadjfile = predict =
-           compare = get = update = FALSE;
-       getepoch = setepoch = utc = local_opt = directisa = testing = debug = FALSE;


I think the old way was a cleaner solution, so in sys-utils/hwclock.h:35:

- #ifdef __linux__
  		getepoch:1,
  		setepoch:1,
- #endif
	
Should work? I do not have a way to test it.


> 
> CC: Sami Kerola <kerolasa@iki.fi>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  sys-utils/hwclock.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 3875bcc..3e0d6e9 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1520,9 +1520,12 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (!(ctl.show | ctl.set | ctl.systohc | ctl.hctosys |
> -	     ctl.systz | ctl.adjust | ctl.getepoch | ctl.setepoch |
> -	     ctl.predict | ctl.get))
> +	if (!(ctl.show | ctl.set | ctl.systohc | ctl.hctosys
> +	     | ctl.systz | ctl.adjust | ctl.predict | ctl.get
> +#ifdef __linux__
> +	     | ctl.getepoch | ctl.setepoch
> +#endif
> +	     ))
>  		ctl.show = 1;	/* default to show */
>  
>  #ifdef __linux__
> 
