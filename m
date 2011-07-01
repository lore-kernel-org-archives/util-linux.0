Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4121 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961Ab1GANLm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:11:42 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p61DBgBN011808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 1 Jul 2011 09:11:42 -0400
Received: from nb (ovpn-113-68.phx2.redhat.com [10.3.113.68])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p61DBfaW009997
	for <util-linux@vger.kernel.org>; Fri, 1 Jul 2011 09:11:41 -0400
Date: Fri, 1 Jul 2011 15:11:40 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] sfdisk: warn if partition starts above 2 TiB limit
Message-ID: <20110701131140.GQ6418@nb.net.home>
References: <20110701111154.GA24105@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110701111154.GA24105@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 01, 2011 at 01:11:56PM +0200, Petr Uzel wrote:
> 
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  fdisk/sfdisk.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
> index 4ed5d37..d498371 100644
> --- a/fdisk/sfdisk.c
> +++ b/fdisk/sfdisk.c
> @@ -1304,6 +1304,17 @@ partitions_ok(struct disk_desc *z) {
>  	    }
>      }
>  
> +    /* Do the partitions start below the DOS 2TiB limit? */
> +    {
> +	for (p = partitions; p < partitions + partno; p++)
> +	    if (p->size && p->start > (unsigned long) UINT32_MAX) {

 ULONG_MAX is not greater than UINT32_MAX on 32-bit archs ;-)

 IMHO you have to use 64-bit number for the p->size or you have 
 move the check to the place where (before) p->start is incremented.

> +	        my_warn(_("Warning: partition %s has starting sector %lu, "
> +		          "which is above the DOS 2 TiB limit\n"),

 The warning is incorrect. The limit is not 2 TiB, but UINT32_MAX
 *sectors*. It's 2TiB for 512-byte sectors, but for 4K sectors is it
 more...

 See fdisk.fdisk.c: warn_limits().

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
