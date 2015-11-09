Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbbKIIsz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Nov 2015 03:48:55 -0500
Date: Mon, 9 Nov 2015 09:48:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 08/12] mkfs.bfs: fix block device open race
Message-ID: <20151109084854.GO19508@ws.net.home>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
 <1446319284-24778-9-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446319284-24778-9-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 31, 2015 at 07:21:20PM +0000, Sami Kerola wrote:
> This fix makes mkfs.bfs also to detect if block device is busy, and warn if
> the device is misaligned.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  disk-utils/mkfs.bfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
> index 7057194..139130e 100644
> --- a/disk-utils/mkfs.bfs.c
> +++ b/disk-utils/mkfs.bfs.c
> @@ -187,7 +187,7 @@ int main(int argc, char **argv)
>  	if (!S_ISBLK(statbuf.st_mode))
>  		errx(EXIT_FAILURE, _("%s is not a block special device"), device);
>  
> -	fd = open(device, O_RDWR | O_EXCL);
> +	fd = open_blkdev_or_file(device, O_RDWR);

 It seems code assumes block devices only, why we need _or_file()
 here? It would be enough to check statbuf and fstat(fd) for inode
 number if you want to avoid races.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
