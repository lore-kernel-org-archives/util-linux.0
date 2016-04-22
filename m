Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:60809 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbcDVOiS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Apr 2016 10:38:18 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 68DE2AB08
	for <util-linux@vger.kernel.org>; Fri, 22 Apr 2016 14:38:14 +0000 (UTC)
Date: Fri, 22 Apr 2016 16:38:24 +0200
From: Petr Uzel <puzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libblkid: make blkid_do_wipe() work with probes with
 offset
Message-ID: <20160422143824.GA3205@skipper.site>
References: <1460989325-28748-1-git-send-email-petr.uzel@suse.cz>
 <20160418180018.wgjfgaule76mcfyb@ws.net.home>
 <20160419090502.GA20078@skipper.site>
 <20160419091851.nzetsxvea7klztbm@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <20160419091851.nzetsxvea7klztbm@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2016 at 11:18:51AM +0200, Karel Zak wrote:
> On Tue, Apr 19, 2016 at 11:05:02AM +0200, Petr Uzel wrote:
> > On Mon, Apr 18, 2016 at 08:00:18PM +0200, Karel Zak wrote:
> > > On Mon, Apr 18, 2016 at 04:22:05PM +0200, Petr Uzel wrote:
> > > > When a probe is created with an offset, e.g. via
> > > > blkid_probe_set_device(), this offset is correctly used when lookin=
g for
> > > > the signatures, but is not respected by blkid_do_wipe() function.
> > > > Therefore the signature is removed from an invalid location.
> > >=20
> > > Wow, excellent catch.=20
> >=20
> > Thanks, feels good to again contribute a fix after such a long time :)
> >=20
> > > How did you found it? Do you use libblkid in some partitioning tool or
> > > installer?
> >=20
> > Yes, I'm trying to implement a --wipesignatures for parted - this
> > would wipe the signatures from a new partition, _before_ the kernel
> > is informed. This is to avoid mess like RAID autoassembly...
> >=20
> > [If only there was some sane mechanism lock a device to temporarily
> > prevent udev from touching it :/]
>=20
> since v2.28 fdisk wipes disks (--wipe=3Dauto,always,never), but it does
> not care about partitions.=20
>
> Maybe we can improve it and add --wipe-partitions too. IMHO it should
> not be enabled by default, because change disk layout and keep
> filesystems seems like a valid use-case.

Agreed, it certainly has to be disabled by default.


        Petr

--=20
Petr Uzel
TL SUSE L3 Team 2

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXGjdfAAoJENOWkRqakw1yCwkP/03U9lfzec1dj9BZwhyE7pUn
3UcnkFaAhNse8PxjJ9iUa8ArQ/+/+FatDF8F/LD4sfV6Lq2CjS+XRZfOSMS3FthF
JUM8nlTt67zcp0lKqFdP34jddX0fQfdJq4eXgZn4pPDv2U/9UOTDOiEXf/5udhxe
7LbQWWo2j7B8wSVF3QcD2994lZ0cI3QL71TCoNQS3xKfZWs8iOvG99CZGVcYed8A
fyFgFyaR6hEsIswASGEMxo+OtfuKUOK7IS56Ctv+TtKYKl/h1b0DHuWIOte+5ihl
Wa1HVSwdvkSSbU64Eh5NGp6a6hClPzLFWZNllsury//OlBplWz5auTluM3TW28U1
4p9uAp/bEy/HeayWAqsgmg/9fmXzYIzY5uAljEJuQnzjcjAcLGR5RuuFnO78IGtP
wfrj7dnujpcW9ChJ5jWKkxTc6f7kb5e3H/XgeORSQuvnOfb9CaEaTHLTyjodkd6I
Fj8FxS+tY22M9jQ0kJk1xW1334RTBumHhOy94sKlGl5xI0VRMCy/te6YLVcGah2k
MVBTsb7ZW2Ot5WSL8lXLEeEqT2kr/tg9QNLsnIAhH8lFJamdYtSRe+pr/KZp+vLS
alnT1PNQ/fxSopi90K16Uhvik+JdQv6rwZ7ddh3fyU1FUXqdZOkCEbhPDuuiL8WV
2fJcQ/WzGC48jFzHTAAG
=STnV
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
