Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751883AbdHCM0M (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 3 Aug 2017 08:26:12 -0400
Date: Thu, 3 Aug 2017 14:26:08 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: util-linux@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2] libblkid: add support for UBI superblock
Message-ID: <20170803122608.bpqcsfdfek3fvf26@ws.net.home>
References: <20170801140309.17646-1-zajec5@gmail.com>
 <20170802121418.10628-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170802121418.10628-1-zajec5@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 02, 2017 at 02:14:18PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> UBI is a volume management system that can be used on a raw flash
> partition for providing multiple logical volumes. Detecting UBI
> superblock may be useful for tools wanting to simplify or automate
> attaching UBI.
> 
> Please note it's not directly related to the ubifs support which is just
> a filesystem working on top of UBI volume.
> 
> In other words: UBI can be used on MTD partition (e.g. /dev/mtdblock0)
> while ubifs can be used on UBI volume (e.g. /dev/ubi0_0).
> 
> This patch adds simple code reading UBI version and unique number and
> setting it in the blkid_probe.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Update commit message (more UBI vs. ubifs details)
>     Pass &hdr->image_seq to the blkid_probe_sprintf_uuid
>     Add test

Applied, thanks.

> +ID_FS_TYPE=ubi
> +ID_FS_USAGE=filesystem

This is probably not ideal. We use "RAID" flag for logic volume
managers. The advantage is that probing is faster as it does not try
to check for another signature when "RAID" is detected. 

The question is how small could be the UBI device? We don't probe for 
"RAID" on very small devices (<=1MiB).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
