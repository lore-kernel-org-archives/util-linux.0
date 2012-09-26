Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64556 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175Ab2IZINF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Sep 2012 04:13:05 -0400
Date: Wed, 26 Sep 2012 10:12:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Kay Sievers <kay@vrfy.org>
Cc: Francesco Turco <fturco@fastmail.fm>, util-linux@vger.kernel.org
Subject: Re: Why fdisk wants the first partition to start at 1 MiB?
Message-ID: <20120926081258.GF22639@x2.net.home>
References: <1348605188.19630.140661132636721.0CD0D5D4@webmail.messagingengine.com>
 <CAPXgP11cuTV5+juJR54=xheDsGD9-ZqnUFuiXv43TRDvdThx1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPXgP11cuTV5+juJR54=xheDsGD9-ZqnUFuiXv43TRDvdThx1g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 25, 2012 at 10:50:44PM +0200, Kay Sievers wrote:
> On Tue, Sep 25, 2012 at 10:33 PM, Francesco Turco <fturco@fastmail.fm> wrote:
> > I'm trying to use fdisk (from util-linux 2.19.1) for creating a
> > partition on a drive. I noticed that the start sector of the first
> > partition must be at least 2048, that is 1 MiB from the beginning of the
> > drive. This can be changed by entering the "expert mode" and using the
> > "move beginning of data in a partition" option. But I'm still wondering
> > why fdisk reserves so much space by default.
> >
> > As far as I know the only sector that should not be used for partitions
> > is the first one, that is, sector 0. It is reserved for the MBR. So the
> > first partition can start at sector 1. I read that the 1 MiB thing is
> > Windows related: http://en.wikipedia.org/wiki/Logical_Disk_Manager. Or
> > it's something that Linux users should also care about? I can't find a
> > convincing explanation anywhere.
> >
> > This 1 MiB thing seems to affect parted, too, as it wants partition
> > boundaries to be multiples of 1 MiB. I don't know if it's related to the
> > problem I have with fdisk, though.
> 
> It's a de-facto standard, which Windows does too. The first megabyte
> is reserved here for a boot loader or any other management data that
> could be needed for a disk or box to boot from.

 The real reason is that 1MiB is ideal offset to keep partitions
 aligned on almost all random hardware. This offset is compatible with
 512-byte, 4096-byte sector devices, many raid devices as well as old
 broken WD disks where physical sector size has been incorrectly
 reported. You can use dd(1) to move your PT + data to another device
 without care about physical device topology (I/O limits), etc.

 It's also important to keep your partition sizes aligned to MiB --
 this is for example default in fdisk if you specify the size in
 +<size>{M,G} convention.

> Boot loader issues are probably not that interesting on EFI boxes and
> other non-BIOS hardware, but on usually big sized disks it's still a
> safe default.

 Yes.

 Probably the most complete docs with many references:
 https://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_issues

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
