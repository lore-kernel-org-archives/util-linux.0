Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:41872 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab2DZCQx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Apr 2012 22:16:53 -0400
Received: from localhost (ool-4a5aad93.dyn.optonline.net [74.90.173.147])
	by gerolde.archlinux.org (Postfix) with ESMTPSA id 3FE1F90049
	for <util-linux@vger.kernel.org>; Wed, 25 Apr 2012 22:16:28 -0400 (EDT)
Date: Wed, 25 Apr 2012 22:16:51 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] findmnt: add match_by_file to do within-device
 matching
Message-ID: <20120426021651.GH938@rampage>
References: <1335400252-17929-1-git-send-email-dreisner@archlinux.org>
 <1335400252-17929-2-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335400252-17929-2-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 25, 2012 at 08:30:52PM -0400, Dave Reisner wrote:
> Use the newly exported mnt_get_mountpoint to determine the device that a
> given file resides on, in case the supplied source or target is not
> explicitly a mount point.
> 
> http://www.spinics.net/lists/util-linux-ng/msg06081.html
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---

On second thought, this isn't good -- it'll return results even when
you're searching with --fstab (which is completely undesirable, imo).

>  misc-utils/findmnt.c |   28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
> index cc71a60..9db167f 100644
> --- a/misc-utils/findmnt.c
> +++ b/misc-utils/findmnt.c
> @@ -661,6 +661,30 @@ static int tab_is_tree(struct libmnt_table *tb)
>  	return rc;
>  }
>  
> +static int match_by_file(const char *name, struct libmnt_fs *fs,
> +		int (*match_fn)(struct libmnt_fs*, const char*, struct libmnt_cache*))
> +{
> +	char *resolved, *mountpoint;
> +	int match;
> +
> +	/* match exactly by name */
> +	if (match_fn(fs, name, cache))
> +		return 1;
> +
> +	/* maybe its a file within a mountpoint */
> +	resolved = mnt_resolve_path(name, cache);
> +	if (resolved) {
> +		mountpoint = mnt_get_mountpoint(resolved);
> +		if (mountpoint) {
> +			match = match_fn(fs, mountpoint, cache);
> +			free(mountpoint);
> +			return match;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /* filter function for libmount (mnt_table_find_next_fs()) */
>  static int match_func(struct libmnt_fs *fs,
>  		      void *data __attribute__ ((__unused__)))
> @@ -670,11 +694,11 @@ static int match_func(struct libmnt_fs *fs,
>  	void *md;
>  
>  	m = get_match(COL_TARGET);
> -	if (m && !mnt_fs_match_target(fs, m, cache))
> +	if (m && !match_by_file(m, fs, mnt_fs_match_target))
>  		return rc;
>  
>  	m = get_match(COL_SOURCE);
> -	if (m && !mnt_fs_match_source(fs, m, cache))
> +	if (m && !match_by_file(m, fs, mnt_fs_match_source))
>  		return rc;
>  
>  	m = get_match(COL_FSTYPE);
> -- 
> 1.7.10
> 
