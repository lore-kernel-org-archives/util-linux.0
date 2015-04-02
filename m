Return-Path: vapier@gentoo.org
Date: Wed, 1 Apr 2015 21:12:30 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150402011230.GA22171@vapier>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
 <20150401213800.GB2097@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
In-Reply-To: <20150401213800.GB2097@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01 Apr 2015 23:38, Karel Zak wrote:
> On Wed, Apr 01, 2015 at 10:06:52PM +0100, Ruediger Meier wrote:
> > > > Maybe both cases also with or without fallback $sbindir, /sbin or
> > > > $PATH.
> > > >
> > > > I guess we should agree how somthing like this should be handeled
> > > > in general. "eject" is also using hardcoded "/bin/umount".
> > >
> > > seems like $PATH should always be used.  if you broke $PATH, well
>=20
> Yes, agree.
> =20
> Note that we already have and use FS_SEARCH_PATH in mkfs, fsck and
> mount (libmount), see --enable-fs-paths-default and  --enable-fs-paths-ex=
tra.

what's the reason for having FS_SEARCH_PATH anymore ?  neither tool is set*=
id,=20
and mkfs/fsck generally live in /sbin.  i guess if you're non-root and have=
=20
/sbin/mkfs hardcoded in a script, then dropping FS_SEARCH_PATH might break=
=20
existing code.

looking a bit at the code, i see that --disable-fs-paths-default almost doe=
s the=20
right thing.  but the actual implementations are inconsistent leading to=20
weirdness.

fsck adds / to the search:
=2E..
static const char fsck_prefix_path[] =3D FS_SEARCH_PATH;
=2E..
    char *oldpath =3D getenv("PATH");
=2E..
    if (oldpath) {
        fsck_path =3D xmalloc (strlen (fsck_prefix_path) + 1 +
                    strlen (oldpath) + 1);
        strcpy (fsck_path, fsck_prefix_path);
        strcat (fsck_path, ":");
        strcat (fsck_path, oldpath);
=2E..
    tpl =3D (strncmp(type, "fsck.", 5) ? "%s/fsck.%s" : "%s/%s");

    for(s =3D strtok(p, ":"); s; s =3D strtok(NULL, ":")) {
        sprintf(prog, tpl, s, type);
        if (stat(prog, &st) =3D=3D 0)
            break;
    }
=2E..

mkfs adds the cwd to $PATH, and hardcodes /bin too:
=2E..
#define SEARCH_PATH "PATH=3D" FS_SEARCH_PATH
=2E..
    /* Set PATH and program name */
    oldpath =3D getenv("PATH");
    if (!oldpath)
        oldpath =3D "/bin";

    newpath =3D xmalloc(strlen(oldpath) + sizeof(SEARCH_PATH) + 3);
    sprintf(newpath, "%s:%s\n", SEARCH_PATH, oldpath);
    putenv(newpath);
=2E..

libmount only searches FS_SEARCH_PATH:
=2E..
    char search_path[] =3D FS_SEARCH_PATH;        /* from config.h */
=2E..
    path =3D strtok_r(search_path, ":", &p);
    while (path) {
=2E..

> Maybe we can use it use FS_SEARCH_PATH also for mkswap in swapon, or use =
it
> as fallback.

my preference would be to not move more tools into that system and allow an=
y=20
more implicit lookups to leak out.
-mike

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVHJd+AAoJEEFjO5/oN/WB4TwQALx3QVSILGcuBIED9WDCZGDM
/92azLp7zgORNx7d+GLW2fFmi/jyjcpB1wkWAP9G/0ca/4FQq5Z8C1voCZ4axXiS
GBnC2OKgE8Z99Ru0GE3oD72kQVvfWuw4rgbgSLyUx4c/hI7eHN3EvhlyI97ZpQeh
z4og5f9vVmTUIMW89O3w63800X+nhraY/vUJw/mFUfrwaJgEePwRxU20dRWfqc1T
8Z7K4xXqY/HDueK3AWUxr5AeeSBaQ4M2DO1ZsRmHMrPx9iv2wnoB6gR3xon461ek
Sy4LBlmSb/nWJnhrSc6S40E9lBlFKifV0c0ESdi2xDrxdDnVf5XJjW85g9TsndpB
jDzFMVjQMZnehylJSsg+GFH6KlEAUz26y+UXIVAbJ3a0vxcpxHKlkvp/lDZQFgrZ
TlySmL0FepSUSBUHYEDuBsGLP6Nv2m10L0va9ClVKn/TBKAXXeLa7K7T3UaHLV57
6FHcxJPzpLXnXmY4+lSs7NTB18FKNrKsMWe+VWWVRg97xFwkRx8Lj7OBcYTLbJ7j
ijLd9xuVu11Zq5CgEVPCrqQw9x2E/0l205XFFxX2H7RBrU+jx1/sd2OzyXO3QsUG
XRyUhaLZ2k+mgpuII65W2G/f1COdEhzvU6TjELsAA+aVNIq2Yy4rVufwmB8YU2a5
ZgtZn5h7EvTImcENaNzI
=xU+/
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
