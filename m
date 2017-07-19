Return-Path: ps@pks.im
Date: Wed, 19 Jul 2017 09:42:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: [PATCH] setpriv: support setting unnamed capabilities
Message-ID: <20170719074220.GA1186@pks-xps>
References: <4ae084e6a1c46726a24057c71d20787680fa3da1.1500326001.git.ps@pks.im>
 <2105c6b6-3574-be3c-3f2a-e951e6d8e61d@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
In-Reply-To: <2105c6b6-3574-be3c-3f2a-e951e6d8e61d@bernhard-voelker.de>
List-ID: <util-linux.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 08:18:55AM +0200, Bernhard Voelker wrote:
> On 07/17/2017 11:14 PM, Patrick Steinhardt wrote:
> > When setting capabilities, we accept human readable names like for
> > example `sys_rawio` or `net_admin`. To do so the translation between the
> > capability name and its in-kernel index, we rely on the function
> > `capng_name_to_capability`. When the function does not know the named
> > capability, it will return an error value and we abort setting the
> > capability.
> >=20
> > This relies upon the ability of libcap to know all capabilities inside
> > of the kernel. But actually, it is possible that new capabilities are
> > introduced inside of the Linux kernel which are not recognized yet by
> > the library. When dumping these unknown capabilities, libcap will simply
> > return a string like "cap_38", that is it will append the capability's
> > in-kernel index to the prefix "cap_". This may lead a user to also think
> > that "cap_38" may be passed to the switches "--inh-caps" or
> > "--ambient-caps", which is unfortunately not the case.
> >=20
> > We can do better here by instead accepting strings in the form of
> > "cap_N". To do so, we can simply rely on the fact that capability
> > indices are steadily increasing and that the highest index known to the
> > kernel is stored inside of the kernel's procfs, made readily available
> > by our function `real_cap_last_cap()`. So in case libcap does not know a
> > capability name, we can simply parse the string and, if it is in the
> > correct format, check whether the detected index is between 0 and the
> > highest capability index. If so, we can treat it as a valid capability
> > string and apply it.
>=20
> Thanks - would you mind to also add a sentence to the man page?
>=20
> Thanks & have a nice day,
> Berny

Sure, can do this. I'll send a follow-up patch tomorrow as the
patch has already been applied.

Patrick

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAllvDVwACgkQEXxntp6r
8SwE3A//VIw83ZDgShETO4neRGsJKlsb8zX53ShLl3jplHbj4ldm0lZs6yB2yvDo
Z4UY1cB18ynUV/dxf9svnLoTMpE7yZ4cnlC+3XpeMMawvnanFgfyj1a2fVSTDoZc
Mh/xrzU2/KHKoTqnFJ2ZjzgE8CyPhvXNRH1ZvqkIK2ccx/uZ9pbcTXhtld/Ljh0W
d1v8dX10rAVJuT/d49xPAb/6hpysvVa6kHi7whqmBtF3wGCOZeSbIQgUjy55iMqd
RjZtkml9MLlEuVycE1KKr1r8SX+qKRwmCOLlx3l1qXJT6bdy7W0/cS9e6VY0AnBK
9UNTzcE9E0SQx24p8yQTYZG0q3POzsdlVY0NXJ7UzcB0oWrb421qSvmgbgxctJrd
7UmubQ6T+2ucAkUIBCjk7YlTVbB9nxEo+8BtrXDzwa+/OmgYqmSqAdGpNQGYGLj/
OwCZmbSwgYJBJU+j7n32Yv4FkjuMOpBIKVXOKtFFiuIYTzwFrN0a3KHtsyZ7DJsu
49CZ7i3oe+Yox/EJ0BQoODVVV2By3t9KZp1mJeXS5Pz1eNh+rNO7H9EvjV+UnXea
01A19jCBLk6xjtuusHXbbjIglahhb3Tn3IVfH12wNtZoiUD1drvO+J+EE0lU2WwT
+RouAf8WKlYx4Yg6vFeOgybE06fUvUgDczPhfPfEB4wgFK3SrXY=
=4mMV
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
