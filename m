Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49980 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754141AbdFWR2s (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 13:28:48 -0400
Subject: Re: [PATCH 3/5] misc: fix more strutils related exit codes
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
 <1498164224-13549-4-git-send-email-sweet_f_a@gmx.de>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <e50780b9-ba85-5e7e-11cb-2db12c4c5bef@gmx.com>
Date: Fri, 23 Jun 2017 13:28:40 -0400
MIME-Version: 1.0
In-Reply-To: <1498164224-13549-4-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/22/2017 04:43 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Found by grep:
> 
> grep -l "\bEXIT_\|exit *( *[0-9][0-9] *)\|strutils\.h" $(grep -L \
>     strutils_set_exitcode  $(git grep -l "_EX_\|FINDFS_\|BLKID_EXIT\|EX_USAGE" -- "*.c"))
> 
> The Command shows also some false positives (fstrim.c,
> context_mount.c, ...)
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  disk-utils/fsck.cramfs.c | 2 ++
>  disk-utils/fsck.minix.c  | 2 ++
>  disk-utils/mkfs.cramfs.c | 2 ++
>  disk-utils/mkfs.minix.c  | 2 ++
>  sys-utils/flock.c        | 2 ++
>  sys-utils/hwclock.c      | 2 ++
>  sys-utils/mount.c        | 2 ++
>  7 files changed, 14 insertions(+)
>

 --- >8

>  
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 5433cd0..325106a 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1326,6 +1326,8 @@ int main(int argc, char **argv)
>  	};
>  	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
>  
> +	strutils_set_exitcode(EX_USAGE);
> +
>  	/* Remember what time we were invoked */
>  	gettimeofday(&startup_time, NULL);
>

If we keep this it needs to be: #if defined(__linux__) && defined(__alpha__)

I think the default EXIT_FAILURE is fine for this case.

