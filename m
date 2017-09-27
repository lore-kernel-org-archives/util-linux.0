Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752654AbdI0LvG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 27 Sep 2017 07:51:06 -0400
Date: Wed, 27 Sep 2017 13:50:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] losetup: Add support for logical block size
Message-ID: <20170927115057.avd7knn7qbqheeld@ws.net.home>
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 26, 2017 at 04:14:51PM +0200, Stanislav Brabec wrote:
> @@ -55,6 +56,7 @@ struct loop_info64 {
>  	uint64_t	lo_rdevice;
>  	uint64_t	lo_offset;
>  	uint64_t	lo_sizelimit; /* bytes, 0 == max available */
> +	uint64_t	lo_blocksize;
>  	uint32_t	lo_number;
>  	uint32_t	lo_encrypt_type;
>  	uint32_t	lo_encrypt_key_size;

See kernel include/uapi/linux/loop.h and the Omars' commit. It does not extend
LOOP_{GET,SET}_STATUS ioctl and loop_info64 struct. All the block size patch is
completely independent ioctl.

> +int loopcxt_get_blocksize(struct loopdev_cxt *lc, uint64_t *blocksize)
> +{
> +	struct sysfs_cxt *sysfs = loopcxt_get_sysfs(lc);
> +	int rc = -EINVAL;
> +
> +	if (sysfs)
> +		rc = sysfs_read_u64(sysfs, "queue/logical_block_size", blocksize);

Yes, /sys is fine.

> +	if (rc && loopcxt_ioctl_enabled(lc)) {
> +		struct loop_info64 *lo = loopcxt_get_info(lc);
> +		if (lo) {
> +			if (blocksize)
> +				*blocksize = lo->lo_blocksize;
> +			rc = 0;
> +		} else
> +			rc = -errno;

This fallback cannot work, because kernel does not provides lo_blocksize by
LOOP_GET_STATUS64. You have to use common BLKSSZGET ioctl.

I'll fix it and ask for review.

	Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
