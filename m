Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753758Ab3JHNwx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Oct 2013 09:52:53 -0400
Date: Tue, 8 Oct 2013 15:52:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: fix compiler warning [smatch]
Message-ID: <20131008135243.GB13559@x2.net.home>
References: <1381183463-1297-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381183463-1297-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 07, 2013 at 11:04:22PM +0100, Sami Kerola wrote:
> warning: overflow in implicit constant conversion
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  libblkid/src/superblocks/bcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libblkid/src/superblocks/bcache.c b/libblkid/src/superblocks/bcache.c
> index 303f7ee..f5a8ce6 100644
> --- a/libblkid/src/superblocks/bcache.c
> +++ b/libblkid/src/superblocks/bcache.c
> @@ -20,7 +20,7 @@
>  #define node(i, j)         ((i)->d + (j))
>  #define end(i)             node(i, (i)->keys)
>  
> -static const char bcache_magic[] = {
> +static const unsigned char bcache_magic[] = {
>  	0xc6, 0x85, 0x73, 0xf6, 0x4e, 0x1a, 0x45, 0xca,
>  	0x82, 0x65, 0xf5, 0x7f, 0x48, 0xba, 0x6d, 0x81
>  };

 The code is correct, the magic string is "const char *", not
 unsigned... gcc does not like your patch:

 libblkid/src/superblocks/bcache.c:129:3: warning: pointer targets in initialization differ in signedness [-Wpointer-sign]


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
