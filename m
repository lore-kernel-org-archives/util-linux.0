Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbdEJKxy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 May 2017 06:53:54 -0400
Date: Wed, 10 May 2017 12:53:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: BUG: wipefs dry run
Message-ID: <20170510105350.ljtch4zpimaxo4u5@ws.net.home>
References: <201705101154.50099.sweet_f_a@gmx.de>
 <20170510103202.ssoqv7pzk5h2a24q@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170510103202.ssoqv7pzk5h2a24q@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 10, 2017 at 12:32:02PM +0200, Karel Zak wrote:
> On Wed, May 10, 2017 at 11:54:50AM +0200, Ruediger Meier wrote:
> > I wonder why wipefs does not show all MBR and GPT signatures which would
> > be deleted by using "-fa".
> > 
> > $ truncate -s 100M /tmp/CCC
> > $ ./sfdisk /tmp/CCC <<EOF
> > > label: gpt
> > > label-id: 384A8F14-17FF-4782-A190-A5B858E3FCF0
> > > device: /tmp/CCC
> > > unit: sectors
> > > first-lba: 34
> > > last-lba: 204766
> > > EOF
> > 
> > $ ./wipefs  -fa --no-act   /tmp/CCC
> > /tmp/CCC: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 
> > 41 52 54
> > 
> > $ ./wipefs  -fa    /tmp/CCC
> > /tmp/CCC: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 
> > 41 52 54
> > /tmp/CCC: 8 bytes were erased at offset 0x063ffe00 (gpt): 45 46 49 20 50 
> > 41 52 54
> > /tmp/CCC: 2 bytes were erased at offset 0x000001fe (PMBR): 55 aa
> 
> This is not a bug, man wipefs:
> 
>         Note that some filesystems and some partition tables store more magic
>         strings on the device.  The wipefs command lists only the  first
>         offset  where  a  magic  string  has  been detected.   The  device  is
>         not scanned for additional magic strings for the same filesystem.  It
>         is possible that after a wipefs -o offset the same filesystem or
>         partition table will still be visible because of another magic string
>         on another offset.
> 
> 
> The "-a" writes zeros, resets the scanner and repeat scan again and
> again until nothing is found. I will add note about it to the man
> page...
> 
> It would be probably possible to extend libblkid to work in some
> "ignore previous result" mode to to gather all permutation for the
> FS/RAID/etc, but it won't be trivial task...

I'll think about it for v2.31... there are two ways:

1) rewrite probing functions to gather all possible magic strings
   (not trivial for fat, zfs, etc...)

2) call probing functions more than once (like wipefs -a) and use
   modified buffers where will be removed previously detected magic
   strings. This is the easy way (because library already supports
   "step back" (scan again last detected FS) and buffers management).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
