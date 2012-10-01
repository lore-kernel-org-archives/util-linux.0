Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46374 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab2JAPl3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Oct 2012 11:41:29 -0400
Date: Mon, 1 Oct 2012 17:41:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libmount: fix support of comma-separated fs types
 lists
Message-ID: <20121001154120.GF8903@x2.net.home>
References: <20120927161807.GA19450@c227.office.altlinux.ru>
 <20120927164834.GA19341@c227.office.altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120927164834.GA19341@c227.office.altlinux.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

On Thu, Sep 27, 2012 at 08:48:34PM +0400, Gleb Fotengauer-Malinovskiy wrote:
> 	# grep cdrom /etc/fstab
> 	/dev/sr0 /media/cdrom udf,iso9660 ro,noauto,user,utf8 0 0
> 	# mount /media/cdrom
> 	mount: unknown filesystem type 'udf,iso9660'

 this first time I see that someone has a pattern in fstab, it seems
 undocumented and very probably unsupported on many places. But it
 seems that old (non-libmount) supported this feature too.

> 	# mount -t udf,iso9660 /dev/sr0 /media/cdrom
> 	mount: /dev/sr0 is write-protected, mounting read-only
> 
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> ---
>  libmount/src/context_mount.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
> index f3d8ff1..867e644 100644
> --- a/libmount/src/context_mount.c
> +++ b/libmount/src/context_mount.c
> @@ -691,9 +691,12 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
>  		cxt->mountdata = (char *) mnt_fs_get_fs_options(cxt->fs);
>  
>  	type = mnt_fs_get_fstype(cxt->fs);
> -	if (type)
> -		res = do_mount(cxt, NULL);
> -	else
> +	if (type) {
> +		if (strchr(type, ','))
> +			res = do_mount_by_pattern(cxt, type);
> +		else
> +			res = do_mount(cxt, NULL);
> +	} else
>  		res = do_mount_by_pattern(cxt, cxt->fstype_pattern);

 This is hack ;-)

 It would be better to improve mnt_context_apply_fstab() to initialize
 cxt->fstype_pattern (see mnt_context_set_fstype_pattern()) and
 zeroize cxt->fs->type if the fstab entry contains a pattern rather
 than a real fstype.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
