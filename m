Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:39222 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab1GMSbS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jul 2011 14:31:18 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Theodore Tso <tytso@mit.edu>
Subject: Re: `fsck -A` and fs-specific options
Date: Wed, 13 Jul 2011 14:31:16 -0400
Cc: util-linux@vger.kernel.org
References: <201107112259.55340.vapier@gentoo.org> <CAJaTeTpBxcZ8ofxSHd7B1aRbU3wtSH=ED6ZYKEPPs4q3fgc2nA@mail.gmail.com> <EFBAB464-FF32-46CB-8BB9-A94CE880F730@mit.edu>
In-Reply-To: <EFBAB464-FF32-46CB-8BB9-A94CE880F730@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1739884.vNaltxE6Zy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201107131431.17224.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1739884.vNaltxE6Zy
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday, July 13, 2011 07:17:27 Theodore Tso wrote:
> On Jul 12, 2011, at 3:18 PM, Mike Frysinger wrote:
> > when i read the kernel source, that seemed to be the case.  but i dont
> > think it's the case for reiserfs, and i think there's a very tiny edge
> > case with ext[34] related to moving the journal, but probably so small
> > we can ignore it :p.
>=20
> What do you think the edge case is?   Yes, the external journal's
> dev_t is cached, but that is only used by the kernel since it
> was simpler than having callouts to a userspace daemon.
>=20
> E2fsck will use blkid to locate the external journal, and when it
> finds it, it will update the cached dev_t if it is out of date, so that
> at mount time the kernel will be able to find the external journal.
> This way even if the external journal is on a device with an
> unstable dev_t (e.g., a USB device), the right thing should
> happen...

that sounds like it covers all the non-pathological cases ;)
=2Dmike

--nextPart1739884.vNaltxE6Zy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOHeR1AAoJEEFjO5/oN/WBadoP/1YKDF6EldKl9P2RFdZVhJvF
hZFLBGArI9WDPMUzdDYwpJLA00mBgJUtxaCQkh9K5d41mMlgVyqHh/SaFG3lhv+J
2Uqdmtb5fzzB1ZdT3UN5t1LEhJl2dTyaWwthdXSaXNYXnKlW1veO3sQ3FnoRF8ue
ZMVrh/dRnwP8v6t/6NtrTBaElv0Trk+ZvYGiOa3KHO/CkZjKv8IB+yeC1CTmg1oW
sOwWek/zZ6KxXmDjfexn7ZWy1H2O+L2PxkkV157vAvGm79h0tlKBMbrVA6Y/dLFg
KyXpXr8Utb0h6a599InfMhB9Tot3kowXZXmfwtCCZgP9ehMbx3Z4Vg66xbFz3NgG
6ChhDuYMzbbpDM3RIYg4J87nGCuCZfQzbWIIFWY1F7IseJDaW5/mKM8RHiIEiQqm
T5/bxNt4lBXTfIK6t3b1K8oC65WOvd4DseWOO5/qMPT05B+pUhPa62mDhfrVxS5L
wEueu5AEziBxMGMkZc2WKmed7xGoqRPMIiLRV35zLEzgm3a/lNMN7wlafOG4lgGN
CaBwGanuheIv/Uxx3bu0tjcotT0jodYlxaq/HQcA6JPYqkmA9vIaqi+zTuymtnNb
rFGTQZoYyRWEpaukP1AAH5KleEd8XUZT/MqZZeUfobop69E5npa15ZX6FC7Zk3jA
E64Fb/JHL5EQRD8BZwYi
=1ftH
-----END PGP SIGNATURE-----

--nextPart1739884.vNaltxE6Zy--
