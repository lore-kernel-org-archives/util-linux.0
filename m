Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:40283 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754082Ab2CROxl (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Mar 2012 10:53:41 -0400
Subject: Re: [PATCH 1/5] checkxalloc: nudge regex, fix newfound instances
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
In-Reply-To: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
References: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 18 Mar 2012 15:53:37 +0100
Message-ID: <1332082417.2792.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 2012-03-17 at 23:36 -0400, Dave Reisner wrote:
> Using the -w flag with grep actually fought against us here, and hid
> some instances where xalloc functions weren't used. Discard it in favor
> of an explicit word boundary as a prefix to the function name, and
> extend our requirements on the trailing side of the pattern.
> 
> This also fixes the few new instances that were overlooked because of
> the regex's deficiency.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  fdisk/sfdisk.c       |    2 +-
>  sys-utils/swapon.c   |    4 ++--
>  tools/checkxalloc.sh |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
> index 6267652..e766b04 100644
> --- a/fdisk/sfdisk.c
> +++ b/fdisk/sfdisk.c
> @@ -304,7 +304,7 @@ restore_sectors(char *dev) {
>  	error(_("partition restore file has wrong size - not restoring\n"));
>  	goto err;
>      }
> -    if (!(ss0 = (char *)malloc(statbuf.st_size))) {
> +    if (!(ss0 = xmalloc(statbuf.st_size))) {
>  	error(_("out of memory?\n"));
>  	goto err;
>      }

xmalloc and friends abort the program when allocation fail.

> diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
> index f17fad6..fe16169 100644
> --- a/sys-utils/swapon.c
> +++ b/sys-utils/swapon.c
> @@ -197,7 +197,7 @@ read_proc_swaps(void) {
>  			       *p = '\0';
>  		}
>  
> -		q = realloc(swapFiles, (numSwaps+1) * sizeof(*swapFiles));
> +		q = xrealloc(swapFiles, (numSwaps+1) * sizeof(*swapFiles));
>  		if (q == NULL)
>  			break;

same here. This would actually break functionality.

>  		swapFiles = q;
> @@ -640,7 +640,7 @@ swapon_all(void) {
>  		if (!streq(fstab->mnt_type, MNTTYPE_SWAP))
>  			continue;
>  
> -		opts = strdup(fstab->mnt_opts);
> +		opts = xstrdup(fstab->mnt_opts);
>  
>  		for (opt = strtok(opts, ","); opt != NULL;
>  		     opt = strtok(NULL, ",")) {
> diff --git a/tools/checkxalloc.sh b/tools/checkxalloc.sh
> index 578340e..6634c82 100755
> --- a/tools/checkxalloc.sh
> +++ b/tools/checkxalloc.sh
> @@ -10,7 +10,7 @@ cd "$(git rev-parse --show-toplevel)" || {
>  }
>  
>  git grep -zl '#include "xalloc.h"' |
> -  xargs -0 grep -nwE '[^x](([cm]|re)alloc|strdup)\('
> +  xargs -0 grep -nE '\b(([cm]|re)alloc|strdup)[[:space:]]*\([^)]'
>  
>  result=$?
>  


