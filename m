Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: BUG: wipefs dry run
Date: Wed, 10 May 2017 13:03:10 +0200
Cc: util-linux@vger.kernel.org
References: <201705101154.50099.sweet_f_a@gmx.de> <20170510103202.ssoqv7pzk5h2a24q@ws.net.home>
In-Reply-To: <20170510103202.ssoqv7pzk5h2a24q@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201705101303.10856.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 10 May 2017, Karel Zak wrote:
> On Wed, May 10, 2017 at 11:54:50AM +0200, Ruediger Meier wrote:
> > I wonder why wipefs does not show all MBR and GPT signatures which
> > would be deleted by using "-fa".
> >
> > $ truncate -s 100M /tmp/CCC
> > $ ./sfdisk /tmp/CCC <<EOF
> >
> > > label: gpt
> > > label-id: 384A8F14-17FF-4782-A190-A5B858E3FCF0
> > > device: /tmp/CCC
> > > unit: sectors
> > > first-lba: 34
> > > last-lba: 204766
> > > EOF
> >
> > $ ./wipefs  -fa --no-act   /tmp/CCC
> > /tmp/CCC: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49
> > 20 50 41 52 54
> >
> > $ ./wipefs  -fa    /tmp/CCC
> > /tmp/CCC: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49
> > 20 50 41 52 54
> > /tmp/CCC: 8 bytes were erased at offset 0x063ffe00 (gpt): 45 46 49
> > 20 50 41 52 54
> > /tmp/CCC: 2 bytes were erased at offset 0x000001fe (PMBR): 55 aa
>
> This is not a bug, man wipefs:
>
>         Note that some filesystems and some partition tables store
> more magic strings on the device.  The wipefs command lists only the 
> first offset  where  a  magic  string  has  been detected.   The 
> device  is not scanned for additional magic strings for the same
> filesystem.  It is possible that after a wipefs -o offset the same
> filesystem or partition table will still be visible because of
> another magic string on another offset.


I see.

>
> The "-a" writes zeros, resets the scanner and repeat scan again and
> again until nothing is found. I will add note about it to the man
> page...

Thanks. For me it's a bit hard to guess what wipefs would
actually do.

I have another issue, using wipefs on the same image like above:

$ ./wipefs -fa -t gpt  /tmp/CCC
/tmp/CCC: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54
/tmp/CCC: 8 bytes were erased at offset 0x063ffe00 (gpt): 45 46 49 20 50 41 52 54
/tmp/CCC: 8 bytes were erased at offset 0x063ffe00 (gpt): 45 46 49 20 50 41 52 54

There are two duplicated lines in the output and the not-mentioned (P)MBR
is also removed.


> It would be probably possible to extend libblkid to work in some
> "ignore previous result" mode to to gather all permutation for the
> FS/RAID/etc, but it won't be trivial task...

This would be nice.

cu,
RUdi
