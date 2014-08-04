Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:59127 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbaHDHbO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Aug 2014 03:31:14 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/7] zramctl: print all devices as a default action
Date: Mon, 04 Aug 2014 03:31:13 -0400
Message-ID: <1946062.6JF60ZCY1D@vapier>
In-Reply-To: <CAG27Bk2OosZoo=XAGy+2Ld-pxAbTzivhr=cXE4S8FJtVzPnwAA@mail.gmail.com>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi> <2423860.9OdLEsNW7s@vapier> <CAG27Bk2OosZoo=XAGy+2Ld-pxAbTzivhr=cXE4S8FJtVzPnwAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7109256.osYeTcygvq"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart7109256.osYeTcygvq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sun 03 Aug 2014 21:50:33 Sami Kerola wrote:
> On 3 August 2014 15:50, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Sun 03 Aug 2014 15:17:37 Sami Kerola wrote:
> >> -static int zram_used(struct zram *z)
> >> +static int zram_used(struct zram *z, int find_unused)
> >=20
> > s/int/bool/ ?
>=20
> There's only handful of boolean types in use in util-linux

i think there should be more.  i find them more readable, clearer inten=
t, and=20
harder to screw up.  whereas passing around 0/1 everywhere gets funky (=
and i=20
think the code looks funky already).

> util-linux> git grep -l 'bool '
> lib/mbsalign.c
> login-utils/su-common.c
> sys-utils/hwclock-cmos.c
> sys-utils/hwclock.c
> sys-utils/nsenter.c
> tests/ts/login/logindefs
>=20
> And question about bool is asked before.
>=20
> http://marc.info/?l=3Dutil-linux-ng&m=3D135817763904699&w=3D2

it's a little hard to tell if it was meant generally or that specific c=
ase. =20
but if Karel prefers they not be used, then the codebase should reflect=
 that.

> The question was never answered, but if I should guess the idea in
> util-linux is same as what Linus said should be done in kernel.
>=20
> https://lkml.org/lkml/2013/8/31/138
>=20
> Please read the whole thread. It's full of good stuff.

i'm not really seeing anything applicable to us.
=2Dmike
--nextPart7109256.osYeTcygvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJT3zbBAAoJEEFjO5/oN/WB43UQANm7u9EZgVERPUVdlpOCKwgG
ulxdQlWsBm4iyDHb7cyD7uAKF+mg4y6GQ6yTHVQHMy21uqtg7QRoVA8pH3bh4kv5
l+peCv49nLpIe1ezxDRXhbKtVaZXcWlikt7TCpT+eOa3adgnqEbe5QaOVeRrf/Uf
kfUOhmeFqOmshtH226pnZPnjyDcwSthUM2f7kboKcGtTP0KI+2SHnxe6fyyzR/+b
4s8OKJzg0YKti1PAdrIQVfjaNjLSMUV9qcV+LLgyu+4lzqTKpshgVIQf3peBTXaz
uurE3dnAFiEIVHjjjkx8UZ7TwkAMBVNUspwJBfQQMdC2xDtxXANOwlW8av2S1cEm
axkL2aTMPVlsHVrjwWl3UVNj1+N6UokQDJSSx4fn/Lm/s5SlpjoV9S+3izFBGCcx
kdM6DWQ1yvZeAUkL2jBZyZPQ36EAne7fOoqXMVioRoOTjj9JBNmQ/3xnu9cU59MT
d1FJHVIbUOB7n1W+d9jUdLMSxqD4NG5hmS5CcVZKfPZ4DKeHH7jUKSQOgiybS9N9
wW6zRrY12Z9y06nM++Fqo0eCGsABGtIZX75AesuU1y2wHVi2vBTnV4kDIKanFBxv
DQhtP3OmIZ3OGcvmPyrCYERGDic8hzJClU5K0eIFSDlqGyT0EfCzsxmj0sDCU8oC
ZhbueUQ8qxzlK2YgbDuO
=up6h
-----END PGP SIGNATURE-----

--nextPart7109256.osYeTcygvq--

