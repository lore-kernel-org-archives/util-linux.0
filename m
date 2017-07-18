Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbdGRIfT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jul 2017 04:35:19 -0400
Date: Tue, 18 Jul 2017 10:35:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Mark Tinguely <mark.tinguely@hpe.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: add HPE extended-XFS to known filesystems
Message-ID: <20170718083514.alsfyb4k2ntxmtzd@ws.net.home>
References: <012d19cf-cf77-fe9a-29c5-98ca42c3d377@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <012d19cf-cf77-fe9a-29c5-98ca42c3d377@hpe.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 30, 2017 at 09:30:39AM -0500, Mark Tinguely wrote:
> From: Mark Tinguely <mark.tinguely@hpe.com>
> The HPE (formerly SGI) enhanced XFS has changed its magic

Is it already supported by Linux kernel? I have problem google
anything about EXFS.

> version number to allow the use of EXFS and community XFS
> filesystems at the same time.

Unfortunately the patch uses the same magic string for EXFS log
(0xFEEDbabe) as XFS log. The result is that libblkid detects EXFS log
on all XFS images.  (try "cd tests; ./run.sh blkid")

> +#define EXLOG_HEADER_MAGIC_NUM 0xFEEDbabe

 ...

> +/* exlog record header will be in some sector in the first 256k */
> +static int probe_exfs_log(blkid_probe pr,
> +		const struct blkid_idmag *mag __attribute__((__unused__)))
> +{
> +	int i;
> +	struct exlog_rec_header *rhead;
> +	unsigned char *buf;
> +
> +	buf = blkid_probe_get_buffer(pr, 0, 256*1024);
> +	if (!buf)
> +		return errno ? -errno : 1;
> +
> +	if (memcmp(buf, "EXFS", 4) == 0)
> +		return 1;			/* this is regular EXFS, ignore */
> +
> +	/* check the first 512 512-byte sectors */
> +	for (i = 0; i < 512; i++) {
> +		rhead = (struct exlog_rec_header *)&buf[i*512];
> +
> +		if (exlog_valid_rec_header(rhead)) {
> +			blkid_probe_set_uuid_as(pr, rhead->h_uuid, "LOGUUID");
> +
> +			if (blkid_probe_set_magic(pr, i * 512,
> +						sizeof(rhead->h_magicno),
> +						(unsigned char *) &rhead->h_magicno))
> +				return 1;
> +
> +			return 0;
> +		}
> +	}
> +
> +	return 1;
> +}

If there is no difference between XFS Log and EXFS Log than we cannot add
probe_exfs_log().

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
