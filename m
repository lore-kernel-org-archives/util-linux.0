Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43297 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbaLaJX4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Dec 2014 04:23:56 -0500
Date: Wed, 31 Dec 2014 04:23:54 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: setarch cannot set all listed architectures
Message-ID: <20141231092354.GG3906@vapier.wh0rd.info>
References: <1419438949.242820.206484249.1D540D03@webmail.messagingengine.com>
 <20141231083046.GF3906@vapier.wh0rd.info>
 <1420017348.3190622.208236865.6FAABC76@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
In-Reply-To: <1420017348.3190622.208236865.6FAABC76@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31 Dec 2014 10:15, Benno Schulenberg wrote:
> On Wed, Dec 31, 2014, at 09:30, Mike Frysinger wrote:
> > On 24 Dec 2014 17:35, Benno Schulenberg wrote:
> > > The man page of setarch says for the option --list: "List the archite=
ctures
> > > that can be set."  However...
> > >=20
> > > $ ./setarch --list  =20
> > > [...]
> > > i686
> > > athlon
> > > x86_64
> > > ia64
> > >=20
> > > $ ./setarch x86_64 uname -m
> > > setarch: x86_64: Unrecognized architecture
> > >=20
> > > [...]
> > >=20
> > > Maybe --list should not be listing x86_64 and ia64 on this machine?
> > > Or maybe the error message in these cases should say "Cannot set
> > > the requested architecture" instead?
> >=20
> > are you running a 32bit or 64bit kernel ?  is your compiled setarch 32b=
it or=20
> > 64bit ?  i'm going to guess both are 32bit.
>=20
> You guessed correctly.  :)
>=20
> $ getconf LONG_BIT
> 32
>=20
> $ grep " lm" /proc/cpuinfo || echo no
> no
>=20
> $ file ./setarch=20
> ./setarch: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dyna=
mically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=3D0x=
830fc9635dbe83defa4db7b0b5db241093d4c86d, not stripped
>=20
> So... setarch --list shouldn't be mentioning x86_64 nor ia64 here?

maybe, but is it really worth the effort ?

if you took that exact 32bit binary and booted a 64bit kernel, i imagine it=
'd=20
work fine.
-mike

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUo8CqAAoJEEFjO5/oN/WB3YwP/1C79QlnqgIlOZMvdb2a06lN
ulpd0RQA4GyGo5oZ1GlHnJhM5hbDv2ml8ZSskLm2muEgGY6i88Q0J9jrl0BDGU6Q
WAzHirpcMlnak2Yelt7UBgl9rE4PUBUvIno3+wklEdd0+BWZ8yVNtMdkNhBsn+oy
eimGaBqpaCb5kPfQWoDza7pOdpBf3471hr8hHXyHlZiCXS7pRs0MowVRXVFU4p9q
J6BBdLBdW3OcRqtyXiLJDkGLkufYAZwwemD1yMDNO8S4T56WZGN+OCqSEhq30oUD
cFNcwQA7z+RLphHuH/gVaxR050NvVoxzMiMezwyr39zbJX5AhrYf1cKDUPmzZgQj
166csVk/z2B5lPZuhPSwjBlwDYAYEZBk/cRwcEFWheUVOzENVyta5KUn/IpXrRB5
kLKk+EEh+U0hh04jJYZSZgz+YfA7b2wvROTxk2+Hor4Cql3xyMEQKMWpMsn/s4rM
WCgth1ERpCJIpRrAXE2LpWNqRmsCT7LoEMfuQQ38RXg49HHsBhzJpyEx+eaLpw8A
e5BUIEReIzekT3c/MnO20FhB2XDEt0B6PTPAJnxVEps6IDUJEkh4O1ol0y7UqKV+
i+WKX4IVWXEDOIZBHm7jz2D1+xSyIo7CJigIyf3gm+CRzRd0SYqPaoh7xA39bbXx
yu2tpLrMLFware4/zTq6
=k2iu
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
