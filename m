Return-Path: ps@pks.im
Date: Sun, 25 Jun 2017 11:33:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Lutomirski <luto@kernel.org>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 5/5] setpriv: support modifying the set of ambient
 capabilities
Message-ID: <20170625093358.GB981@pks-xps>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
 <cover.1498312509.git.ps@pks.im>
 <cd10a8262a2accb0f3fdaf92aad8cdc488c5d3c7.1498312679.git.ps@pks.im>
 <CALCETrUe4-Tv=i7tAkdnKmEZtU76UA2vOWuBYmQsspobinjGpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
In-Reply-To: <CALCETrUe4-Tv=i7tAkdnKmEZtU76UA2vOWuBYmQsspobinjGpg@mail.gmail.com>
List-ID: <util-linux.vger.kernel.org>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 24, 2017 at 01:47:29PM -0700, Andy Lutomirski wrote:
> On Sat, Jun 24, 2017 at 7:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> > Right now, we do not support modifying the set of ambient capabilities,
> > which has been introduced quite recently with Linux 4.3. As libcap-ng
> > does not yet provide any ability to modify this set, we do have to roll
> > our own support via `prctl`, which is now easy to do due to the
> > indirections introduced in the preceding commits. We add a new command
> > line argument "--ambient-caps", which uses the same syntax as both
> > "--inh-caps" and "--bounding-set" to specify either adding or dropping
> > capabilities.
> >
> > This commit also adjusts documentation to mention the newly introduced
> > ability to modify the ambient capability set.
> >
>=20
> One question here: should requesting an ambient cap also implicitly
> put it in the inheritable set, at least if --inh-caps isn't specified?

Good question. By itself, it doesn't make any sense to have an
ambient capability without having it set in the inheratibale
capabilities, as otherwise the ambient capability wouldn't be
granted at all. This is due to the invariant (quoting from your
message at [1]):

    pA obeys the invariant that no bit can ever be set in pA if
    it is not set in both pP and pI. Dropping a bit from pP or pI
    drops that bit from pA. This ensures that existing programs
    that try to drop capabilities still do so, with a
    complication.

With pA being ambient capabilities, pP being the permitted
capabilities and pI being inheritable capabilities.

But given that you were being conservative here, we should
probably err on the conservative side, as well. Meaning we force
the user to be explicit and not automatically set the inheritable
capability.

[1]: https://lwn.net/Articles/636533/

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAllPg4YACgkQEXxntp6r
8SwvAhAAiLtv3IsjicjujW46wDyS8viBW0WtWq6bt2B2D4EfRt6cZs7E6TtaKXtD
PP92QRItRvgdXm5WhCAQftZ780Kun+AEsxsFj5XOiloR17fqnHv7ROEJ2DDv6As+
pqOXzdE16txwf4Yqkdj1tCsx+m3aXUKBhLz2aNsUB+VIhI9NNPrcbcN3KelqqVei
L3QdTTPfRYZNazQTubsuuyxysnnu03oNYUiBr8dSWBb4GHRsKNijU0JISFkYoFZd
HKc+WpW2UfTc5hjVYwKLN+toy1yxT0vvfgiZR0wki1u4JPXnS8SflO6BYws4cqeL
oIwEw8QLTs8Gdrkc/FO24X2zdT/8RGM8x4ZhdszSeGdbzsEWd8Ox1Kmaqq3s83kH
Lz6HylKHkSdn99MqUGOGxMmc9PdBzoVzN3HNutD+7i8q51hloJB1OF4ghPUE71/j
HwLBt/9zHt+x9hG/z/s52a1sgdxd979xqilOG+pf7a4qGbuSaOi9+QSYMZDs1Fa2
lKRCcHJQjlRdExR4e+09aZXpYjUCrKbGKUU33AVJ60g8hUu9fKbR3cuERRNymTjy
qlEQMdzYZYs0KqAFA4q83qPAPeNM7p2cpjFa9RevLDNo8fWw4G2QovDMna3DBfn1
CTZjfkfm26SZouNv5dL+m2Mgl46p4sQFsPCiWb+44pbYT9N/iHw=
=vRWM
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
