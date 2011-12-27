Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15660 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822Ab1L0L3V (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Dec 2011 06:29:21 -0500
Date: Tue, 27 Dec 2011 12:29:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH] mount: don't canonicalize the source of a pseudofs
Message-ID: <20111227112916.GC2010@x2.net.home>
References: <1324937423-15766-1-git-send-email-dreisner@archlinux.org> <1324943244-27332-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324943244-27332-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 26, 2011 at 06:47:24PM -0500, Dave Reisner wrote:
> In line with previous patches, the source of a pseudofs is strictly
> semantic; do not attempt to resolve it to a filesystem path.
> 
> As a side effect of this, nspec needs to be initialized to NULL since
> it may not be assigned null by spec_to_devname when the FS is deemed
> a pseudofs.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
> This wasn't as evil as I thought, after all...
> 
>  mount/mount.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mount/mount.c b/mount/mount.c
> index 9b444c4..49d49f6 100644
> --- a/mount/mount.c
> +++ b/mount/mount.c
> @@ -2016,7 +2016,7 @@ is_existing_file (const char *s) {
>  static int
>  mount_one (const char *spec, const char *node, const char *types,
>  	   const char *fstabopts, char *cmdlineopts, int freq, int pass) {
> -	const char *nspec;
> +	const char *nspec = NULL;
>  	char *opts;
>  
>  	/* Substitute values in opts, if required */
> @@ -2046,7 +2046,8 @@ mount_one (const char *spec, const char *node, const char *types,
>  			      strncmp(types, "nfs", 3) &&
>  			      strncmp(types, "cifs", 4) &&
>  			      strncmp(types, "smbfs", 5))) {
> -		nspec = spec_to_devname(spec);
> +		if (!is_pseudo_fs(types))
> +			nspec = spec_to_devname(spec);

 Exactly this is implemented in spec_to_devname(), it does not
 canonicalize pseudo filesystems.

>  		if (nspec)
>  			spec = nspec;
>  	}
> -- 
> 1.7.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
