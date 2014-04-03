Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f44.google.com ([209.85.216.44]:52476 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933675AbaDCBiG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Apr 2014 21:38:06 -0400
Received: by mail-qa0-f44.google.com with SMTP id dc16so1004539qab.3
        for <util-linux@vger.kernel.org>; Wed, 02 Apr 2014 18:38:05 -0700 (PDT)
Date: Wed, 2 Apr 2014 21:38:08 -0400
From: Dave Reisner <d@falconindy.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org, thomas@archlinux.org
Subject: Re: [PATCH] switch_root: verify initramfs by f_type, not devno
Message-ID: <20140403013808.GD585@rampage>
References: <1396449690-4215-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396449690-4215-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 02, 2014 at 10:41:30AM -0400, Dave Reisner wrote:
> As of linux 3.14, the initramfs device will have both major and
> minor 0, causing our paranoia check to fail. Make this version agnostic
> by checking the filesystem type, rather than a device number.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
> This is essentially what busybox's switch_root does. I don't think there's much
> value in checking the devno at all, as it seems to be a needless restriction.
> Let's just allow deleting anything that looks like non-persistent storage.

A bisect of the kernel reveals that 9e30cc9595303 is the responsible
change. It seems the kernel maintains its own mounts which are never
exposed to userspace (which also would explain the FSID gaps in
/proc/self/mountinfo). An instance of sysfs used to be one of these
kernel only mounts but, for some time now, has not needed to be. The
mentioned commit removes this kern_mount() call for sysfs, making the
initramfs the first entry in the mount table -- FSID 0 instead of 1.

I guess FSIDs are about as reliable as the numbering on block devices,
and this comparison in switch_root was never really the right
approach...

> 
>  sys-utils/switch_root.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
> index 1222fb1..dac946f 100644
> --- a/sys-utils/switch_root.c
> +++ b/sys-utils/switch_root.c
> @@ -23,6 +23,7 @@
>  #include <sys/mount.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/statfs.h>
>  #include <sys/param.h>
>  #include <fcntl.h>
>  #include <stdio.h>
> @@ -36,6 +37,7 @@
>  #include "c.h"
>  #include "nls.h"
>  #include "closestream.h"
> +#include "statfs_magic.h"
>  
>  #ifndef MS_MOVE
>  #define MS_MOVE 8192
> @@ -177,12 +179,12 @@ static int switchroot(const char *newroot)
>  	if (cfd >= 0) {
>  		pid = fork();
>  		if (pid <= 0) {
> -			if (fstat(cfd, &sb) == 0) {
> -				if (sb.st_dev == makedev(0, 1))
> -					recursiveRemove(cfd);
> -				else
> -					warn(_("old root filesystem is not an initramfs"));
> -			}
> +			struct statfs stfs;
> +			if (fstatfs(cfd, &stfs) == 0 &&
> +			    (stfs.f_type == STATFS_RAMFS_MAGIC || stfs.f_type == STATFS_TMPFS_MAGIC))
> +				recursiveRemove(cfd);
> +			else
> +				warn(_("old root filesystem is not an initramfs"));
>  
>  			if (pid == 0)
>  				exit(EXIT_SUCCESS);
> -- 
> 1.9.1
> 
