Return-Path: pali.rohar@gmail.com
Date: Mon, 29 Jan 2018 17:49:17 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andreas Bombe <aeb@debian.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: util-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
	Curtis Gedak <gedakc@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Karel Zak <kzak@redhat.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20180129164917.y4syrwrb634r4qj4@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
 <20171109212131.uxraxzwpvrlyfyys@pali>
 <20171119124440.ffxx64zjmwedmtdp@pali>
 <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
 <20171129232126.3hymurdf7uedl6c2@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ljhlxexkryxe7nax"
In-Reply-To: <20171129232126.3hymurdf7uedl6c2@pali>
List-ID: <util-linux.vger.kernel.org>


--ljhlxexkryxe7nax
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 30 November 2017 00:21:26 Pali Roh=C3=A1r wrote:
> On Monday 20 November 2017 12:12:56 Karel Zak wrote:
> > On Sun, Nov 19, 2017 at 01:44:40PM +0100, Pali Roh=C3=A1r wrote:
> > > On Thursday 09 November 2017 22:21:31 Pali Roh=C3=A1r wrote:
> > > > So from all tests and discussion I would propose new unification:
> > > >=20
> > > > 1. Read label only from the root directory. If label in root direct=
ory
> > > >    is missing then disk would be treated as without label. Label fr=
om
> > > >    boot sector would not be read.
> > > >=20
> > > >    --> Reason: Windows XP and mlabel ignores what is written in boot
> > > >        sector. Windows XP even do not update boot sector, so label
> > > >        stored in boot sector is incorrect after any change done by
> > > >        Windows XP.
> > > >=20
> > > >        This logic is used by all tested MS-DOS and Windows versions,
> > > >        plus also by mtools on Linux.
> > > >=20
> > > > 2. Write label to to both location, boot sector and root directory.
> > > >=20
> > > >    --> Reason: MS-DOS 6.22, MS-DOS 7.10, Windows 98 and also mtools=
 on
> > > >        Linux do this. This is also what is written in FAT specifica=
tion.
> > > >=20
> > > >        It also provides backward compatibility with old dosfslabel
> > > >        versions which read label only from boot sector.
> > > >=20
> > > > 2. Process 'NO NAME    ' label in root directory as 'NO NAME' name.=
 Not
> > > >    as empty label.
> > > >=20
> > > >    --> Reason: 'NO NAME    ' is regular entry in root directory and=
 both
> > > >        Windows XP and mlabel handle it in this way.
> > > >=20
> > > > 3. Process 'NO NAME    ' label in boot directory as empty label. No=
t as
> > > >    label with name 'NO NAME'.
> > > >=20
> > > >    --> Reason: On Windows XP when formatting empty disk and label i=
s not
> > > >        specified then 'NO NAME    ' is stored to boot sector.
> > > >=20
> > > >        Also in FAT specification is written that empty label is sto=
red
> > > >        as 'NO NAME    '.
> > > >=20
> > > > With this change we would get compatibility with MS-DOS, Windows (b=
oth
> > > > DOS-based and NT-based) and also with Linux mtools, modulo problems=
 DOS
> > > > code page.
> > > >=20
> > > > There are just two negatives:
> > > >=20
> > > > 1) Labels set by old dosfslabel versions (which stored them only to=
 boot
> > > >    sector) would not be visible. But they are already not visible on
> > > >    MS-DOS or Windows machines, and also via mlabel (from mtools).
> > > >=20
> > > > 2) Behavior of blkid and fatlabel would be changed as both tools ha=
ve
> > > >    different as proposed above, and based on tests they also differ=
 each
> > > >    from other.
> > > >=20
> > > > Andreas, Karel, what do you think about it?
> > >=20
> > > Also for other people, do any have comments on my proposed solution?
> >=20
> > Go ahead and send patch :-) (also with LABEL_FATBOOT=3D)
>=20
> Now I implemented changes for dosfstools project, pull request is there:
> https://github.com/dosfstools/dosfstools/pull/73
>=20
> Just waiting for the Andreas response...

Seems... there is no activity since October in dosfstools github project.

Andreas, I have no response from you, are OK?

Just I would like to know if you are interested in changes and if I
should prepare another patches for dosfstools. I just do not want to go
coding and implement something which will be rejected...

> Andy, you wanted some manpage update. I did it in this commit:
> https://github.com/dosfstools/dosfstools/pull/73/commits/3f4f122b7ec8eeb4=
a0ae0db8e94b8829f51d1163
> Can you check if changes in manpage are OK?

Andy, can you check that manpage update?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ljhlxexkryxe7nax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWm9QiQAKCRCL8Mk9A+RD
UjMtAKCj/bhJKn++tAK8xgWcHKeXYdlNBACZAXZKGOtUIXS2qIMxxARDGB4RiMg=
=5pMI
-----END PGP SIGNATURE-----

--ljhlxexkryxe7nax--
