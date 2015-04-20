Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:55814 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbbDTAeY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 19 Apr 2015 20:34:24 -0400
Message-ID: <5534498B.4080803@gmx.com>
Date: Sun, 19 Apr 2015 20:34:19 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Alexey Galakhov <agalakhov@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>
In-Reply-To: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Alexey,

 I've been advocating for the removal of the compare function. One of my
 justifications for doing so is that it has been broken from day one and
 therefore nobody can be using for anything.

 So could you tell me how you are using it, and what useful purpose it is
 serving for you?

Thanks
 William

On 04/16/2015 11:26 AM, Alexey Galakhov wrote:
> This allows using hwclock -c in automated test scripts that parse
> its output line-by-line. The standard output is flushed before
> each 10 second delay.
> 
> Signed-off-by: Alexey Galakhov <agalakhov@gmail.com>
> ---
>  sys-utils/hwclock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index e1e5816..4cdb2ea 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1532,6 +1532,7 @@ static int compare_clock (const bool utc, const bool local_opt)
>  			printf("hw-time      system-time         freq-offset-ppm   tick\n");
>  			printf("%10.0f   %10.6f\n", (double) time1_hw, time1_sys);
>  		}
> +		fflush(stdout);
>  		sleep(10);
>  	}
>  
> 
