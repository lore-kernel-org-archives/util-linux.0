Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754658AbdKNKCV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Nov 2017 05:02:21 -0500
Date: Tue, 14 Nov 2017 11:02:16 +0100
From: Karel Zak <kzak@redhat.com>
To: jgroves@micron.com
Cc: util-linux@vger.kernel.org, John@Groves.net
Subject: Re: [PATCH 2/2] Add support for Micron mpool formatted drives
Message-ID: <20171114100216.zcixhekcz5u6wocc@ws.net.home>
References: <1510620313-6045-1-git-send-email-jgroves@micron.com>
 <1510620313-6045-3-git-send-email-jgroves@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510620313-6045-3-git-send-email-jgroves@micron.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 13, 2017 at 06:45:13PM -0600, jgroves@micron.com wrote:
> +const char *no  = "no";
> +const char *yes = "yes";
> +
> +static int probe_mpool(blkid_probe pr, const struct blkid_idmag *mag)
> +{
> +	struct omf_sb_descriptor *osd;
> +	uint32_t sb_crc;
> +
> +	osd = blkid_probe_get_sb(pr, mag, struct omf_sb_descriptor);
> +	if (!osd)
> +		return errno ? -errno : 1;
> +
> +	sb_crc = crc32c(~0L, (const void *)osd,
> +			offsetof(struct omf_sb_descriptor, osb_cksum1));
> +	sb_crc ^= ~0L;
> +
> +	if (!blkid_probe_verify_csum(pr, sb_crc, osd->osb_cksum1)) {
> +		blkid_probe_set_value(pr, "VALID",
> +			(unsigned char *)no, strlen(no) + 1);
> +		return -EINVAL;
> +	}

The function blkid_probe_verify_csum() defines SBBADCSUM variable if
the checksum is invalid and the application cares about such things (used
BLKID_SUBLKS_BADCSUM probing flag). The return code should be "1" rather
than -EINVAL.

Why we need "VALID"?

See for example libblkid/src/superblocks/lvm.c.

> +
> +	blkid_probe_set_value(pr, "VALID",
> +		(unsigned char *)yes, strlen(yes) + 1);
> +	blkid_probe_set_label(pr, osd->osb_name, sizeof(osd->osb_name));
> +	blkid_probe_set_uuid(pr, osd->osb_poolid);
> +
> +	return 0;
> +}
> +
> +/**
> + * Superblock (sb) -- magic = ASCII "mpoolDev"
> + */
> +#define MPOOL_SB_MAGIC "\x6D\x70\x6f\x6f\x6c\x44\x65\x76"
> +
> +const struct blkid_idinfo mpool_idinfo =
> +{
> +	.name		= "mpool",
> +	.usage		= BLKID_USAGE_FILESYSTEM,
> +	.probefunc	= probe_mpool,
> +	.magics		=
> +	{
> +		{ .magic = MPOOL_SB_MAGIC, .len = 8},
> +		{ NULL }
> +	}
> +};

It would be nice to have some reference (e.g. URL to docs) about
Micron mpool in code or in commit message ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
