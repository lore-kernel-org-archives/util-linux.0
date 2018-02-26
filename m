Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751165AbeBZWUZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Feb 2018 17:20:25 -0500
Date: Mon, 26 Feb 2018 23:20:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <ruediger.meier@ga-group.nl>,
        John Groves <jgroves@micron.com>
Cc: util-linux@vger.kernel.org
Subject: Re: ready for v2.32 ?
Message-ID: <20180226222021.tvjznf3w7qzsyafg@ws.net.home>
References: <201802262216.01925.ruediger.meier@ga-group.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201802262216.01925.ruediger.meier@ga-group.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 26, 2018 at 10:16:01PM +0100, Ruediger Meier wrote:
> There is one test failure on big endian (ppc/ppc64)
> 
> [...]
>   blkid: superblocks probing: [37] mpool               ... FAILED 
> (blkid/low-probe-mpool)
> [...]
> ---------------------------------------------------------------------
>   1 tests of 199 FAILED
> ---------------------------------------------------------------------

I guess we have to use le32_to_cpu() osd->osb_cksum1. 

John, is mpool little endian, big endian, or both?

    Karel

> 
> --- /home/abuild/rpmbuild/BUILD/util-linux-2.32-rc1-31-79bd1/tests/expected/blkid/low-probe-mpool       
> 2018-02-26 20:14:24.265703542 +0000
> +++ /home/abuild/rpmbuild/BUILD/util-linux-2.32-rc1-31-79bd1/tests/output/blkid/low-probe-mpool 
> 2018-02-26 
> 20:38:14.300022547 +0000
> @@ -1,6 +0,0 @@
> -ID_FS_LABEL=mp1
> -ID_FS_LABEL_ENC=mp1
> -ID_FS_TYPE=mpool
> -ID_FS_USAGE=filesystem
> -ID_FS_UUID=2dfca1ea-651e-4694-976f-14654b0a8a83
> -ID_FS_UUID_ENC=2dfca1ea-651e-4694-976f-14654b0a8a83
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
