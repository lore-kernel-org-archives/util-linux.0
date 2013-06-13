Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758338Ab3FMNaj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 13 Jun 2013 09:30:39 -0400
Date: Thu, 13 Jun 2013 15:30:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Gabriel de Perthuis <g2p.code@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Kay Sievers <kay.sievers@vrfy.org>
Subject: PTUUID and PARTUUID (was: [PATCH v3] libblkid: print PTUUID, the
 partition table uuid)
Message-ID: <20130613133035.GA22795@x2.net.home>
References: <51B217E4.1000800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51B217E4.1000800@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 07, 2013 at 07:27:00PM +0200, Gabriel de Perthuis wrote:
> ---
> v3: Call it ID_PART_TABLE_UUID in udev rules
> 
>  libblkid/src/partitions/gpt.c        |  8 ++++----
>  libblkid/src/partitions/partitions.c | 14 +++++++++++---
>  misc-utils/blkid.c                   |  3 +++
>  3 files changed, 18 insertions(+), 7 deletions(-)

I have applied a little bit different version. Anyway, you have to
modify udevd to make it usable with in built-in blkid. It also
exports MBR ID (so the change is not GPT specific) as partition
table pseudo UUID. Examples:

 # blkid -p -o udev /dev/sda
 ID_PART_TABLE_UUID=3549290f-417c-4941-8503-f7835109b821
 ID_PART_TABLE_TYPE=gpt

 # blkid -p -o udev /dev/sdb
 ID_PART_TABLE_UUID=54e743a7
 ID_PART_TABLE_TYPE=dos


Note that I have also add support for Dos partitions pseudo-uuids. The
implementation is compatible with Linux kernel root=PARTUUID= command
line option.

The PARTUUID for Dos partitions is based on MBR Id and partition number,
for example:

  # blkid /dev/sdb1
  /dev/sdb1: TYPE="ext2" PARTUUID="54e743a7-01" 

is the first partition on disk with PTUUID=54e743a7. So you can use

  # mount PARTUUID="54e743a7-01" /mnt/test

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
