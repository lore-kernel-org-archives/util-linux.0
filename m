Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752571AbdFTIvr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 04:51:47 -0400
Date: Tue, 20 Jun 2017 10:51:43 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/12] hwclock: update --help content and grammar
Message-ID: <20170620085143.cu5dpcobcr3t254m@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <bf8f26c6-c0d8-2190-38ed-456dfe0fe58a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bf8f26c6-c0d8-2190-38ed-456dfe0fe58a@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 18, 2017 at 08:45:09PM -0400, J William Piggott wrote:
> 
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
>  include/c.h         |  4 ++--
>  sys-utils/hwclock.c | 48 +++++++++++++++++++++---------------------------
>  2 files changed, 23 insertions(+), 29 deletions(-)
> 
> diff --git a/include/c.h b/include/c.h
> index 9c19965..bd073fc 100644
> --- a/include/c.h
> +++ b/include/c.h
> @@ -319,8 +319,8 @@ static inline int xusleep(useconds_t usec)
>  #define USAGE_OPTIONS    _("\nOptions:\n")
>  #define USAGE_FUNCTIONS  _("\nFunctions:\n")
>  #define USAGE_SEPARATOR    "\n"
> -#define USAGE_HELP       _(" -h, --help     display this help and exit\n")
> -#define USAGE_VERSION    _(" -V, --version  output version information and exit\n")
> +#define USAGE_HELP       _(" -h, --help     display this information and exit\n")

 "display this help and exit\n"
or
 "display help information and exit\n"

sounds better than "this information".

> +#define USAGE_VERSION    _(" -V, --version  display version information and exit\n")

This is better than the original.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
