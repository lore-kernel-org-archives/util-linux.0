Return-Path: <SRS0=n9wB=6X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92D0C28CBC
	for <util-linux@archiver.kernel.org>; Sat,  9 May 2020 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EA7208E4
	for <util-linux@archiver.kernel.org>; Sat,  9 May 2020 19:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEITAX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 9 May 2020 15:00:23 -0400
Received: from luckmann.name ([213.239.213.133]:41583 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727995AbgEITAX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 9 May 2020 15:00:23 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E56034.000000005EB6FDC4.000072F7; Sat, 09 May 2020 21:00:20 +0200
Date:   Sat, 9 May 2020 21:00:20 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org,
        Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: Errors in man pages of util-linux
Message-ID: <20200509190020.GA28852@Debian-50-lenny-64-minimal>
References: <20200503191335.GB27970@Debian-50-lenny-64-minimal>
 <CALxWeYrDdow1y2oA1VkcCyiQH1Vm9jNN79o541FPRaHYom=pAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-29431-1589050820-0001-2"
Content-Disposition: inline
In-Reply-To: <CALxWeYrDdow1y2oA1VkcCyiQH1Vm9jNN79o541FPRaHYom=pAg@mail.gmail.com>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-29431-1589050820-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,
On Sat, May 09, 2020 at 08:53:31PM +0200, Michael Kerrisk wrote:
> Hello Helge ;-),
>=20
> I think no maintainer wants to deal with a 1000-line mail listing 100+
> minor bugs. May I suggest making the maintainer's life a little easier
> by breaking things up into pieces. For example, one mail per manual
> page (which would be 43 mails by my count).  But maybe Karel has
> another suggestion on how you could make his life easier.

Sure, I can do this, it did not see this mentioned for reporting bugs
in util-linux, hence I did not do so.

Will do so soon, probably tomorrow.

Greetings

          Helge
--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-29431-1589050820-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAl62/cEACgkQQbqlJmgq
5nDbrQ//S6onoq5mHlwVlk6zp3nQQ4YgYNOFNu1ZNs32uNyiI9LweZ5mCmYz/E6O
sIbS4DpvROI/BtNdb94l8AnnrTWksBDMpzfK7lRG6KE9X73FBm6cnDtqPYRoSMVg
of1xI3QEODC8Ua5HhEnkatw01TxrGAe9keKQgq4bno9elAvwl1uybfBn8jN3kHt0
ymSRNHT93MNLKA1H98xOm8WC/sfFcPVfiX6Qvl7EzmXqtMOQAJHX3HO90udp/2bN
OGgQSVsHf4i3+ABqSx9nwBJWdMq6IRyZ+Qf5N5t2TGpn5tylKo9I+4USAHenWHjq
i/ooEX6QmUuVK8DhfUR063hAg+mEr7RvB+YZ07wNw+F1q/BD8Khj+Abk3LQoXEPE
qtqoZpxn2bl+HNvvZkDrV2c9FbyoJF9SnKhtwxQmv5pnve479M6VinPsjmtwu8XM
1dGfZFQrQfelmD38wem0Cdg8HmFaW26F9+0fcLsrvaaU7iGyc+tN9uPG8PKCY/ou
7yxegr55jd2rMmShEYtzOerffaezfk6ZE91+d+5Udrpdy2vtHv0pA1mcDN4FxMYG
+iIh1QmN0IXaanPUS890+bjmdYJf2+wVV/lTgN8yZlchWiNxUiitSkjiH1Dr2Hb9
Q1VPiXNniJy+CArJvEfzvT3oZM5uHULlIgEwSMEffeoPS5hMPM0=
=s43p
-----END PGP SIGNATURE-----

--=_luckmann.name-29431-1589050820-0001-2--
