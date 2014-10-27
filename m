Return-Path: vapier@gentoo.org
Date: Mon, 27 Oct 2014 16:16:25 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, gabeblack@chromium.org,
        gwendal@chromium.org
Subject: Re: losetup on a image file containing (GPT) partition doesn't
 create partition devices
Message-ID: <20141027201625.GA25833@vapier>
References: <542E7000.3040309@gmail.com>
 <201410031429.s93ET4wu014728@hobgoblin.ariadne.com>
 <201410031958.s93JwTuY026155@hobgoblin.ariadne.com>
 <542F065C.2080505@gmail.com>
 <54304C03.6020309@gmail.com>
 <201410061547.s96Fl0sN021617@hobgoblin.ariadne.com>
 <5432BBB0.30701@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
In-Reply-To: <5432BBB0.30701@gmail.com>
List-ID: <util-linux.vger.kernel.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06 Oct 2014 17:56, Francis Moreau wrote:
> On 10/06/2014 05:47 PM, Dale R. Worley wrote:
> > From: Francis Moreau <francis.moro@gmail.com>
> >> Ok, so IMHO I think that losetup(8) should issue its own
> >> ioctl(BLKRRPART) and shouldn't rely on the kernel during the loop setup
> >> since it can fail silently. This way it can check the return value of
> >> ioctl() and moght choose to do it again in case the return value is -E=
BUSY.
>=20
> Hm I was probably not clear, let me phase it again:
>=20
> Ok, so IMHO I think that losetup(8) should issue its own
> ioctl(BLKRRPART) and shouldn't rely on the kernel during the loop setup
> since the kernel can fail silently. Using ioctl(BLKRRPART) allows
> losetup(8) to check the return value of ioctl() and might choose to do
> it again in case the return value is -EBUSY.

we've been tracking the same bug in Chromium OS:
  http://crbug.com/411693
basically, under load, using `losetup -P` randomly fails to create the rele=
vant=20
partition nodes.  atm we have hacks in place to call `blockdev --rereadpt` =
when=20
it looks like the kernel has failed us.

it would be nice if the kernel didn't ignore the result of the ioctl thus=
=20
allowing all errors to go unnoticed.  you can see this in drivers/block/loo=
p.c=20
where it calls ioctl_by_bdev multiple times and doesn't check the return va=
lue.

since all current kernels are broken though, and might be for the foreseeab=
le=20
future, having losetup issue the ioctl itself might be a good tradeoff.  i=
=20
think it'd trigger unnecessary overhead (rescanning the device after it alr=
eady=20
worked), but seems better than having losetup try and check other sources (=
like=20
if arbitrary partition nodes were created).
-mike

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUTqgYAAoJEEFjO5/oN/WBXY8P/RiRemTb7lmurITMlt0V9oD2
0TjNfQ/fltrP+Jg6toWbzx4BwrlosylkHu9V9pGci0WfkWasJCHMe0U3TtnzwMae
RatsQz4+IP55B+4F0T0YmfwhaAnpHz0O75rerUzh6OlZ1Bmugrc5KBaZVbwUFdna
KZbrf0ByM8YA67s8jSSY8KbEbfySZCriVysmh/8Ana4lntiZWW6R4W3vBts2/kU8
LXw5EZQqamknoMW/o3MOw8wJ+Dl6OsJtoe+PeJKhC9chVklc4IGbxz5G0w1FMBnP
iSiMSu1azCV/uuzg35MeeEwaKHUeCls1G7Fzv5VETBiUPqLSp++LB3DHyVOpIPTD
/KzwHk7r0DjtHwBec5T5x7CF+8G4jYTuakMFmlqiJAgyKuzLubEXVKh9CE8O72W5
JwK/wfI8WKIKc50nQOlDzbK+aTfpYIaiFXy+OPzl43wVOA4NoTJpHozvLVtLIH6h
lA7m9PILW/sAnjPgmjgg2XnTZUcvT/5yT9l4bDNik1hGzFnU875dEF9ROdPVtevG
AJxAwKibQ6QTEtgUMTfCUjXALPCmC5NV9jXCJ4fpK7FoaBsEXSxsCNYlb0FZwMNs
wGuGMybJZrg/79aXR5h3bnHydpKlCVZ6d/ovS9AI4ArnHrBRlzGTpmS0E3gXs6yM
w6m8QvPuwwmXk70K8f77
=ntnA
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
