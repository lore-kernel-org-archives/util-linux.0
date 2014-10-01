Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52694 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbaJAKWz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 06:22:55 -0400
Date: Wed, 1 Oct 2014 12:22:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/23] libblkid: use pre-processor to optimize out code
Message-ID: <20141001102236.GL26272@x2.net.home>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
 <1411933916-30576-13-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411933916-30576-13-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 28, 2014 at 08:51:45PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  libblkid/src/superblocks/zfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/libblkid/src/superblocks/zfs.c b/libblkid/src/superblocks/zfs.c
> index 6ffa24d..088d110 100644
> --- a/libblkid/src/superblocks/zfs.c
> +++ b/libblkid/src/superblocks/zfs.c
> @@ -156,7 +156,6 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
>  	}
>  }
>  
> -#define zdebug(fmt, ...)	do {} while(0)
>  /*#define zdebug(fmt, a...)	fprintf(stderr, fmt, ##a)*/
>  
>  /* ZFS has 128x1kB host-endian root blocks, stored in 2 areas at the start
> @@ -172,7 +171,9 @@ static int probe_zfs(blkid_probe pr,
>  	int tried;
>  	int found;
>  
> +#ifdef zdebug
>  	zdebug("probe_zfs\n");
> +#endif

 no, this is bad way. It's always better to use empty macros than
 #ifdef, ifdef is evil

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
