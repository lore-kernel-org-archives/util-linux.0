Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:64813 "EHLO
	mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbbCAP4N (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 10:56:13 -0500
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta04.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NKJ00A7OCSEYGP0@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Sun, 01 Mar 2015 11:56:10 -0400 (AST)
Received: from peter by llama.cordes.ca with local (Exim 3.36 #1 (Debian))
	id 1YS6Dy-0002bA-00	for <util-linux@vger.kernel.org>; Sun,
 01 Mar 2015 11:56:10 -0400
Date: Sun, 01 Mar 2015 11:56:10 -0400
To: util-linux <util-linux@vger.kernel.org>
Subject: sfdisk problem with a partition starting early on a GPT disk
Message-id: <20150301155610.GW3933@cordes.ca>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

 I recently got 3 new disks, and am setting them up now that I've
figured out how I want to RAID them together, and what you can boot
=66rom.  (for the record, turns out you can boot from almost anything,
even a RAID10,f2 of 2 disks, or a RAID10,n2 of 3 disks, with GRUB2.  I
tested on another machine before putting the disks into my main
machine, so I could do stuff without rebooting my main machine.)


 Anyway, seemed like a golden opportunity to test the new sfdisk.  I
partitioned one with parted, then created a BIOS boot partition (from
sector 40 to 2047), fixed the partition types and sorted the partition
table to be in disk order with gdisk.  Then I tried to copy the
partition table from that one to the other two.

I got an error from sfdisk on trying to apply the plan it printed.

# the disk I partitioned manually:
$ sudo /usr/local/src/util-linux/sfdisk -d /dev/sde | tee tosh-partitions.s=
fdisk
label: gpt
label-id: 7E471862-5089-4C54-A3BC-722ADD08808A
device: /dev/sde
unit: sectors

/dev/sde1 : start=3D          40, size=3D        2008, type=3D21686148-6449=
-6E6F-744E-656564454649, uuid=3D01F40706-97E6-43D1-80D3-0EA85BB5E8FD, name=
=3D"BIOS boot partition"
/dev/sde2 : start=3D        2048, size=3D    30720000, type=3DA19D880F-05FC=
-4D3B-A006-743F0F84911E, uuid=3D9898E8B2-C930-4E6E-826A-4D7305793E6A
/dev/sde3 : start=3D    30722048, size=3D   122880000, type=3DA19D880F-05FC=
-4D3B-A006-743F0F84911E, uuid=3DC0CF3D7C-A170-4E1E-9169-9AB4A4FF3164
/dev/sde4 : start=3D   153602048, size=3D   820695040, type=3DA19D880F-05FC=
-4D3B-A006-743F0F84911E, uuid=3DF9258FDA-14A3-4B72-B367-F3B1B244C407
/dev/sde5 : start=3D   974297088, size=3D     2457600, type=3D0657FD6D-A4AB=
-43C4-84E5-0933C84B4F4F, uuid=3D8EF2E18C-8E3D-41A3-86AF-EE4FDA7B103D
/dev/sde6 : start=3D   976754688, size=3D  4883777536, type=3DA19D880F-05FC=
-4D3B-A006-743F0F84911E, uuid=3D265297FD-E7AA-484F-BEC2-D03C385E75DD


# one of the other two disks:
 $ sudo /usr/local/src/util-linux/sfdisk /dev/sdj < tosh-partitions.sfdisk
 Checking that no-one is using this disk right now ... OK
=20
 Disk /dev/sdj: 2.7 TiB, 3000592982016 bytes, 5860533168 sectors
 Units: sectors of 1 * 512 =3D 512 bytes
 Sector size (logical/physical): 512 bytes / 4096 bytes
 I/O size (minimum/optimal): 4096 bytes / 4096 bytes
 Disklabel type: gpt
 Disk identifier: 74559404-2E86-49E7-8B30-219F09264C1E
=20
 Old situation:
=20
 Device         Start       End   Sectors   Size Type
 /dev/sdj1       2048 572524543 572522496   273G Microsoft basic data
 /dev/sdj2  572524544 868653055 296128512 141.2G Linux filesystem
 /dev/sdj3  868653056 904501247  35848192  17.1G Linux filesystem
 /dev/sdj4         40      2047      2008  1004K BIOS boot
 /dev/sdj5  904501248 927029247  22528000  10.8G Linux filesystem
 /dev/sdj6  927029248 945461247  18432000   8.8G Linux filesystem
=20
 Partition table entries are not in disk order.
=20
 >>> Script header accepted.
 >>> Script header accepted.
 >>> Script header accepted.
 >>> Script header accepted.
 >>> Created a new GPT disklabel (GUID: 7E471862-5089-4C54-A3BC-722ADD08808=
A).
 Sector 40 already used.
 Failed to add partition: Numerical result out of range
 Leaving.



Removing the boot partition from the plan before feeding it to sfdisk
makes it work.  (4k aligned partition in the first 1MiB before the
first aligned-to-1MiB partition that gparted creates. See
https://en.wikipedia.org/wiki/BIOS_boot_partition).


Am I missing something?  Even -f didn't work.  I don't have sfdisk
=66rom git HEAD (14160b7bd08f54f9...) installed; I'm just running it
=66rom /usr/local/src on Ubuntu 14.10, in case that helps explain
anything.

Does sfdisk use more space for its GPT than other tools, like gdisk
or gparted?  After making a new GPT partition table with either of
those tools, I could make a new partition starting as early as sector
34 (according to gdisk).  I make my boot partition start at sector 40
just so it's 4k aligned.  (It's only written by grub-install, not the
usual update-grub on kernel updates, so it's not like it matters if
it's aligned anyway, but still.)

 Oh that's weird.  Running gdisk on the sfdisk-partitioned disk
doesn't let me create a partition before the one at 1MiB (sector
2048).  Does sfdisk make the partition table itself consume the full
first 1MiB of the disk?

 And BTW, yes I tested booting Linux with GRUB2 on disks with the
bios_grub partition from sector 40-2047.  I don't think I ever tried
having it anywhere else.  I never had a problem with it in my
experiments with GRUB reading md RAID devices.  (GRUB can read
basically anything except RAID0.  The machine hard resets when I try
that...  It has no trouble with RAID10,f2, or even RAID10 on 3 disks,
so it can read multiple disks.)

I'm not an expert, so IDK if there's some reason it's reasonable to
reject a config like this, but other tools have no problem creating
and using it (except gparted, with align to 1MiB or cyclinder as the
only options, but it doesn't even let you set the partition type
correctly for md on GPT.)

--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iLwEAQEIAAYFAlTzNpkACgkQBaSaEuRa5FPgYgT/djoxDB+suI0tPg21KRGVTbu/
FB1gVttAQhRq2Mzg0Ocw6nK6GLySAWRiklPHeuJsVSw/vvfe5F8Tqs8dmEQ9k8TO
MIVBlaDbb2sbcq/14ckRSK8AkfkYdzLwfDCBbPbcuVgJz3s1m2g5LdG4/X9pqLwC
BKV8V+cb2uD+2IYUHAZJgM/3scnXfDrLLIDpR949X8X7cK1f8e33t4601mQyPg==
=J+5/
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
