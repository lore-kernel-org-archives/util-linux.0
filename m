Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752226AbcHVIkz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Aug 2016 04:40:55 -0400
Date: Mon, 22 Aug 2016 10:40:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Xen <list@xenhideout.nl>
Cc: Util linux <util-linux@vger.kernel.org>
Subject: Re: PV on disk without partitions not recognised as LVM2_member
Message-ID: <20160822084053.tthba5dmp6scyxbq@ws.net.home>
References: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
 <20160819111429.4rsuedff24inn4gu@ws.net.home>
 <3e1c8c5e88416d24f87bd411ca60488d@dds.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3e1c8c5e88416d24f87bd411ca60488d@dds.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 20, 2016 at 04:13:52PM +0200, Xen wrote:
> Karel Zak schreef op 19-08-2016 13:14:
> 
> > This is very unusual setup, but according to feedback from LVM guys
> > it's supported, so I will improve blkid to support it too.
> 
> Actually there are more issues. If you have any firmware RAID signature at
> the end of your disk, but you are not using it

You have to use "wipefs" to remove unwanted signatures. We do not
support random mess on disks. It's OS installer, mkfs-like, fdisk
tools and users responsibility to keep on-disk stuff in reliable
state.

It's not about RAIDs only, it's possible write many PT, filesystem and
raid signatures to the same disk.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
