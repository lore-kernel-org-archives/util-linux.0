Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751743AbdHGISF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Aug 2017 04:18:05 -0400
Date: Mon, 7 Aug 2017 10:18:01 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: util-linux@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2] libblkid: add support for UBI superblock
Message-ID: <20170807081801.rpupulq6hbcd7zra@ws.net.home>
References: <20170801140309.17646-1-zajec5@gmail.com>
 <20170802121418.10628-1-zajec5@gmail.com>
 <20170803122608.bpqcsfdfek3fvf26@ws.net.home>
 <CACna6rwPwb9WjzJor3rYf1WSJs2_NNBKR5S3Ya8YPVEk3EK7tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACna6rwPwb9WjzJor3rYf1WSJs2_NNBKR5S3Ya8YPVEk3EK7tg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 07, 2017 at 07:40:17AM +0200, Rafał Miłecki wrote:
> On 3 August 2017 at 14:26, Karel Zak <kzak@redhat.com> wrote:
> > On Wed, Aug 02, 2017 at 02:14:18PM +0200, Rafał Miłecki wrote:
> >> From: Rafał Miłecki <rafal@milecki.pl>
> >>
> >> UBI is a volume management system that can be used on a raw flash
> >> partition for providing multiple logical volumes. Detecting UBI
> >> superblock may be useful for tools wanting to simplify or automate
> >> attaching UBI.
> >>
> >> Please note it's not directly related to the ubifs support which is just
> >> a filesystem working on top of UBI volume.
> >>
> >> In other words: UBI can be used on MTD partition (e.g. /dev/mtdblock0)
> >> while ubifs can be used on UBI volume (e.g. /dev/ubi0_0).
> >>
> >> This patch adds simple code reading UBI version and unique number and
> >> setting it in the blkid_probe.
> >>
> >> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> >> ---
> >> V2: Update commit message (more UBI vs. ubifs details)
> >>     Pass &hdr->image_seq to the blkid_probe_sprintf_uuid
> >>     Add test
> >
> > Applied, thanks.
> >
> >> +ID_FS_TYPE=ubi
> >> +ID_FS_USAGE=filesystem
> >
> > This is probably not ideal. We use "RAID" flag for logic volume
> > managers. The advantage is that probing is faster as it does not try
> > to check for another signature when "RAID" is detected.
> >
> > The question is how small could be the UBI device? We don't probe for
> > "RAID" on very small devices (<=1MiB).
> 
> UBI is responsible for bad blocks handling, so it needs enough erase
> blocks (PEBs) reserved in order to work. If one's MTD partition is as
> small as 1 MiB, it won't have enough of erase blocks (PEBs) [0].
> 
> There is some formula for amount of reserved blocks, like:
> n_reserved = n_max_bad_blocks + n_internal_volumes_blocks  + 1
> but basically 1 MiB is said to be too small.
> 
> Does it mean we should & we're save to switch from OTHER to the RAID?

I have pushed this change to the master branch. Now UBI uses
BLKID_USAGE_RAID flag (and the test image has been enlarged (> 1MiB)).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
