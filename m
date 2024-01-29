Received: from info.physics.ubc.ca (info.physics.ubc.ca [142.103.234.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D869159569
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.103.234.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566266; cv=none; b=p1DObBTyR+UqAUCYnaG0kB1th91hNht35a+fGa5lHEdzIaqjM4N/hq9lSoTRwQWVHG+Tl5wuImm0KSS2ZiJk7mJaeA3Nf6VOpH95FPOMSJnjVn2UfWAAGrfE8H09tO89D2p/uBg/8a5uOb6NZ9exZcB2aPWV5nGOhxPWp3Podh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566266; c=relaxed/simple;
	bh=oq9IZymHhrNUeclyz0wRD98BSgKbGfK61V6DnE50PWQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D6HF9wWUFnG3EagGjq4vccRd6711ppdETA1fINxhkkRIo30sf1Ktxcejj1E8ULsb2iFlstuDR871dvMFDcwOe7Yy1E2NWDbDYvwETWDsIOiRd5gfdSLqn7ZHxbX1BpAMIkkfs6z6VSuOIjIJTVDQUXWNNfaatOs5r7fgyv5nNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physics.ubc.ca; spf=pass smtp.mailfrom=physics.ubc.ca; arc=none smtp.client-ip=142.103.234.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physics.ubc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=physics.ubc.ca
Received: by info.physics.ubc.ca (Postfix, from userid 1000)
	id A79E8121126; Mon, 29 Jan 2024 14:11:03 -0800 (PST)
Date: Mon, 29 Jan 2024 14:11:03 -0800 (PST)
From: Bill Unruh <unruh@physics.ubc.ca>
To: Thorsten Glaser <tg@debian.org>
cc: util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
In-Reply-To: <Pine.BSM.4.64L.2401292118320.19873@herc.mirbsd.org>
Message-ID: <70cac0f2-ec94-33f7-4a5d-c17f8eb82588@physics.ubc.ca>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org> <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de> <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org> <5b8f9459-cc95-4c08-b68c-39abb2ff9f68@t-8ch.de> <20240129205623.sgvkhcyyepbsjzh3@ws.net.home>
 <Pine.BSM.4.64L.2401292118320.19873@herc.mirbsd.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1737365482-1872782930-1706566263=:1875957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1737365482-1872782930-1706566263=:1875957
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mageia, run isodumper. It asks if you want to create a persistant
partition. Tell it to put a persistent  partition of of 2GB or so to fill u=
p
the usb. Now you will have a 2GB partition on the usb that you can write to
etc. It will I believe be ext4 by default although you can choose others. N=
o
need for fdisk. As has been stated this is not something that fdisk is
designed for. If you want to fix it so it will do what you want, you are of
course free to do so. Otherwise it is far simpler to use a tool that does w=
hat
you want already.

I suspect that isodumper would also work on other linux versions, but do no=
t
know for sure. It is a Python based program, so you would need the appropri=
ate
version of Python installed (or just install Mageia :-). Maybe Debian could
import it.

Of course it would then be irrelevant for=20
util-linux



William G. Unruh __| Canadian Institute for|____ Tel: +1(604)822-3273
Physics&Astronomy _|___ Advanced Research _|____ Fax: +1(604)822-5324
UBC, Vancouver,BC _|_ Program in Cosmology |____ unruh@physics.ubc.ca
Canada V6T 1Z1 ____|____ and Gravity ______|_    theory.physics.ubc.ca/

On Mon, 29 Jan 2024, Thorsten Glaser wrote:

> [CAUTION: Non-UBC Email]
>
> Bill Unruh dixit:
>
>> Perhaps if you told us what you really wanted to do, instead of asking
>> why your first method did not work and how to fix it. Eg, you wnat to
>> add another partition to the usb disk since the boot system only used
>> 5GB of a 128GB usb, and you don't want to waste 123GB of space.
>
> Something like that.
>
> I have: an ISO 9660 filesystem that already contains a bootable MBR
> with a partition table and even inlines an EFI thingy:
>
> tglase@x61w:~ $ /sbin/fdisk -l /tmp/grml96-full_2022.11.iso
> Disk /tmp/grml96-full_2022.11.iso: 1.62 GiB, 1734606848 bytes, 3387904 se=
ctors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x2e49ce75
>
> Device                        Boot Start     End Sectors  Size Id Type
> /tmp/grml96-full_2022.11.iso1 *        0 3387903 3387904  1.6G  0 Empty
> /tmp/grml96-full_2022.11.iso2        628    8819    8192    4M ef EFI (FA=
T-12/16/32)
>
> I can dd(8) that to a USB stick and it=E2=80=99ll be bootable. My USB sti=
ck
> measures 4 GiB however, so I wanted to add a third partition that
> uses the remaining space to store extra data, which I can then use
> in the live system, alongside on the stick:
>
> tglase@x61w:~ $ sudo fdisk -l /dev/sdb
> Disk /dev/sdb: 3.73 GiB, 4009754624 bytes, 7831552 sectors
> Disk model: Flash Disk
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x2e49ce75
>
> Device     Boot   Start     End Sectors  Size Id Type
> /dev/sdb1  *          0 3387903 3387904  1.6G  0 Empty
> /dev/sdb2           628    8819    8192    4M ef EFI (FAT-12/16/32)
> /dev/sdb3       3389440 7831551 4442112  2.1G 83 Linux
>
> (Oh, apparently it=E2=80=99s less than 4 GiB. Anyway.)
>
> So I did =E2=80=9Csudo fdisk /dev/sdb=E2=80=9D and added a partition, as =
usual.
>
>
> Karel Zak dixit:
>> Thomas Wei=C3=9Fschuh dixit:
>>> In the message you may or may not have seen there is a reference to the
>>> `--wipe` option that describes the reasoning and possibilities.
>
> Oh, good point. I guess I=E2=80=99m surprised it does that by default.
>
>> There is also --protect-boot and --wipe-partitions, that may help in
>> some cases.
>
> Incidentally, I *did* know-ish about --wipe-partitions precisely
> because the default =E2=80=9Cauto=E2=80=9D (according to the manpage=E2=
=80=A6
>
>>> Reproduced here for your convenience:
>>> https://manpages.debian.org/bookworm/fdisk/fdisk.8.en.html
>
> =E2=80=A6 I=E2=80=99m on bullseye, so slightly older but still present) *=
does* ask
> for =E2=80=9Cauto=E2=80=9D in interactive mode.
>
> But --wipe doesn=E2=80=99t=E2=80=BD
>
>       -w, --wipe when
> [=E2=80=A6]
>              given,  the  default is auto, in which case signatures are w=
iped
>              only when in interactive mode.  In all cases detected signat=
ures
> [=E2=80=A6]
>       -W, --wipe-partitions when
> [=E2=80=A6]
>              tion is not given, the default is auto, in which case signat=
ures
>              are wiped only when in interactive mode and  after  confirma=
tion
>              by user.  In all cases detected signatures are reported by w=
arn=E2=80=90
> [=E2=80=A6]
>
> So this inconsistency combined with auto being the default but
> auto not meaning the same thing tripped me up.
>
>>> As for why: "in order to avoid possible collisions".
>
> Huh. But there already was a partition table there, and all I did
> was to add another partition in free space at the end.
>
>>> For convenience it even may have shown a prominent warning in bright re=
d
>>> letters with helpful pointers. Or maybe it didn't.
>
> Let=E2=80=99s see=E2=80=A6
>
> tglase@x61w:~ $ sudo fdisk /dev/sdb
>
> Welcome to fdisk (util-linux 2.36.1).
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
>
> The device contains 'iso9660' signature and it will be removed by a write=
 command. See fdisk(8) man page and --wipe option for more details.
>
> Command (m for help):
>
> No line wrapping, but no bright red letters either =E2=98=BB
>
> The terminal wrapped this between --wi and pe, so I guess
> this is the reason for me to oversee that. (And even then,
> the message does not indicate that I could also disable
> wiping there as the option is just named --wipe and not
> either paired with --no-wipe or named --wipe-mode which
> would have implied multiple possibilities. Here, a user
> could think =E2=80=9Cmeh, I don=E2=80=99t want to wipe, so I don=E2=80=99=
t pass
> --wipe and then it won=E2=80=99t do that=E2=80=9D.
>
>>>> So, how do I get fdisk to not corrupt the ISO 9660 part?
>>>
>>> Try `--wipe never` as explained above.
>
> OK, thanks, will try that next time. Or actually=E2=80=A6
>
> tglase@x61w:~ $ sudo fdisk -w never /dev/sdb
>
> Welcome to fdisk (util-linux 2.36.1).
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
>
> The device contains 'iso9660' signature and it may remain on the device. =
It is recommended to wipe the device with wipefs(8) or fdisk --wipe, in ord=
er to avoid possible collisions.
>
> Command (m for help):
>
> =E2=80=A6 from the message this sounds like it=E2=80=99ll do the trick.
> (I still think that =E2=80=9Cpossible collisions=E2=80=9D could have been
> worded better as well, but I=E2=80=99m not English, so=E2=80=A6)
>
> bye,
> //mirabilos
> --=20
> FWIW, I'm quite impressed with mksh interactively. I thought it was much
> *much* more bare bones. But it turns out it beats the living hell out of
> ksh93 in that respect. I'd even consider it for my daily use if I hadn't
> wasted half my life on my zsh setup. :-) -- Frank Terbeck in #!/bin/mksh
>
>
--1737365482-1872782930-1706566263=:1875957--
