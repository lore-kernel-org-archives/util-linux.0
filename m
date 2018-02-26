Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout.micron.com ([137.201.242.129]:31358 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBZWoT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 26 Feb 2018 17:44:19 -0500
From: "John Groves (jgroves)" <jgroves@micron.com>
To: Karel Zak <kzak@redhat.com>,
        Ruediger Meier <ruediger.meier@ga-group.nl>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [EXT] Re: ready for v2.32 ?
Date: Mon, 26 Feb 2018 22:44:12 +0000
Message-ID: <1519685049171.25700@micron.com>
References: <201802262216.01925.ruediger.meier@ga-group.nl>,<20180226222021.tvjznf3w7qzsyafg@ws.net.home>
In-Reply-To: <20180226222021.tvjznf3w7qzsyafg@ws.net.home>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

________________________________________
From: Karel Zak <kzak@redhat.com>
Sent: Monday, February 26, 2018 4:20 PM
To: Ruediger Meier; John Groves (jgroves)
Cc: util-linux@vger.kernel.org
Subject: [EXT] Re: ready for v2.32 ?

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

Doh! Mpool stores its metadata as little endian, and rigorously uses le32_to_cpu and the like to move on-media structures to & from memory.

le32_to_cpu(osd->osb_cksum1) would be the correct way to handle it.

Thanks!
John
