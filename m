Return-Path: pali.rohar@gmail.com
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Subject: Re: Fwd: Re: util-linux: libblkid: UDF superblock
Date: Tue, 9 Dec 2014 12:11:01 +0100
Cc: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
References: <87oaric0fs.fsf@hobgoblin.ariadne.com> <201412050325.06569@pali> <20141209103520.GK19904@x2.net.home>
In-Reply-To: <20141209103520.GK19904@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7711075.uhbcJXoxQb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201412091211.01584@pali>
List-ID: <util-linux.vger.kernel.org>

--nextPart7711075.uhbcJXoxQb
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 09 December 2014 11:35:20 Karel Zak wrote:
> On Fri, Dec 05, 2014 at 03:25:06AM +0100, Pali Roh=C3=A1r wrote:
> > On Friday 05 December 2014 03:09:11 Dale R. Worley wrote:
> > > Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
> > > >> So I think that it is better to use
> > > >> LogicalVolumeIdentifier for libblkid LABEL. And not
> > > >> current VolumeIdentifier.
> > > >>=20
> > > >> What do you think?
> > >=20
> > > If you change how the LABEL value is read from the disk,
> > > every user will see different LABEL values than they saw
> > > in the past.
> > >=20
> > > Dale
> >=20
> > Yes, but apparently other systems are using LABEL from
> > LogicalVolumeIdentifier. So now you see different labels on
> > different systems which is not good too.
> >=20
> > Also that bsd project UDFclient (which is working on Linux
> > too!) is using LogicalVolumeIdentifier as volume/disk name
> > in newfs_udf tool.
> >=20
> > I looked into grub2 code and it is identifying UDF label
> > also from LogicalVolumeIdentifier. So if you want to boot
> > something from UDF FS via grub you probably see label
> > problems...
> >=20
> > So I think that rather than using broken linux
> > implementation is better to fix it (which could bring
> > problems with different label names in new version). And I
> > would like to see human readable label as "555e3160".
>=20
> It's more important to not introduce regression, if you have
> LABEL=3D in your fstab then you don't want to see that after
> util-linux update your setting is obsolete and filesystem
> unmounted.
>=20
> It would be possible use another header field
> (LogicalVolumeIdentifier) for LABEL=3D only if the currently
> used field is empty.
>=20
>     Karel

Karel, problem is that other software (for formatting udf fs) set=20
VolumeIdentifier to some random string (like "555e3160"). Which=20
means that in Linux we do not see correct LABEL. All other=20
implementations which I saw are using LogicalVolumeIdentifier for=20
LABEL (it is also written in specification). And more... grub2=20
read LABEL from LogicalVolumeIdentifier, so you cannot specify=20
UDF disk by its LABEL from linux for grub2. I think this is bug=20
in util-linux which needs to be fixed. I understand that there=20
could be regressions, but current implementation is not correct=20
(it show wrong labels "555e3160"; show different as other=20
systems; is not correct according to specification).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart7711075.uhbcJXoxQb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSG2MUACgkQi/DJPQPkQ1LFnACgiZJEP/GV7Ot1QmynwT8d8bti
gOcAoKXp3b5Z6M2WblIVT1wJw4bAlo/O
=z/rm
-----END PGP SIGNATURE-----

--nextPart7711075.uhbcJXoxQb--
