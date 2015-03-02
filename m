Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44489 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbbCBKH0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Mar 2015 05:07:26 -0500
Date: Mon, 2 Mar 2015 11:06:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: sfdisk problem with a partition starting early on a GPT disk
Message-ID: <20150302100652.GI8046@ws.net.home>
References: <20150301155610.GW3933@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150301155610.GW3933@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 01, 2015 at 11:56:10AM -0400, Peter Cordes wrote:
> # the disk I partitioned manually:
> $ sudo /usr/local/src/util-linux/sfdisk -d /dev/sde | tee tosh-partitions.sfdisk
> label: gpt
> label-id: 7E471862-5089-4C54-A3BC-722ADD08808A
> device: /dev/sde
> unit: sectors
> 
> /dev/sde1 : start=          40, size=        2008, type=21686148-6449-6E6F-744E-656564454649, uuid=01F40706-97E6-43D1-80D3-0EA85BB5E8FD, name="BIOS boot partition"
> /dev/sde2 : start=        2048, size=    30720000, type=A19D880F-05FC-4D3B-A006-743F0F84911E, uuid=9898E8B2-C930-4E6E-826A-4D7305793E6A
> /dev/sde3 : start=    30722048, size=   122880000, type=A19D880F-05FC-4D3B-A006-743F0F84911E, uuid=C0CF3D7C-A170-4E1E-9169-9AB4A4FF3164
> /dev/sde4 : start=   153602048, size=   820695040, type=A19D880F-05FC-4D3B-A006-743F0F84911E, uuid=F9258FDA-14A3-4B72-B367-F3B1B244C407
> /dev/sde5 : start=   974297088, size=     2457600, type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F, uuid=8EF2E18C-8E3D-41A3-86AF-EE4FDA7B103D
> /dev/sde6 : start=   976754688, size=  4883777536, type=A19D880F-05FC-4D3B-A006-743F0F84911E, uuid=265297FD-E7AA-484F-BEC2-D03C385E75DD
...
>  >>> Created a new GPT disklabel (GUID: 7E471862-5089-4C54-A3BC-722ADD08808A).
>  Sector 40 already used.
>  Failed to add partition: Numerical result out of range
>  Leaving.
...

> Does sfdisk use more space for its GPT than other tools, like gdisk
> or gparted?  After making a new GPT partition table with either of
> those tools, I could make a new partition starting as early as sector
> 34 (according to gdisk).  I make my boot partition start at sector 40
> just so it's 4k aligned.  (It's only written by grub-install, not the
> usual update-grub on kernel updates, so it's not like it matters if
> it's aligned anyway, but still.)

UEFI standard:

  "First Usable LBA must be greater than or equal to 34.."

so your setup correct, you have the first partition at LBA 40.

>  Oh that's weird.  Running gdisk on the sfdisk-partitioned disk
> doesn't let me create a partition before the one at 1MiB (sector
> 2048).  Does sfdisk make the partition table itself consume the full
> first 1MiB of the disk?

No, GPT header contains First and Last LBA offsets, it's area where
you can define partitions. The libfdisk uses 1MiB offset for the
First LBA to make sure that all partitions will be aligned. This
is generic for all our fdisks.   (1MiB is almost standard now.)

For MBR sfdisk is more benevolent and it allows to use smaller offsets
in scripts, maybe we need something like this for GPT too.

I don't want to offer such possibility for standard partitioning (in
cfdisk or fdisk), but for dumps or if you want to restore PT backups
the library should be ready to accept smaller offsets.

> I'm not an expert, so IDK if there's some reason it's reasonable to
> reject a config like this, but other tools have no problem creating
> and using it (except gparted, with align to 1MiB or cyclinder as the
> only options, but it doesn't even let you set the partition type
> correctly for md on GPT.)

Well, <1MiB for the first partition is like a black swan, it's
unusual, but it exists :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
