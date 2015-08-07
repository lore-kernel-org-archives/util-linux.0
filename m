Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36743 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946092AbbHGTyK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Aug 2015 15:54:10 -0400
Date: Fri, 7 Aug 2015 21:54:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Matt Turner <mattst88@gmail.com>
Cc: util-linux@vger.kernel.org, alpha@gentoo.org
Subject: Re: fdisk BSD disklabel support?
Message-ID: <20150807195408.GA18302@ws.net.home>
References: <CAEdQ38F9RxBHgA+zKdwLKxdQncMUyqzowGcGidf-Vc1xbsXQOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEdQ38F9RxBHgA+zKdwLKxdQncMUyqzowGcGidf-Vc1xbsXQOg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 06, 2015 at 07:34:40PM -0700, Matt Turner wrote:
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

 You have to create a DOS (MBR) label first, and then there is 

   DOS (MBR)
      a   toggle a bootable flag
      b   edit nested BSD disklabel
      c   toggle the dos compatibility flag


 For example:

 # fdisk /dev/sdc
 ...
 Command (m for help): n
 Partition type
    p   primary (0 primary, 0 extended, 4 free)
    e   extended (container for logical partitions)
 Select (default p): p
 Partition number (1-4, default 1): 
 First sector (2048-1023999, default 2048): 
 Last sector, +sectors or +size{K,M,G,T,P} (2048-1023999, default 1023999): 

 Created a new partition 1 of type 'Linux' and of size 499 MiB.
 ...
 Command (m for help): t                           <----!!!
 Partition type (type L to list all types): a5
 Changed type of partition 'Linux' to 'FreeBSD'.
 ...
 Command (m for help): b                           <----!!!
 The device /dev/sdc1 does not contain BSD disklabel.

 Do you want to create a BSD disklabel? [Y]es/[N]o: y
 ...
 Command (m for help): p
 ...
 Slice Start     End Sectors   Size Type     Fsize Bsize Cpg
 c      2048 1023999 1021952   499M unused       0     0   0
 d         0 1023059 1023060 499.6M unused       0     0   0


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
