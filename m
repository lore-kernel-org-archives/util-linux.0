Return-Path: pali.rohar@gmail.com
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Subject: Re: Fwd: Re: util-linux: libblkid: UDF superblock
Date: Fri, 19 Dec 2014 16:55:32 +0100
Cc: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
References: <87oaric0fs.fsf@hobgoblin.ariadne.com> <20141209103520.GK19904@x2.net.home> <20141219135608.GN19904@x2.net.home>
In-Reply-To: <20141219135608.GN19904@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2528992.AQuimYr6FL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201412191655.32934@pali>
List-ID: <util-linux.vger.kernel.org>

--nextPart2528992.AQuimYr6FL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 19 December 2014 14:56:08 Karel Zak wrote:
> On Tue, Dec 09, 2014 at 11:35:20AM +0100, Karel Zak wrote:
> > > I looked into grub2 code and it is identifying UDF label
> > > also from LogicalVolumeIdentifier. So if you want to boot
> > > something from UDF FS via grub you probably see label
> > > problems...
> > >=20
> > > So I think that rather than using broken linux
> > > implementation is better to fix it (which could bring
> > > problems with different label names in new version). And
> > > I would like to see human readable label as "555e3160".
> >=20
> > It's more important to not introduce regression, if you have
> > LABEL=3D in your fstab then you don't want to see that after
> > util-linux update your setting is obsolete and filesystem
> > unmounted.
>=20
> You have convinced me that fix the problem (and improve
> compatibility) with UDF LABEL=3D is a good idea.
>=20
> Not sure, but I guess that for many users the change will be
> invisible because preferred way is to read the LABEL from
> ISO9660 header and UDF specific LABEL is just fallback
> solution only.
>=20
> The latest Pali's patches are at:
> https://github.com/karelzak/util-linux/pull/135
>=20
>     Karel

Now I played with Windows format.exe command and it set UDF ids:

Volume identifier: "UDF Volume"
Logical volume identifier: "<label_from_user>"
Volume set identifier: "<8_hex_numbers> UDF Volume Set"

Windows shows in My Computer label from Logical volume identifier

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2528992.AQuimYr6FL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSUSnQACgkQi/DJPQPkQ1IUQACfV95fLWbUpLyHs7fvAS29+ACD
psEAnR2tHsge5evayglOF3rFCjN6ps0i
=EiNB
-----END PGP SIGNATURE-----

--nextPart2528992.AQuimYr6FL--
