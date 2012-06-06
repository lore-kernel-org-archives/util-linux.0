Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5239 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab2FFJjJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Jun 2012 05:39:09 -0400
Date: Wed, 6 Jun 2012 11:38:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] fdisk: add device topology to the API
Message-ID: <20120606093842.GA28227@x2.net.home>
References: <1338747317.2864.10.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338747317.2864.10.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 03, 2012 at 08:15:17PM +0200, Davidlohr Bueso wrote:
> +unsigned long grain = DEFAULT_SECTOR_SIZE;

It would be nice to move align functions to util.c too.

 - the "grain" is set in update_sector_offset(), this function
   should be probably renamed to __discover_alignment() and called
   always when sector size is modified or DOS mode is enabled/disabled.

>  static void
> -get_topology(struct fdisk_context *cxt) {
....

> -         io_size = blkid_topology_get_optimal_io_size(tp);
....

> -			if (io_size || alignment_offset ||
> -			    (min_io_size & (min_io_size - 1)))
> -				has_topology = 1;
> -			if (!io_size)
> -				/* optimal IO is optional, default to minimum IO */
> -				io_size = min_io_size;

 See how io_size is used here, the code assumes that io_size is the
 same as optimal_iosize to set has_topology = 1;

 ....
> +static int __discover_topology(struct fdisk_context *cxt)
> +{
> +#ifdef HAVE_LIBBLKID
> +	blkid_probe pr;
> +
> +	pr = blkid_new_probe();
> +	if (pr && blkid_probe_set_device(pr, cxt->dev_fd, 0, 0) == 0) {
> +		blkid_topology tp = blkid_probe_get_topology(pr);
> +
> +		if (tp) {
> +			cxt->min_io_size = blkid_topology_get_minimum_io_size(tp);
> +			cxt->io_size = blkid_topology_get_optimal_io_size(tp);
> +			cxt->phy_sector_size = blkid_topology_get_physical_sector_size(tp);
> +			cxt->alignment_offset = blkid_topology_get_alignment_offset(tp);
> +
> +			if (!cxt->io_size)
> +				/* optimal IO is optional, default to minimum IO */
> +				cxt->io_size = cxt->min_io_size;

  ... but in your new code, io_size maybe overwritten by min_io_size,
  so, the new function:

> +int fdisk_dev_has_topology(struct fdisk_context *cxt)
> +{
> +	/* 
> +	 * Assume that the device provides topology info if
> +	 * optimal_io_size is set or alignment_offset is set or
> +	 * minimum_io_size is not power of 2.
> +	 */
> +	if (cxt->io_size || cxt->alignment_offset ||
        ^^^^^^^^^^^
> +	    (cxt->min_io_size & (cxt->min_io_size - 1)))
> +		return 1;
> +	return 0;
> +}

 is incorrect.


 Applied, and fixed.

 Please, use DBG() macro -- for example all topology and geometry
 should be printed in the debug output.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
