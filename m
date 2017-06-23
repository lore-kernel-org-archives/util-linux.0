Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754473AbdFWR3A (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 13:29:00 -0400
Subject: Re: [PATCH 4/5] misc: fix xalloc.h related exit codes
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
 <1498164224-13549-5-git-send-email-sweet_f_a@gmx.de>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <bc3701b6-8946-f8a3-1659-e64b42c438ec@gmx.com>
Date: Fri, 23 Jun 2017 13:28:52 -0400
MIME-Version: 1.0
In-Reply-To: <1498164224-13549-5-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/22/2017 04:43 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Found by:
> 
> grep -L "XALLOC_EXIT_CODE" $(grep -l "xalloc\.h" \
>     $(git grep -l "_EX_\|FINDFS_\|BLKID_EXIT\|EX_USAGE" -- "*.c"))
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  disk-utils/mkfs.minix.c | 2 ++
>  misc-utils/blkid.c      | 2 ++
>  sys-utils/hwclock.c     | 1 +
>  sys-utils/mount.c       | 4 +++-
>  sys-utils/umount.c      | 2 ++
>  5 files changed, 10 insertions(+), 1 deletion(-)
> 

 --- >8

> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 325106a..5c34144 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -71,6 +71,7 @@
>  #include <unistd.h>
>  
>  #define OPTUTILS_EXIT_CODE EX_USAGE
> +#define XALLOC_EXIT_CODE EX_OSERR

I think the default EXIT_FAILURE is fine for this case.

