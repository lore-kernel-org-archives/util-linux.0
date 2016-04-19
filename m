Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33062 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbcDSJFE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Apr 2016 05:05:04 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 07D18AC54
	for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 09:05:01 +0000 (UTC)
Date: Tue, 19 Apr 2016 11:05:02 +0200
From: Petr Uzel <puzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libblkid: make blkid_do_wipe() work with probes with
 offset
Message-ID: <20160419090502.GA20078@skipper.site>
References: <1460989325-28748-1-git-send-email-petr.uzel@suse.cz>
 <20160418180018.wgjfgaule76mcfyb@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <20160418180018.wgjfgaule76mcfyb@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 08:00:18PM +0200, Karel Zak wrote:
> On Mon, Apr 18, 2016 at 04:22:05PM +0200, Petr Uzel wrote:
> > When a probe is created with an offset, e.g. via
> > blkid_probe_set_device(), this offset is correctly used when looking for
> > the signatures, but is not respected by blkid_do_wipe() function.
> > Therefore the signature is removed from an invalid location.
>=20
> Wow, excellent catch.=20

Thanks, feels good to again contribute a fix after such a long time :)

> How did you found it? Do you use libblkid in some partitioning tool or
> installer?

Yes, I'm trying to implement a --wipesignatures for parted - this
would wipe the signatures from a new partition, _before_ the kernel
is informed. This is to avoid mess like RAID autoassembly...

[If only there was some sane mechanism lock a device to temporarily
prevent udev from touching it :/]

>=20
> Applied, thanks!

Thanks,

        Petr


--=20
Petr Uzel
TL SUSE L3 Team 2

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXFfS+AAoJENOWkRqakw1yRSgQAJr/Aql0BMwI+bH5eDqFYPym
uBWE1Of/LWw/b7k4iP2ZVA5AmmivCO0RONaR5QPg2z7HLNasL2U2unrBEV12+Bna
fUqTbDfdM3oZbHzqytPkyT73KhyHelhtKcyPBrbf1BxaQJKjP+8zM3ydqlXWKXbA
ht0tyoUzaF117espxCsdYX2kRPFKm8436zT3qAKxVh8NBhgr2aggTueuI0uVnTV+
FtwD8YQ6UXZVmNFrIqjtgDmSU96Mbtngmo0swtG6ZKddYBZ6A3cF3S89Wx65w9ZO
y7KpTLKWCGCAZgzKUI99bW+Trh6uhjFvBi0gjVMv/oWTXCMJ5MoqHapeUrhw4y+J
82VYser/lhor/yU3t5o2TT2PTRyd2LNAcddUi56E4/vR6teUOkxXM6stpnqW3MQ8
Zv8X2Fb4JHxFHSPxGKftp0aU9xzD39QdTTth6BlUMOeCRR2GvEIFF7CKq8H6OJmT
7iUimh4wQNxg/uwsthBMSWBkRD1OGgGerTBdXhC08hqYPJdPVgHP3qXKOKjclGVD
JURYhcE0/Z/fC/fX7N3Z7rG4rNpiI/7LnrEM67o7mRbSyvezqYH/uHvFexDhhw11
58cjMkUyZ+LYRxQoPA/XDTVie4J2EadYGTCvWtuUDA9dgJGU5n4oz8YI7dE+vcin
MNitVslScXZzamZYYA0L
=huAM
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
