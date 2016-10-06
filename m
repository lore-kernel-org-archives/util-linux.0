Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbcJFM7O (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Oct 2016 08:59:14 -0400
Date: Thu, 6 Oct 2016 14:59:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: Avoid strlen if only first char is checked
Message-ID: <20161006125912.p2xyff3h44gc36ub@ws.net.home>
References: <20161003200503.GA2287@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161003200503.GA2287@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 03, 2016 at 10:05:03PM +0200, Tobias Stoeckmann wrote:
> A strlen() call can lead to out of boundary read access if the
> superblock in question has no nul-bytes after the string. This
> could be avoided by using strnlen() but the calls in question
> merely existed to check if the string length is not 0.
> 
> By changing the calls as proposed with this diff, these files are
> in sync with other superblock files, which do exactly the same.
> ---
>  libblkid/src/superblocks/befs.c  | 2 +-
>  libblkid/src/superblocks/ext.c   | 2 +-
>  libblkid/src/superblocks/jfs.c   | 2 +-
>  libblkid/src/superblocks/nilfs.c | 2 +-
>  libblkid/src/superblocks/romfs.c | 2 +-
>  libblkid/src/superblocks/xfs.c   | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

 Applied, thanks.

> diff --git a/libblkid/src/superblocks/befs.c b/libblkid/src/superblocks/befs.c
> index 7e9eaf6..36e079f 100644
> --- a/libblkid/src/superblocks/befs.c
> +++ b/libblkid/src/superblocks/befs.c
> @@ -451,7 +451,7 @@ static int probe_befs(blkid_probe pr, const struct blkid_idmag *mag)
>  	/*
>  	 * all checks pass, set LABEL, VERSION and UUID
>  	 */
> -	if (strlen(bs->name))
> +	if (*bs->name != '\0')

Good catch, I hate it too. BTW, you can use

    if (*bs->name)

it's enough.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
