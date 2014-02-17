Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:53437 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbaBQJNp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 04:13:45 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: last/last test fails
Date: Mon, 17 Feb 2014 04:13:45 -0500
Message-ID: <1772245.1xFz9501Eh@vapier>
In-Reply-To: <CAG27Bk3X8zv1oAvBG2hRX6U=SVY8CBtcmtp9ytyyA_Wjhmi4vw@mail.gmail.com>
References: <1496112.KWppGQQCcY@vapier> <CAG27Bk3X8zv1oAvBG2hRX6U=SVY8CBtcmtp9ytyyA_Wjhmi4vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3128719.HFMOfJSACl"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart3128719.HFMOfJSACl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday, February 17, 2014 09:05:56 Sami Kerola wrote:
> On 17 February 2014 08:39, Mike Frysinger <vapier@gentoo.org> wrote:
> > current git (24b2a479fd5ba138e9b836fa2115939eb3b59dfe) fails this t=
est for
> > me. see recent blkid test post for config.log.
>=20
> My bad, when the earlier last(1) change was sent tests were not fixed=

> in same go, or by in another change immediately afterwards. See below=

> for late delivery of the test fix.
>=20
> http://www.spinics.net/lists/util-linux-ng/msg08866.html

ah, figures i wait until just after a fix is posted to report ;).  it d=
oes fix=20
the issue for me.  thanks !
=2Dmike
--nextPart3128719.HFMOfJSACl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTAdLJAAoJEEFjO5/oN/WBWPYQAKdPrPUGyu7bksuXIgBD3Zd2
qRXbEk1NTvLGrznDQTBJOxXto+wEjZNk8TiVOzzoFZXc5+qxrUvRNpFKwb0x44L1
IPZQ7uRsjn5LebU51cZnkBwBrCKWqL3hKZPdf4QD3QSHzmRCbL/iNYVqDHJZvqqs
kCiulOzcZ2k3hhK78W0rwUP5IWpm+zI3bNngGU0YeBG74nF8MQVbs0wCMrUXYnKE
Ot9OnGY2DA4Z+ye4aPwrtbIx/pwRND4GI8hMFvpkE3yMusymkfFrzxySDI2wKB7l
O+cQq/G8UAnfGd0Ww3NTIA2fANrbHk3UI07+sjslh0RWeU1n4ZHzpGfoHxqkVdCy
zIy03MHMAUQqtdeNe/ZahJh052hVibLL2SfV0YQsN1Nu/99JsSnk0dIXuZagxuta
sLJyKGU6Vb6rTh12rgIKTlEJhPLJUD5B6c6wBbxGj+6vy6taVRNSfrhOEBHtlu18
5kcaQGjfDudy8fspinB/JpEP/gX9jEDe4QxoWRO1NiZ+WnQC2VBrImC1d5yQR1az
OTVlwMmHKE74+gjJAO1lCVVIHOxVZ2fMBk9xpzJ0IkKIaK5IlwQ74k8Ytr1vwqmo
oIUlLwCkFTUjelzKKgwzbEcHM2tduagzvPNwKJsQYRfbGx/rhbngXDYCXBQVHhYG
SMZYq+Za1D1Tu1oZvKnf
=GYx8
-----END PGP SIGNATURE-----

--nextPart3128719.HFMOfJSACl--

