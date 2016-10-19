Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755126AbcJSOLm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 19 Oct 2016 10:11:42 -0400
Date: Wed, 19 Oct 2016 13:41:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Gustavo Zacarias <gustavo@zacarias.com.ar>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/crc32: prefix public functions
Message-ID: <20161019114151.kx6cmoeiofulptem@ws.net.home>
References: <1476132864-9526-1-git-send-email-gustavo@zacarias.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476132864-9526-1-git-send-email-gustavo@zacarias.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2016 at 05:54:24PM -0300, Gustavo Zacarias wrote:
> --- a/disk-utils/fsck.cramfs.c
> +++ b/disk-utils/fsck.cramfs.c
> @@ -214,7 +214,7 @@ static void test_crc(int start)
>  		return;
>  	}
>  
> -	crc = crc32(0L, Z_NULL, 0);
> +	crc = ul_crc32(0L, Z_NULL, 0);
>  
>  	buf =
>  	    mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> @@ -231,8 +231,8 @@ static void test_crc(int start)
>  	}
>  	if (buf != MAP_FAILED) {
>  		((struct cramfs_super *)((unsigned char *) buf + start))->fsid.crc =
> -		    crc32(0L, Z_NULL, 0);
> -		crc = crc32(crc, (unsigned char *) buf + start, super.size - start);
> +		    ul_crc32(0L, Z_NULL, 0);
> +		crc = ul_crc32(crc, (unsigned char *) buf + start, super.size - start);

BTW, this is incorrect. cramfs code is based on crc32 from zlib :-)

The difference is that zlib does the final post-conditioning. Our
implementation requires this step (xor) from application. 

It's fine to use zlib there, because we also use compression from the
library for cramfs.

I have reverted the change for {mkfs,fsck}.cramfs.c

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
