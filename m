Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33624 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbbH2FOb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 29 Aug 2015 01:14:31 -0400
Received: by ykdz80 with SMTP id z80so34871680ykd.0
        for <util-linux@vger.kernel.org>; Fri, 28 Aug 2015 22:14:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150807195408.GA18302@ws.net.home>
References: <CAEdQ38F9RxBHgA+zKdwLKxdQncMUyqzowGcGidf-Vc1xbsXQOg@mail.gmail.com>
 <20150807195408.GA18302@ws.net.home>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 28 Aug 2015 22:14:11 -0700
Message-ID: <CAEdQ38HMOG+dWU5CwLrQ+nGKe8n=p4WJ_RMF5NGcSX3C-jt6jg@mail.gmail.com>
Subject: Re: fdisk BSD disklabel support?
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, alpha@gentoo.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 7, 2015 at 12:54 PM, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Aug 06, 2015 at 07:34:40PM -0700, Matt Turner wrote:
>> I'm not able to figure out how to make a BSD disklabel in fdisk since v2.23.
>>
>> Gentoo's installation guide describes the process of partitioning a
>> disk for SRM/Alpha [1]. How should one do this now?
>>
>> With my distro's util-linux-2.25 I don't see any option that resembles
>> BSD disklabels -- I see only
>>
>>   Create a new label
>>    g   create a new empty GPT partition table
>>    G   create a new empty SGI (IRIX) partition table
>>    o   create a new empty DOS partition table
>>    s   create a new empty Sun partition table
>>
>> What am I missing?
>
>  You have to create a DOS (MBR) label first, and then there is
>
>    DOS (MBR)
>       a   toggle a bootable flag
>       b   edit nested BSD disklabel
>       c   toggle the dos compatibility flag
>
>
>  For example:
>
>  # fdisk /dev/sdc
>  ...
>  Command (m for help): n
>  Partition type
>     p   primary (0 primary, 0 extended, 4 free)
>     e   extended (container for logical partitions)
>  Select (default p): p
>  Partition number (1-4, default 1):
>  First sector (2048-1023999, default 2048):
>  Last sector, +sectors or +size{K,M,G,T,P} (2048-1023999, default 1023999):
>
>  Created a new partition 1 of type 'Linux' and of size 499 MiB.
>  ...
>  Command (m for help): t                           <----!!!
>  Partition type (type L to list all types): a5
>  Changed type of partition 'Linux' to 'FreeBSD'.
>  ...
>  Command (m for help): b                           <----!!!
>  The device /dev/sdc1 does not contain BSD disklabel.
>
>  Do you want to create a BSD disklabel? [Y]es/[N]o: y
>  ...
>  Command (m for help): p
>  ...
>  Slice Start     End Sectors   Size Type     Fsize Bsize Cpg
>  c      2048 1023999 1021952   499M unused       0     0   0
>  d         0 1023059 1023060 499.6M unused       0     0   0
>
>
>   Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

Thanks for the reply.

We have a user reporting that this is not sufficient to make a
bootable disk layout for DEC Alpha/SRM. Please see
https://forums.gentoo.org/viewtopic-t-1025044.html

I take it that this is unexpected?

Thanks,
Matt
