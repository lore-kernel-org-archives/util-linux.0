Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33721 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751058AbdFYJMC (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sun, 25 Jun 2017 05:12:02 -0400
Date: Sun, 25 Jun 2017 11:11:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Lutomirski <luto@kernel.org>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/5] Ambient capabilities for setpriv
Message-ID: <20170625091159.GA981@pks-xps>
References: <cover.1498312509.git.ps@pks.im>
 <CALCETrVGTZ=2Y+fOKONYZ8_nuvZC7HE2TUsJTH-beQHU7vLgJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
In-Reply-To: <CALCETrVGTZ=2Y+fOKONYZ8_nuvZC7HE2TUsJTH-beQHU7vLgJw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 24, 2017 at 01:43:10PM -0700, Andy Lutomirski wrote:
> On Sat, Jun 24, 2017 at 7:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> > Hi,
> >
> > this patch series implements support for ambient capabilities in
> > setpriv(1). Ambient capabilities have been implemented with Linux
> > 4.3 by Andy Lutomirski [1]. Quoting from capabilities(7):
> >
> >     This is a set of capabilities that are preserved across an
> >     execve(2) of a program that is not privileged.
> >
> > The patches are inspired and squarely based on published patches
> > for util-linux by Andy [2]. As these commits seem to never have
> > been upstreamed, I've contacted Andy a few days ago whether he
> > intends to do so in the near future, but got no response. Anyway,
> > as I would like to have ambient capabilities available in
> > setpriv, I took up the baton and wrote this patch series.
>=20
> Sorry, was swamped.  I very much appreciate your doing this.

No problem, and thanks for having a look!

Patrick

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAllPfl8ACgkQEXxntp6r
8SxCAw//VSLNtQHNVw2KlZCGfHo6NAjmvvbO5XHKUmcIbDIuiQz9CqoQlAmL5sth
oW21OQ1sWu0K4poeP583P51KfW0e5KUMHE7HZqEigEkYFTV3zk80vkAignKlZwvS
RMs9DsmArA5wyaeTSx5LsywtdhTLRRfSGFfCtoZXuSWWIABHZXD9278x+fYEDbL2
dR4enSu+0rhktjdqlUPrcT269kxHndjh76upMbzsrf9nrzj3et08os8zkc79AmAH
HoFarLxHqvf9HE5CECCO0gNlTnGYGfnkGBrN6gu/MSApeZg9E6wp6CDObHPh0Ni6
moxhK/7xvR7OmDMrbKQRl1pg9OJ7XMFgvDcVF/VLmpk5aHicmtkAsr6NTToMpI0J
BaaEdVl7kq0OK4dTYSMylOp6hpZZ/6Vc4pV+msZlukrpDjR/+iekFZMq2P6SbWYo
A1QzSXEU/8/c4QZNbABeeuxUc8po8r15g33MlsHPMciuInHmi3WoxMkDVmlX2PaH
doXHZBxGPOt+tRIeFFsWXnbiKNL8znwqipfoPY1U47xxWCQbsA72wLLbqhp2osQS
LjWfnI3ieL/CKkPu2vYQWaqPQLj8lGq/cRqNg8l+eUKbIGavUB2c4nzFgLnftZtR
abLi04JqXf17GqIE0WfrQ6Xn20Trb/1JOPsMSf+FXqpGGAaD+7w=
=RBXa
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
