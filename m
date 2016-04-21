Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46443 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbcDUIo6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Apr 2016 04:44:58 -0400
Date: Thu, 21 Apr 2016 10:44:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Victor Dodon <dodonvictor@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sfdisk: exit with error if rereading partition table
 fails
Message-ID: <20160421084451.kpqo3z3xbyxwlsor@ws.net.home>
References: <1461223498-19392-1-git-send-email-dodonvictor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461223498-19392-1-git-send-email-dodonvictor@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 21, 2016 at 12:24:58AM -0700, Victor Dodon wrote:
> Use the return value of fdisk_reread_partition_table in write_changes so that
> sfdisk exits with error if re-reading the partition table fails.
> 
> Signed-off-by: Victor Dodon <dodonvictor@gmail.com>
> ---
>  disk-utils/sfdisk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
> index 15fa99c..b520c9b 100644
> --- a/disk-utils/sfdisk.c
> +++ b/disk-utils/sfdisk.c
> @@ -534,7 +534,7 @@ static int write_changes(struct sfdisk *sf)
>  			rc = move_partition_data(sf, sf->partno, sf->orig_pa);
>  		if (!rc) {
>  			fdisk_info(sf->cxt, _("\nThe partition table has been altered."));
> -			fdisk_reread_partition_table(sf->cxt);
> +			rc = fdisk_reread_partition_table(sf->cxt);

Yes, the old sfdisk implementation exit with error in this case, but
I'm not sure about it. The problem is that partition table is properly
written to the device (but kernel don't use it). If would be nice to
distinguish between this non-fatal error and another errors. Maybe we
need more return codes.

 0 -- success
 1 -- fatal error
 2 -- minor error (e.g. reread problem)


.. or so. We can also add error codes for initial re-read check, etc.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
