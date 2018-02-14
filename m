Return-Path: linux-fsdevel-owner@vger.kernel.org
Date: Wed, 14 Feb 2018 22:54:30 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: Linux & FAT32 label
Message-ID: <20180214215430.dunkqhuztyic6tcn@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
 <20171109212131.uxraxzwpvrlyfyys@pali>
 <20171119124440.ffxx64zjmwedmtdp@pali>
 <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
 <20171126191925.zowfpduhyic5w4n5@pali>
 <20171127121301.b6obxoqr4azm3zvs@ws.net.home>
 <20180214215233.tbcoieywczdwvy37@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4wdw3rnnapsisys4"
In-Reply-To: <20180214215233.tbcoieywczdwvy37@pali>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--4wdw3rnnapsisys4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 14 February 2018 22:52:33 Pali Roh=C3=A1r wrote:
> On Monday 27 November 2017 13:13:01 Karel Zak wrote:
> > On Sun, Nov 26, 2017 at 08:19:25PM +0100, Pali Roh=C3=A1r wrote:
> > > On Monday 20 November 2017 12:12:56 Karel Zak wrote:
> > > > Go ahead and send patch :-) (also with LABEL_FATBOOT=3D)
> > >=20
> > > Ok, I prepared patches for util-linux including LABEL_FATBOOT:
> > > https://github.com/karelzak/util-linux/compare/master...pali:master
> >=20
> > Seems good. I'll wait for official pull request. Thanks!
> >=20
> > > I have not created official pull request on github yet as Andreas have
> > > not decided yet about dosfstools/fatlabel...
> >=20
> > OK.
>=20
> Looks like that Andreas is not responding to mailing list, nor to
> private emails, nor on github for 3-4 months ... I hope he is OK.
>=20
> But I do not know what happened with dosfstools project now in this
> case, if it is going to be fixed or not.
>=20
> I have prepared more patches for dosfstools project, but do not know if
> I should open new pull requests or wait (how long?) or do something
> else.
>=20
> If it helps for somebody, I can create fork of dosfstools project and
> include there all changes which I have prepared.
>=20
> Any opinion? What other people think about this situation right now?
>=20
> Karel, do you want to create official pull request for above util-linux
> changes, even without fixes in dosfstools project?

CC linux-fsdevel@vger.kernel.org as there can be other people interested
in FAT & dosfstools...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--4wdw3rnnapsisys4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWoSwFAAKCRCL8Mk9A+RD
UkElAKCqrVrS/L6IGUM3Qrh4II9NnpekJACgijAESFevrpdIxL3PYKlu2njbQ9A=
=iLbC
-----END PGP SIGNATURE-----

--4wdw3rnnapsisys4--
