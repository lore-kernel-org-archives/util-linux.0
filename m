Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp13.ono.com ([62.42.230.16]:43363 "EHLO resmaa13.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751208Ab2E0X25 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 27 May 2012 19:28:57 -0400
Date: Mon, 28 May 2012 01:23:00 +0200
From: Guillem Jover <guillem@hadrons.org>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] logger: use memcpy instead of bcopy
Message-ID: <20120527232300.GA15566@gaara.hadrons.org>
References: <1337805360-16469-1-git-send-email-dreisner@archlinux.org>
 <1337805360-16469-2-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337805360-16469-2-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-05-23 at 16:35:59 -0400, Dave Reisner wrote:
> bcopy is marked legacy in POSIX.1-2001 and should not be used.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  misc-utils/logger.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/misc-utils/logger.c b/misc-utils/logger.c
> index 19b4c47..a187227 100644
> --- a/misc-utils/logger.c
> +++ b/misc-utils/logger.c
> @@ -96,7 +96,7 @@ udpopenlog(const char *servername, uint16_t port) {
>  	if ((fd = socket(AF_INET, SOCK_DGRAM , 0)) == -1)
>  		err(EXIT_FAILURE, _("socket"));
>  
> -	bcopy(serverhost->h_addr,&s_addr.sin_addr,serverhost->h_length);
> +	memcpy(serverhost->h_addr,&s_addr.sin_addr,serverhost->h_length);

The src/dst arguments to memcpy() should get swapped.

thanks,
guillem
