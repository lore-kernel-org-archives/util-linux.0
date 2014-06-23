Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5021 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbaFWKrz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Jun 2014 06:47:55 -0400
Date: Mon, 23 Jun 2014 12:47:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: special treatment for auto in fstype pattern
Message-ID: <20140623104750.GI25885@x2.net.home>
References: <1403466290-12880-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403466290-12880-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 22, 2014 at 09:44:50PM +0200, Andreas Henriksson wrote:
> However, merging `auto' with other types doesn't work as expected:
> 	mount -t ext2,auto /dev/sde /media/stick
> does not mount /dev/sde but returns:
> 	mount: unknown filesystem type 'auto'

 Interesting use case.

> Trying multiple fstypes before allowing mount to guess makes sense in
> different scenarios, for example to prefer specific fstypes (ext2
> instead of ext3) or to try fstypes that mount doesn't guess (minix).

 I hope libblkid is able to detect minix ;-)

> diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
> index dcfdabf..d07fa02 100644
> --- a/libmount/src/context_mount.c
> +++ b/libmount/src/context_mount.c
> @@ -782,6 +782,8 @@ static int do_mount_by_pattern(struct libmnt_context *cxt, const char *pattern)
>  			char *end = strchr(p, ',');
>  			if (end)
>  				*end = '\0';
> +			if (strcmp(p, "auto") == 0)
> +				p = NULL;
>  			rc = do_mount(cxt, p);

 This is insufficient solution, the code has to call an FS detection
 code. I have applied a little different solution.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
