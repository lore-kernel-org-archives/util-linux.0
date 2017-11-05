Return-Path: util-linux-owner@vger.kernel.org
Received: from 0540907c.skybroadband.com ([5.64.144.124]:53454 "EHLO
        stikonas.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbdKEOTI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 5 Nov 2017 09:19:08 -0500
From: Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Date: Sun, 05 Nov 2017 14:12:35 +0000
Message-ID: <2517688.kz9hnKgsx2@laptop>
In-Reply-To: <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
References: <20171004153332.GA6696@pali> <20171105133929.7cscboxymmpkw634@pali> <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart71900782.N2AJpBRV9M"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart71900782.N2AJpBRV9M
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi,

Well, KDE Partition Manager uses dosfstools but I can always
release a new version once updated dosfstools is released.

Best,
Andrius

2017 m. lapkri=C4=8Dio 5 d., sekmadienis 13:56:53 GMT Andy Shevchenko ra=C5=
=A1=C4=97:
> On Sun, Nov 5, 2017 at 3:39 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> > On Tuesday 31 October 2017 10:35:48 Andy Shevchenko wrote:
> >> On Mon, Oct 16, 2017 at 4:12 AM, Andreas Bombe <aeb@debian.org> wrote:
> >> > On Thu, Oct 12, 2017 at 10:49:31PM +0200, Pali Roh=C3=A1r wrote:
> >> >> On Thursday 12 October 2017 12:13:11 Karel Zak wrote:
>=20
> >> > I was worried that there might be some scripts or programs that expe=
ct
> >>
> >> If we really care about such scripts another approach might be to
> >> introduce a CLI switch to "spec compatible mode" to each tool and
> >> suggest in documentation to use it.
> >>
> >> There are also variants:
> >> - spec compatible
> >> - WinXX compatible
> >> - DOS compatible
> >> - etc
> >
> > I did tests with MS-DOS and Windows versions (results in previous
> > email), and they seems to be compatible how they read label.
> >
> > Based on results I would suggest to ignore label from the boot sector
> > when reading label.
>=20
> So, for tools which are not doing that to add
>=20
>  --ignore-boot-sector-label (or alike) [recommended]
>=20
> right?
>=20
> We don't actually know how many users (scripts) are relying on current
> behaviour.
> If there are only few, we may introduce backward compatibility switch
>=20
> --read-boot-sector-label
>=20
> > This makes behavior consistent with older MS-DOS
> > systems and also all Windows systems. This change would be a problem
> > only for users who have label stored only in boot sector. After change
> > they would not see label anymore -- exactly same what MS-DOS or Windows
> > show them. Seems that mkdosfs stores label to both location, since
> > support for label was introduced. So different label would be visible
> > only for users who used dosfslabel prior to version 3.0.16.
> >
> > What do you think?
>=20
> So, in summary it looks like a documentation needs update (to mark
> your research).
>=20
>=20


=2D-=20
I encourage the use of end to end email encryption

GPG key:   https://stikonas.eu/andrius.asc
=46ingerprint:  1EE5 A320 5904 BAA2 B88C 0A9D 24FD 3194 0095 C0E1

--nextPart71900782.N2AJpBRV9M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEA7vyw/TikxvaXjKoyGEVyAkXkuwFAln/HFMACgkQyGEVyAkX
kuw/8BAAqwn3sr72+TF6CjLdINrYbJAEQXOETfp6kaEUo2PI6S7bIXKCf6pqSh+L
CS66obsuu/dofaYggdwRq0cnUF75I5N9Q2VnG8scGmzrOnIiNadNG2PLR0h373tL
Z55fTXX9YXsEYZbSsc6hkk2mdyxQiA6B0VxZ4zshEbUZ91I4fSz0KRV9TObBG5sb
gkTM44bVPf8MbiBFsZOF6v3CfNo8cKeJKY6sS7z0B7FiFdCcI3hWaKRermizOCj5
s7zppsSYFJtZbEFRZ8kWHzAQKHnt3pE9/vAkHeBTQi/zpOmrN/WsKM/zlYvwC5Vw
x9l7KdOgbIHFhMh4YTJdFfvVbFRPi+cHIuvSZ+L9deP/cawfHHgQxJngHqxNCZw6
bePDDlTNhUt15j1EDo4kTAmQyL06FqyDf6jji9D64ISBWqhgorn/vUlEu3VVPYg1
sGhbHfQS0X9t7ld6gqmXvYgp/h4mHDg7Lmr9wz0j2E6TkhoCTiG0I+9Dx83uPX/N
JznCEX1kk32XuRBx6qBRu/AGiPTQkzgOaK1N5NORDLuehmi8SjNEsW7Pj7dUrwcK
fA476Sl8AP5NrJcUANcBTGv9hfB2p7q5jcgbfO5+80jAzFkr/RDXXHwDfbpXpnie
wsA80NpF8OmTspZ/NOQ6mpHejiLO8bixVBbC8SE4db5KCSNND+Q=
=eVN1
-----END PGP SIGNATURE-----

--nextPart71900782.N2AJpBRV9M--

