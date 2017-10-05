Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f43.google.com ([209.85.218.43]:52665 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdJEQEP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 Oct 2017 12:04:15 -0400
Received: by mail-oi0-f43.google.com with SMTP id p126so25376657oih.9
        for <util-linux@vger.kernel.org>; Thu, 05 Oct 2017 09:04:15 -0700 (PDT)
Subject: Re: fdisk request for functionality (or info)
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
References: <59D3C162.4050005@gmail.com>
 <20171004082728.if274peupxjljbxd@ws.net.home> <59D4F322.7040805@gmail.com>
 <20171005105900.s5uctyqsxzlfwhsk@ws.net.home>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <59D657FD.6070009@gmail.com>
Date: Thu, 5 Oct 2017 11:04:13 -0500
MIME-Version: 1.0
In-Reply-To: <20171005105900.s5uctyqsxzlfwhsk@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Wed, Oct 04, 2017 at 09:41:38AM -0500, Bruce Dubbs wrote:

>> Would it be reasonable to set that flag by default
>> when 'g create a new empty GPT partition table' is selected?
>
> Not sure, according to UEFI standard the boot flag should be ignored
> by EFI boot loaders and for non-EFI systems the behavior is undefined.
>
> The first partition on protective MBR covers all disk and the start
> offset of the partition is the place where is GPT header. So, the
> partition is useless as source for boot.

Agree.  The problem is the BIOS on fairly old Core2Duo systems.  These 
systems are in a classroom with 16 identical computers.  I've complained 
for a couple of years now that the computers are slow and way out of date 
for what is supposed to be a class teaching technology.

> The question is what your old BIOS expects and why does it parses MBR
> at all :) It should be enough for BIOS to read boot-bits (begin of the
> disk) where is boot loader rather than try to be smart and parse any
> PT...)

What the BIOS should do and what is does are different.  In a different 
classroom with better systems there is no problem.

> If you want to boot from the MBR than it's probably some kind of crazy
> hybrid MBR and it's completely out of fdisk/parted interest.

No, I do not want to boot from the MBR.  I am trying to instruct the 
students how to install and use a GPT.  It seems that the Debian expert 
installer has no option to create a GPT, although it will use it if found. 
  What I have the students do during install is to drop to the command 
line and run fdisk manually, creating a new, empty GPT and new partitions 
for the installer.  It is a good learning exercise.

The problem then, after install, is that the BIOS returns "No bootable 
disk found".  Using a rescue disk and setting the pmbr boot flag allows 
the system to boot properly.

> fdisk and sfdisk allows to manually work with (hybrid)MBR, but it's
> under user's control and fdisk does not do anything by default in this
> case.
>
> So, from my point of view all we need is to make changes to fdisk main
> menu to make PMBR/HybridMBR easy to access for creative users with
> legacy BIOS.

Even an entry in the expert menu would be OK for me. This is probably
a rare enough situation that it does not need to be in the main menu.

> BTW, what returns:
>
>      # fdisk  /dev/sda --type dos --list
>
> for standard PMBR on EFI system it's:
>
>          Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
>          Units: sectors of 1 * 512 = 512 bytes
>          Sector size (logical/physical): 512 bytes / 512 bytes
>          I/O size (minimum/optimal): 512 bytes / 512 bytes
>          Disklabel type: dos
>          Disk identifier: 0x00000000
>
>          Device     Boot Start       End   Sectors   Size Id Type
>          /dev/sda1           1 468862127 468862127 223.6G ee GPT

Yes, that's what I get too.  Setting the pmbr boot bit adds an asterisk 
under boot.

   -- Bruce


