Return-Path: util-linux-owner@vger.kernel.org
Received: from skade.schwarzvogel.de ([144.76.18.87]:34087 "EHLO
	mail.schwarzvogel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbHGIuW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Aug 2015 04:50:22 -0400
Date: Fri, 7 Aug 2015 10:18:13 +0200
From: Tobias Klausmann <klausman@gentoo.org>
To: Matt Turner <mattst88@gmail.com>
Cc: util-linux@vger.kernel.org, alpha@gentoo.org
Subject: Re: fdisk BSD disklabel support?
Message-ID: <20150807081812.GA91885@skade.schwarzvogel.de>
References: <CAEdQ38F9RxBHgA+zKdwLKxdQncMUyqzowGcGidf-Vc1xbsXQOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEdQ38F9RxBHgA+zKdwLKxdQncMUyqzowGcGidf-Vc1xbsXQOg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi! 

On Thu, 06 Aug 2015, Matt Turner wrote:
> I'm not able to figure out how to make a BSD disklabel in fdisk since v2.23.
> 
> Gentoo's installation guide describes the process of partitioning a
> disk for SRM/Alpha [1]. How should one do this now?
> 
> With my distro's util-linux-2.25 I don't see any option that resembles
> BSD disklabels -- I see only
> 
>   Create a new label
>    g   create a new empty GPT partition table
>    G   create a new empty SGI (IRIX) partition table
>    o   create a new empty DOS partition table
>    s   create a new empty Sun partition table
> 
> What am I missing?
> 
> [1] https://wiki.gentoo.org/wiki/Handbook:Alpha/Installation/Disks#Deleting_all_slices
 
It seems like disklabel _editing_ still works:

monolith ~ # fdisk /dev/sda

Welcome to fdisk (util-linux 2.26.2).
[...]
Disk /dev/sda: 17 GiB, 18209320960 bytes, 35565080 sectors
Geometry: 64 heads, 32 sectors/track, 17365 cylinders
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: bsd
partitions: 3

Slice   Start      End  Sectors  Size Type     Fsize Bsize Cpg
a        4096  1959935  1955840  955M swap         0     0   0
b     1959936 35563519 33603584   16G ext2         0     0   0
c           0 35563519 35563520   17G unused       0     0   0

Maybe generating a BSD disklabel is just not wired up?

Regards,
Tobias


-- 
Should array indices start at 0 or 1? My compromise of 0.5 was rejected
without, I thought, proper consideration.
	-- Stan Kelly-Bootle
