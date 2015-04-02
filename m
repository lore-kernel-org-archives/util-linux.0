Return-Path: vapier@gentoo.org
Date: Thu, 2 Apr 2015 12:19:52 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150402161952.GB22171@vapier>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
 <20150401213800.GB2097@ws.net.home>
 <20150402011230.GA22171@vapier>
 <20150402082000.GC2097@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
In-Reply-To: <20150402082000.GC2097@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02 Apr 2015 10:20, Karel Zak wrote:
> On Wed, Apr 01, 2015 at 09:12:30PM -0400, Mike Frysinger wrote:
> > On 01 Apr 2015 23:38, Karel Zak wrote:
> > > On Wed, Apr 01, 2015 at 10:06:52PM +0100, Ruediger Meier wrote:
> > > > > > Maybe both cases also with or without fallback $sbindir, /sbin =
or
> > > > > > $PATH.
> > > > > >
> > > > > > I guess we should agree how somthing like this should be handel=
ed
> > > > > > in general. "eject" is also using hardcoded "/bin/umount".
> > > > >
> > > > > seems like $PATH should always be used.  if you broke $PATH, well
> > >=20
> > > Yes, agree.
> > > =20
> > > Note that we already have and use FS_SEARCH_PATH in mkfs, fsck and
> > > mount (libmount), see --enable-fs-paths-default and  --enable-fs-path=
s-extra.
> >=20
> > what's the reason for having FS_SEARCH_PATH anymore ?=20
>=20
> If I good remember then the reason is that the helpers does not have
> to be installed in standard PATH. Well, you're author of this thing
> :-)

i wrote the code to make it a configure option, but the actual behavior pre=
dates=20
me.  i'm interested more in the behavior, not the exact configure option.

looks like mkfs added it during the 2.2->2.5 transition, but otherwise no=
=20
details in the bundled NEWS that i saw.  oh well.

> > neither tool is set*id,=20
> > and mkfs/fsck generally live in /sbin.  i guess if you're non-root and =
have=20
> > /sbin/mkfs hardcoded in a script, then dropping FS_SEARCH_PATH might br=
eak=20
> > existing code.
>=20
> for systemd based distors the path should be also modified, we have
> all in /usr and /sbin and /bin are symlinks only.

but they'll still be in $PATH ?

> > > Maybe we can use it use FS_SEARCH_PATH also for mkswap in swapon, or =
use it
> > > as fallback.
> >=20
> > my preference would be to not move more tools into that system and allo=
w any=20
> > more implicit lookups to leak out.
>=20
> I'm happy that for example mount(8) does not waste time with all PATH,
> but it cares about /sbin only. IMHO it's fine that mkfs, mount and
> fsck assume *helpers* on specific place. The mkswap is different, it's=20
> standard command and it's expected in PATH.

mount makes sense as it's set*id and we can't trust users to not be evil :).
-mike

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVHWwoAAoJEEFjO5/oN/WBUdUQAMk7pQAMMqOFK08sXvTsCgXM
LOOFlMLhd0M2ToCXElkpp1cGAxffOyk4nadaZfa6V1ohAc2U242qQuG5e8VFjQE8
5xfHfyb3O5lTdYhUrWccy8r7yBZ8M2wtNdGloofai24b5hYQntiZA27hhR/7VKuW
9YVGjrxcIXnFC4vmJy8hCflAkX/XjTK4jSrsSUCTKDjOb6z9XPLb8HcwmqyWPekd
cJ3oxzlKrzKMkg9tB0EAspDsCBwSNzEgu5B20bnHhtH20yaQPdl3rpB6o+8ylbrh
jBq54JUQelB75BMUDfmrBFvnlB858twrTm2iIO/tk+1yNHGm7BjZNaynD1TGCSFv
bgJZnEYY3b/u/tRwpcvmwU9cVQKgvevSH9zZ/nVZA+N9EXcj/2Md9KWywto+hsow
mq5inRkj6SlfYc6odUXtG470VMSseYwA6wWjCnBSmGHWcwfzY8gr+PS++G5qjEKj
ZxX+OiXEmZJL7FoYMYj3Bgdqe/1RTbdyp9Hml15KRaWcon2I1yb3O2oBeHaa1z+N
aDLtNX05IZCFBWCRXAKOYtP0fYRriG69gwiObAmcWbBep+2jIgqXBQZcCMgvApaO
NGwYaJW7wluAzAacI+fvIeOci+cbYCNczwbh0zO17+LqfKUsltyv33+H3mWEjcOm
A3gGVvEHlGAn6e9lK5kx
=EPJ2
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
