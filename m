Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbdJEK7E (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 5 Oct 2017 06:59:04 -0400
Date: Thu, 5 Oct 2017 12:59:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: fdisk request for functionality (or info)
Message-ID: <20171005105900.s5uctyqsxzlfwhsk@ws.net.home>
References: <59D3C162.4050005@gmail.com>
 <20171004082728.if274peupxjljbxd@ws.net.home>
 <59D4F322.7040805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59D4F322.7040805@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 04, 2017 at 09:41:38AM -0500, Bruce Dubbs wrote:
> Karel Zak wrote:
> > On Tue, Oct 03, 2017 at 11:57:06AM -0500, Bruce Dubbs wrote:
> > > I have been having a problem with fdisk on old computers.
> > > 
> > > What I am doing is installing Debian, but dropping to the command line and
> > > creating a GPT manually because Debian seems to want to always create a
> > > msdos partition table.
> > > 
> > > After creating the GPT and partitioning, the install proceeds normally, but
> > > upon reboot the old bios tells me "No bootable disk".
> > > 
> > > I can fix this by going into rescue mode and setting the pmbr_boot flag
> > > using parted.
> > > 
> > > My question is whether this can be done in fdisk.  If not, can it be added?
> > > 
> > > I did try going into expert mode and selecting "toggle the legacy BIOS
> > > bootable flag", but does not seem to work.  I did not see any change to the
> > > boot sector when using 'd: print the raw data of the first sector from the
> > > device'.
> > 
> > The tricky thing is that fdisks by default see GPT partition, so you
> > have to force the tools to ignore GPT and use PMBR. There is more
> > ways:
> 
> > 2) start fdisk as usually
> >      - go to expert mode ('r')
> 
> There is not an 'r' mode, only 'x' when the current table is gpt.
> 
> >      - see help ('m')
> >      - switch to nested label ('M')
> >      - go to main menu ('r')
> >      - toggle boot flag ('a')
> >      - write ('w')
> 
> I wasn't sure if the 'pmbr_boot' flag was just the standard mbr boot flag

>From parted code it seems that the default is

    gpt_disk_data->pmbr_boot = 0;

> for partition 1 or not.  Would it be reasonable to set that flag by default
> when 'g create a new empty GPT partition table' is selected?

Not sure, according to UEFI standard the boot flag should be ignored
by EFI boot loaders and for non-EFI systems the behavior is undefined.

The first partition on protective MBR covers all disk and the start
offset of the partition is the place where is GPT header. So, the
partition is useless as source for boot. 

The question is what your old BIOS expects and why does it parses MBR
at all :) It should be enough for BIOS to read boot-bits (begin of the
disk) where is boot loader rather than try to be smart and parse any
PT...)

If you want to boot from the MBR than it's probably some kind of crazy
hybrid MBR and it's completely out of fdisk/parted interest. 

fdisk and sfdisk allows to manually work with (hybrid)MBR, but it's
under user's control and fdisk does not do anything by default in this
case.

So, from my point of view all we need is to make changes to fdisk main
menu to make PMBR/HybridMBR easy to access for creative users with
legacy BIOS.


BTW, what returns:

    # fdisk  /dev/sda --type dos --list

for standard PMBR on EFI system it's:

        Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
        Units: sectors of 1 * 512 = 512 bytes
        Sector size (logical/physical): 512 bytes / 512 bytes
        I/O size (minimum/optimal): 512 bytes / 512 bytes
        Disklabel type: dos
        Disk identifier: 0x00000000

        Device     Boot Start       End   Sectors   Size Id Type
        /dev/sda1           1 468862127 468862127 223.6G ee GPT


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
