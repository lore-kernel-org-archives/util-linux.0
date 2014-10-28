Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:39847 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbaJ1I4s (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Oct 2014 04:56:48 -0400
Received: from merkaba.localnet (blackhole.teamix.net [194.150.191.251])
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 06512A2
	for <util-linux@vger.kernel.org>; Tue, 28 Oct 2014 09:47:32 +0100 (CET)
From: Martin Steigerwald <Martin@lichtvoll.de>
To: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
Date: Tue, 28 Oct 2014 09:47:31 +0100
Message-ID: <2236859.7Bm4QSfH9D@merkaba>
In-Reply-To: <544F0C88.1080807@gmail.com>
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net> <544F0C88.1080807@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello you with the unknown real name,

Am Dienstag, 28. Oktober 2014, 08:54:56 schrieb dE:
> On 10/28/14 00:37, Felix Miata wrote:
> > dE composed on 2014-10-28 00:13 (UTC+0530):
> >> I was learning about GPT when I noticed this behavior of fdisk which I
> >> never though about before.
> >> Regardless of the partition table, fdisk always starts the first
> >> partition at 2048. In reality, the maximum size required by the gap
> >> between MBR and the 1st partition is a single sector, which's used by
> >> GRUB 1.5. GPT doesn't need this space at all.
> >> Then extended partitions too have a gap of 2048 sectors.
> >> Why this behavior?
> > 
> > http://www.seagate.com/tech-insights/advanced-format-4k-sector-hard-drives
> > -master-ti/ may provide some insight WRT performance issues ensuing from
> > other start sector selections.
> 
> But that works even with multiples of 8. So we can start from sector 8
> in MBR and 40 in GPT.

But then you have SoftRAID or Hardware RAID with 64 or 512 KiB chunk size. Or 
you have SSD/PCIe or other flash with erase block sizes and so son. 1 MiB is 
dividable by these usual sizes.

Why is this an issue for you? 

Also see -c=dos switch or interactive "c" command:

merkaba:~> LANG=C fdisk /dev/sda   

Welcome to fdisk (util-linux 2.25.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): c
DOS Compatibility flag is set (DEPRECATED!)

Command (m for help): o
"

Created a new DOS disklabel with disk identifier 0x7c1893d1.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 
First sector (63-586072367, default 63):


"DOS-compatible mode is deprecated." is in red :)

Ciao,
-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
