Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59083 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab2A1QKH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 28 Jan 2012 11:10:07 -0500
Received: by qcsg15 with SMTP id g15so1493562qcs.19
        for <util-linux@vger.kernel.org>; Sat, 28 Jan 2012 08:10:06 -0800 (PST)
Date: Sat, 28 Jan 2012 11:10:03 -0500
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount: define fallback selinux_warning macro with 2
 params
Message-ID: <20120128161003.GH567@rampage>
References: <1327329084-4273-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327329084-4273-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 23, 2012 at 09:31:24AM -0500, Dave Reisner wrote:
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  sys-utils/mount.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sys-utils/mount.c b/sys-utils/mount.c
> index 280bab0..7c11811 100644
> --- a/sys-utils/mount.c
> +++ b/sys-utils/mount.c
> @@ -286,7 +286,7 @@ static void selinux_warning(struct libmnt_context *cxt, const char *tgt)
>  	}
>  }
>  #else
> -# define selinux_warning(_x)
> +# define selinux_warning(_x, _y)
>  #endif
>  
>  
> -- 
> 1.7.8.4
> 

Pinging this in case it was overlooked. It fixes the build for those of
us not using selinux.
