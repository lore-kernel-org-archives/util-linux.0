Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f182.google.com ([209.85.220.182]:58125 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143Ab3AIWrS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 17:47:18 -0500
Received: by mail-vc0-f182.google.com with SMTP id fy27so2116756vcb.41
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 14:47:18 -0800 (PST)
Date: Wed, 9 Jan 2013 17:47:15 -0500
From: Dave Reisner <d@falconindy.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] build-sys: add chkdupexe and uuidd socket activation
 to most-builds
Message-ID: <20130109224715.GY31925@rampage>
References: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
 <1357771446-11966-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357771446-11966-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 09, 2013 at 10:44:06PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---

chkdupexe was marked as deprecated and turned off by default in
4581bd9c6797ea3b75. Maybe generalize the commit message as well, since
this does a lot more than just enable the 2 builds it claims.

>  configure.ac | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 16255b1..e937736 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -673,15 +673,17 @@ AC_ARG_ENABLE([most-builds],
>  )
>  if test "x$enable_most_builds" = xyes; then
>    enable_arch=check
> +  enable_chfn_chsh=yes
> +  enable_chkdupexe=yes
>    enable_elvtune=check
> -  enable_tunelp=yes
>    enable_last=yes
>    enable_line=yes
>    enable_mesg=yes
> +  enable_newgrp=yes
>    enable_reset=yes
> +  enable_socket_activation=yes
> +  enable_tunelp=yes
>    enable_vipw=yes
> -  enable_chfn_chsh=yes
> -  enable_newgrp=yes
>    enable_write=yes
>  fi
>  
> -- 
> 1.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
