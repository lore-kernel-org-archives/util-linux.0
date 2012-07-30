Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:48495 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217Ab2G3NtJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jul 2012 09:49:09 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: kerolasa@gmail.com
Subject: Re: 2.22-rc1 build fails if configured with --disable-static
Date: Mon, 30 Jul 2012 09:49:29 -0400
Cc: "util-linux" <util-linux@vger.kernel.org>
References: <20120727115523.GA22051@foxbat.suse.cz> <CAG27Bk2UuPG3++nU5dZzKjJgAiNRP0PEFhFLZ0QBSDDU=tXNMg@mail.gmail.com>
In-Reply-To: <CAG27Bk2UuPG3++nU5dZzKjJgAiNRP0PEFhFLZ0QBSDDU=tXNMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3110714.E7uzQaUlla";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201207300949.29940.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart3110714.E7uzQaUlla
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 30 July 2012 03:21:27 Sami Kerola wrote:
> On Fri, Jul 27, 2012 at 1:55 PM, Petr Uzel <petr.uzel@suse.cz> wrote:
> > I just encountered that 2.22-rc1 build fails if
> >=20
> > ./configure --disable-static
> > make
>=20
> > The error I'm getting is:
> [snip]
>=20
> > Anyone else getting this?
>=20
> Yes, this seems to happen on all systems.  I am not sure if my
> proposed fix is what is wanted.  Maybe there is a way to make
> tests to compile, but I do not how with the current set up;
> meaning tests mixed with lib code.

these tests shouldn't be built in the first place by `make all`

> --- a/libblkid/src/Makemodule.am
> +++ b/libblkid/src/Makemodule.am
>=20
> +if !BUILD_LIBRARY_TESTS
> +
>  noinst_PROGRAMS +=3D \
>  	test_blkid_cache \
>  	test_blkid_config \

these should be in check_PROGRAMS
=2Dmike

--nextPart3110714.E7uzQaUlla
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQFpDpAAoJEEFjO5/oN/WBs0AQAI7IyiI8yCILVMZuSr5Vlsvl
EPWXVqkxmgoRzMuLfBoYqXXC4zgs+YHGLBh2RRMBOP/Y2jk7NzLy7BbCTIGA39qF
CfJL7hXyc5XIl0BWTkG5HoxrHt1ii+cPX+dNAnnZ3/R3Or6mMqZIBZ0v/pCDdZro
4KLFtqXwJ7d+NXAAQMHcX2PGKgb/6+GkrLqwtsVh48w2R0MDtAfX8k+9egkDcHGF
SlSHCEwJJ63Mu5meZnIWLvqTISshjm0vTkLgflNL6ew4rs6roMIq6/koAIyxws1Y
cFMOCVBtvdcx0gSxdDYzPoXsmuLq/bJNaDoOCXI86uB5PfgC2kStu3bbsMthGs+i
oCUIDfPHzoZbV2scd/8ew1PWZ/u8uEgFFt+tG/6WHVPglW4xesbkyqJc/yFmjC37
uCegg8L8pscrZXssWCZVfe+93EN5/E5GtiIx64uZhI9IKhaaQo0DKmn9fLOT/DP1
vrRUVQUwtHYNEiHAbmSdHx9TLHJiF7MB4eHohBSZfou26w7y83GQskchprx9mXNo
dXtchOv6/q5USQpg5xYVx5+H1wsnXf3tQp72GnSTG8ZDW8nSa747C3jz27WIw9WW
CTA+QsSUWs0k3QhiObgPwocs9ykWtlqumWJVajaCKKx/Tbhia+WmiCQxvueoIEyO
fv83peHoHSadHJa/5lI5
=0A/c
-----END PGP SIGNATURE-----

--nextPart3110714.E7uzQaUlla--
