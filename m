Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22894 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbaCTL37 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 20 Mar 2014 07:29:59 -0400
Date: Thu, 20 Mar 2014 11:48:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] blkid: stop scanning on I/O error
Message-ID: <20140320104803.GB26374@x2.net.home>
References: <1395309830-58744-1-git-send-email-hare@suse.de>
 <1395309830-58744-2-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395309830-58744-2-git-send-email-hare@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 20, 2014 at 11:03:49AM +0100, Hannes Reinecke wrote:
> +/**
> + * blkid_probe_get_idmag:
> + * @pr: probe
> + * @id: id information
> + * @offset: begin of probing area
> + * @res: found id information
> + *
> + * Check for matching magic value.
> + * Returns BLKID_PROBE_OK if found, BLKID_PROBE_NONE if not found
> + * or no magic present, or negative value on error.
> + */
>  int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
>  			blkid_loff_t *offset, const struct blkid_idmag **res)
>  {
> @@ -794,6 +812,8 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
>  		off = (mag->kboff + (mag->sboff >> 10)) << 10;
>  		buf = blkid_probe_get_buffer(pr, off, 1024);
>  
> +		if (!buf && errno)
> +			return errno;

            return -errno;

 Otherwise it looks good.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
