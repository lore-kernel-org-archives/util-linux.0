Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752214AbdHBKlw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 2 Aug 2017 06:41:52 -0400
Date: Wed, 2 Aug 2017 12:41:47 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: util-linux@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] libblkid: add support for UBI superblock
Message-ID: <20170802104147.xkowycdmzgsfk4mp@ws.net.home>
References: <20170801140309.17646-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170801140309.17646-1-zajec5@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 01, 2017 at 04:03:09PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Detecting UBI superblock may be useful for tools wanting to simplify or
> automate attaching UBI. Please note it's not directly related to the
> ubifs support which is just a filesystem working on top of UBI volume.

How does it co-exists with ufifs? Does it share the same /dev node or
attached UBI uses another device? (I have no UBI to test it.)

Note that by default libblkid does not support scenario where on the
same device is more superblock - in this case extra care is necessary

It seems (according to ubifs prober code) that ubifs is on another
device node.

It would be nice to have lsblk output with mounted ubifs.

>  libblkid/src/Makemodule.am             |  1 +
>  libblkid/src/superblocks/superblocks.c |  1 +
>  libblkid/src/superblocks/superblocks.h |  1 +
>  libblkid/src/superblocks/ubi.c         | 50 ++++++++++++++++++++++++++++++++++
>  4 files changed, 53 insertions(+)
>  create mode 100644 libblkid/src/superblocks/ubi.c

 Rafał, see also tests/ts/blkid/images-fs/ and tests/expected/blkid/.
 
 It would by nice to have small image with UBI superblock and expected
 output from "blkid -p -o udev <device>". It seems dd(1) the begin of
 the device  would be good enough.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
