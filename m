Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752521AbdHBKvn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 2 Aug 2017 06:51:43 -0400
Date: Wed, 2 Aug 2017 12:51:39 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: util-linux@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] libblkid: add support for UBI superblock
Message-ID: <20170802105139.2cmnmbuysn2a2t23@ws.net.home>
References: <20170801140309.17646-1-zajec5@gmail.com>
 <20170802104147.xkowycdmzgsfk4mp@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170802104147.xkowycdmzgsfk4mp@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 02, 2017 at 12:41:47PM +0200, Karel Zak wrote:
> On Tue, Aug 01, 2017 at 04:03:09PM +0200, Rafał Miłecki wrote:
> > From: Rafał Miłecki <rafal@milecki.pl>
> > 
> > Detecting UBI superblock may be useful for tools wanting to simplify or
> > automate attaching UBI. Please note it's not directly related to the
> > ubifs support which is just a filesystem working on top of UBI volume.
> 
> How does it co-exists with ufifs? Does it share the same /dev node or
> attached UBI uses another device? (I have no UBI to test it.)
> 
> Note that by default libblkid does not support scenario where on the
> same device is more superblock - in this case extra care is necessary
> 
> It seems (according to ubifs prober code) that ubifs is on another
> device node.
> 
> It would be nice to have lsblk output with mounted ubifs.

This page http://www.linux-mtd.infradead.org/doc/ubi.html explains a lot...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
