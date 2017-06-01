Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57268 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdFASum (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Jun 2017 14:50:42 -0400
Subject: Re: [PATCH 6/6] misc: fix some warnings
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
 <1496279320-14541-7-git-send-email-sweet_f_a@gmx.de>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0035d164-75ac-f892-2cbe-0fb8184116cb@gmx.com>
Date: Thu, 1 Jun 2017 14:50:34 -0400
MIME-Version: 1.0
In-Reply-To: <1496279320-14541-7-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 05/31/2017 09:08 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>

 8< ---

> diff --git a/lib/plymouth-ctrl.c b/lib/plymouth-ctrl.c
> index 75d8b93..0e60341 100644
> --- a/lib/plymouth-ctrl.c
> +++ b/lib/plymouth-ctrl.c
> @@ -85,7 +85,8 @@ static int open_un_socket_and_connect(void)
>  	 * Please note that the PLYMOUTH_SOCKET_PATH has a
>  	 * leading NULL byte to mark it as an abstract socket
>  	 */
> -	ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1 + strlen(su.sun_path+1));
> +	ret = connect(fd, (const struct sockaddr *) &su,
> +	              offsetof(struct sockaddr_un, sun_path) + 1 + strlen(su.sun_path+1));
        ^^^^^^^^^^^^^^ whitespace

 8< ---

