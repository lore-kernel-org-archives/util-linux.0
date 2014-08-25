Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:48727 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760AbaHYSaF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Aug 2014 14:30:05 -0400
Date: Mon, 25 Aug 2014 20:29:46 +0200
From: =?ISO-8859-2?B?TWljaGGzIEfzcm55?= <mgorny@gentoo.org>
To: util-linux@vger.kernel.org
Subject: cfdisk wipes out partition table when trying to replace a single
 logical partition
Message-ID: <20140825202946.3d4fbaac@pomiot.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/WUjTYnKk_w/maeAQBoAEe=="; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--Sig_/WUjTYnKk_w/maeAQBoAEe==
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

(please CC me on replies)

Hello,

I'm afraid I've hit a bug that has been introduced in 2.25 and still
not fixed in current git.

I start with the following disk layout:

  Device     Boot    Start       End   Sectors  Size Id Type
  /dev/sdb1  *          63  93755339  93755277 44.7G  7 HPFS/NTFS/exFAT
  /dev/sdb2       93755392 234439534 140684143 67.1G  5 Extended
  /dev/sdb5       93757440 135700479  41943040   20G 83 Linux

Now I start cfdisk and remove sdb5, and create a larger partition on
top of it. At this point, cfdisk shows correct disk layout (sdb1, sdb2
and new sdb5), so I save it. However, the partition table written to
disk is incorrect:

  Device     Boot    Start       End  Sectors Size Id Type
  /dev/sdb1       93757440 146186239 52428800  25G 83 Linux

As far as I can see, cfdisk removed both the primary and extended
partitions, and wrote my new logical partition as primary. As you can
guess, this is rather unexpected and undesired.

I can consistently reproduce the issue.

--=20
Best regards,
Micha=B3 G=F3rny

--Sig_/WUjTYnKk_w/maeAQBoAEe==
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQJ8BAEBCgBmBQJT+4CgXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQ2REJCMDdDQzRGMERBRDA2RUEwQUZFNDFC
MDdBMUFFQUVGQjQ0NjRFAAoJELB6GurvtEZOGGAP/3/bRIycd2ZQlLHOUUHDKw4M
ftJPSpAIrZD299mEI4GN84ftQRn9VMe36ZNHIU2XseOjiT24SD5Zvxxy5GYtSOaa
gI7FQIM85fCw3y+hjXJ3Rhna1pny/GvFAm66F3cmyJ9E67i3oJl1M0XiTT7p18UX
HmzfGzNWK0hzfALUzdFt+Xsqc09KlwgZbzEpBHklh/ePWzB27ejML50n+0bNbT7i
ATQGicc3uM61eO98yzrSLM4DXppuQ1GFR4r9PXzOqeo+vDyt85wUsuLb46AaeNaE
cMtJvq1yYWuHi1BY7TdUoHf7Z90F4AaUYn1fA2amHEtFP6ojfU6rvtKXd08bo8s3
vG96XCc4y11R5Lblnucf9B5DoM7EZgsh1GQBTyhrNAB8tqn3d1liI1m3kKebCJYO
AdcazgQU639iM1IKwQZ7bInPDVd9mufP9wgqUu2bCwRPYhuboNvtiOOkIcfaeWjd
1e/Nv3W0RH/QgThk4IIbf4gyRMzrwON7t319M9mZBOuBfhDbjr7zdTWbZcQ/4ZVV
CJit19Z+tJ8v4Ecm9o9D2D9VdNxR4rrIhjFoxGuDiz7nQR+RO1PHoIobYf9rQ0SH
JuD/Yi19+XUDhiVmKr1oEIXtVE0gdRJ4nWJ6lt+9ux8Sg1B02gV/aC/kFZc2uYln
iJ8lZtYvi5FAj1EYpEQu
=uFSc
-----END PGP SIGNATURE-----

--Sig_/WUjTYnKk_w/maeAQBoAEe==--
