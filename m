Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:49171 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756568AbaEaO0M (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 31 May 2014 10:26:12 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Petr Uzel <petr.uzel@suse.cz>
Subject: Re: [PATCH] sfdisk: suppress Linux-irrelevant warnings with -L
Date: Sat, 31 May 2014 16:25:32 +0200
Cc: "util-linux" <util-linux@vger.kernel.org>,
        Roberto Angelino <rangelino@novell.com>,
        Holger Hetterich <hhetter@suse.com>,
        Stanislav Brabec <sbrabec@suse.cz>
References: <1401121683-18503-1-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1401121683-18503-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405311625.33102.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 26 May 2014, Petr Uzel wrote:
> Sfdisk prints out a warning about extended partition not
> starting at a cylinder boundary. Since this is irrelevant
> for linux, the -L option should suppress this warning.

I would really like to have -L enabled by default on linux. Project name
is util-LINUX and if we even run it on linux, why being still bothered 
per default?

BTW we have some more warnings of this kind in libfdisk/src/dos.c
where we don't have option -L:

/* Same physical / logical beginning? */
if (cxt->geom.cylinders <= 1024
    && (pbc != lbc || pbh != lbh || pbs != lbs)) {
       fdisk_warnx(cxt, _("Partition %zu: different physical/logical "
               "beginnings (non-Linux?): "
               "phys=(%d, %d, %d), logical=(%d, %d, %d)"),
                partition + 1,
                pbc, pbh, pbs,
                lbc, lbh, lbs);
}


> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  disk-utils/sfdisk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
> index 3c55d5e..12162af 100644
> --- a/disk-utils/sfdisk.c
> +++ b/disk-utils/sfdisk.c
> @@ -1383,7 +1383,7 @@ extended_partition(char *dev, int fd, struct
> part_desc *ep, struct disk_desc *z) "from %lld to %lld\n"
>  		      "(For listing purposes only. "
>  		      "Do not change its contents.)"), ep->start, start);
> -	} else {
> +	} else if (!Linux) {
>  	    warnx(_("Warning: extended partition does not start at a "
>  		      "cylinder boundary.\n"
>
