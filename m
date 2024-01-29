Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F531586CE
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564270; cv=none; b=PEGHeCziIK1TylChnq3DguLxZDjqSFfMUnnO5j7eez50KLnzjWpql/f3mxGvKsX/Aso8q75na3EBgXD8N/1iL9NJy4Xp14KMeIP1/V13uQyWABhQeNXp3/wfDABt1jIJXhY+9bxuOEyIJAkXLZAncQxIeGaX7KydVkC3X86RBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564270; c=relaxed/simple;
	bh=swHT9KYQZGY6sz+nCX6mQG/q6Hj/fUNezaW4+0W2HUM=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XK3PyeBaVjNCpI2zuS8cwy1gUcoYCRuJjLGliSEDx4WTOIBBQcHSB6Q5FdtevPEi92KCtu43hfeAQr2b393fvgZOOiizGvSYUMKeftWB89cTj6ayPdYzE2GuKpDIFTJFv4YieMPmfNN6GxTMTG9XcJ3CXEX3lVOz7DmuXEraZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40TLTsxW032208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 21:30:01 GMT
Date: Mon, 29 Jan 2024 21:29:54 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
In-Reply-To: <20240129205623.sgvkhcyyepbsjzh3@ws.net.home>
Message-ID: <Pine.BSM.4.64L.2401292118320.19873@herc.mirbsd.org>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>
 <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de> <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>
 <5b8f9459-cc95-4c08-b68c-39abb2ff9f68@t-8ch.de> <20240129205623.sgvkhcyyepbsjzh3@ws.net.home>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Bill Unruh dixit:

> Perhaps if you told us what you really wanted to do, instead of asking
> why your first method did not work and how to fix it. Eg, you wnat to
> add another partition to the usb disk since the boot system only used
> 5GB of a 128GB usb, and you don't want to waste 123GB of space.

Something like that.

I have: an ISO 9660 filesystem that already contains a bootable MBR
with a partition table and even inlines an EFI thingy:

tglase@x61w:~ $ /sbin/fdisk -l /tmp/grml96-full_2022.11.iso
Disk /tmp/grml96-full_2022.11.iso: 1.62 GiB, 1734606848 bytes, 3387904 sect=
ors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x2e49ce75

Device                        Boot Start     End Sectors  Size Id Type
/tmp/grml96-full_2022.11.iso1 *        0 3387903 3387904  1.6G  0 Empty
/tmp/grml96-full_2022.11.iso2        628    8819    8192    4M ef EFI (FAT-=
12/16/32)

I can dd(8) that to a USB stick and it=E2=80=99ll be bootable. My USB stick
measures 4 GiB however, so I wanted to add a third partition that
uses the remaining space to store extra data, which I can then use
in the live system, alongside on the stick:

tglase@x61w:~ $ sudo fdisk -l /dev/sdb
Disk /dev/sdb: 3.73 GiB, 4009754624 bytes, 7831552 sectors
Disk model: Flash Disk
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x2e49ce75

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1  *          0 3387903 3387904  1.6G  0 Empty
/dev/sdb2           628    8819    8192    4M ef EFI (FAT-12/16/32)
/dev/sdb3       3389440 7831551 4442112  2.1G 83 Linux

(Oh, apparently it=E2=80=99s less than 4 GiB. Anyway.)

So I did =E2=80=9Csudo fdisk /dev/sdb=E2=80=9D and added a partition, as us=
ual.


Karel Zak dixit:
>Thomas Wei=C3=9Fschuh dixit:
>>In the message you may or may not have seen there is a reference to the
>>`--wipe` option that describes the reasoning and possibilities.

Oh, good point. I guess I=E2=80=99m surprised it does that by default.

>There is also --protect-boot and --wipe-partitions, that may help in
>some cases.

Incidentally, I *did* know-ish about --wipe-partitions precisely
because the default =E2=80=9Cauto=E2=80=9D (according to the manpage=E2=80=
=A6

>>Reproduced here for your convenience:
>>https://manpages.debian.org/bookworm/fdisk/fdisk.8.en.html

=E2=80=A6 I=E2=80=99m on bullseye, so slightly older but still present) *do=
es* ask
for =E2=80=9Cauto=E2=80=9D in interactive mode.

But --wipe doesn=E2=80=99t=E2=80=BD

       -w, --wipe when
[=E2=80=A6]
              given,  the  default is auto, in which case signatures are wi=
ped
              only when in interactive mode.  In all cases detected signatu=
res
[=E2=80=A6]
       -W, --wipe-partitions when
[=E2=80=A6]
              tion is not given, the default is auto, in which case signatu=
res
              are wiped only when in interactive mode and  after  confirmat=
ion
              by user.  In all cases detected signatures are reported by wa=
rn=E2=80=90
[=E2=80=A6]

So this inconsistency combined with auto being the default but
auto not meaning the same thing tripped me up.

>>As for why: "in order to avoid possible collisions".

Huh. But there already was a partition table there, and all I did
was to add another partition in free space at the end.

>>For convenience it even may have shown a prominent warning in bright red
>>letters with helpful pointers. Or maybe it didn't.

Let=E2=80=99s see=E2=80=A6

tglase@x61w:~ $ sudo fdisk /dev/sdb

Welcome to fdisk (util-linux 2.36.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

The device contains 'iso9660' signature and it will be removed by a write c=
ommand. See fdisk(8) man page and --wipe option for more details.

Command (m for help):

No line wrapping, but no bright red letters either =E2=98=BB

The terminal wrapped this between --wi and pe, so I guess
this is the reason for me to oversee that. (And even then,
the message does not indicate that I could also disable
wiping there as the option is just named --wipe and not
either paired with --no-wipe or named --wipe-mode which
would have implied multiple possibilities. Here, a user
could think =E2=80=9Cmeh, I don=E2=80=99t want to wipe, so I don=E2=80=99t =
pass
--wipe and then it won=E2=80=99t do that=E2=80=9D.

>>> So, how do I get fdisk to not corrupt the ISO 9660 part?
>>
>>Try `--wipe never` as explained above.

OK, thanks, will try that next time. Or actually=E2=80=A6

tglase@x61w:~ $ sudo fdisk -w never /dev/sdb

Welcome to fdisk (util-linux 2.36.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

The device contains 'iso9660' signature and it may remain on the device. It=
 is recommended to wipe the device with wipefs(8) or fdisk --wipe, in order=
 to avoid possible collisions.

Command (m for help):

=E2=80=A6 from the message this sounds like it=E2=80=99ll do the trick.
(I still think that =E2=80=9Cpossible collisions=E2=80=9D could have been
worded better as well, but I=E2=80=99m not English, so=E2=80=A6)

bye,
//mirabilos
--=20
FWIW, I'm quite impressed with mksh interactively. I thought it was much
*much* more bare bones. But it turns out it beats the living hell out of
ksh93 in that respect. I'd even consider it for my daily use if I hadn't
wasted half my life on my zsh setup. :-) -- Frank Terbeck in #!/bin/mksh
