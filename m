Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbdKBJqn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Nov 2017 05:46:43 -0400
Date: Thu, 2 Nov 2017 10:46:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Mikhail Vorobyov <m.vorobyov@cs.msu.ru>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (sun) fix creation of whole disk partition
Message-ID: <20171102094639.ghg5dnqd2crq7hvs@ws.net.home>
References: <48789bdc-3354-5282-dbe8-fd81281324eb@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48789bdc-3354-5282-dbe8-fd81281324eb@cs.msu.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 02, 2017 at 04:04:42AM +0300, Mikhail Vorobyov wrote:
>  libfdisk/src/sun.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks. It was in my TODO :-)

> diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
> index 0526227ce..c058637f5 100644
> --- a/libfdisk/src/sun.c
> +++ b/libfdisk/src/sun.c
> @@ -543,6 +543,10 @@ static int sun_add_partition(
>                                 fdisk_ask_number_set_low(ask,     0);   /* minimal */
>                                 fdisk_ask_number_set_default(ask, 0);   /* default */
>                                 fdisk_ask_number_set_high(ask,    0);   /* maximal */
> +                       } else if (n == 2) {
> +                               fdisk_ask_number_set_low(ask,     0);   /* minimal */
> +                               fdisk_ask_number_set_default(ask, fdisk_scround(cxt, start));   /* default */
> +                               fdisk_ask_number_set_high(ask,    fdisk_scround(cxt, stop));    /* maximal */

I did a small change to the patch, I think we can use 0 as the default
for the 3rd partition.

>                         } else {
>                                 fdisk_ask_number_set_low(ask,     fdisk_scround(cxt, start));   /* minimal */
>                                 fdisk_ask_number_set_default(ask, fdisk_scround(cxt, start));   /* default */

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
