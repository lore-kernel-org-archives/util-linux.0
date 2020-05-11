Return-Path: <SRS0=QCn3=6Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C67C47255
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 09:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41A8206F9
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgEKJvA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 May 2020 05:51:00 -0400
Received: from luckmann.name ([213.239.213.133]:45705 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbgEKJvA (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 11 May 2020 05:51:00 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E56022.000000005EB91FFF.000041A9; Mon, 11 May 2020 11:50:55 +0200
Date:   Mon, 11 May 2020 11:50:55 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        util-linux@vger.kernel.org,
        Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Re: Errors in man pages of util-linux
Message-ID: <20200511095055.GA16591@Debian-50-lenny-64-minimal>
References: <20200503191335.GB27970@Debian-50-lenny-64-minimal>
 <CALxWeYrDdow1y2oA1VkcCyiQH1Vm9jNN79o541FPRaHYom=pAg@mail.gmail.com>
 <20200509190020.GA28852@Debian-50-lenny-64-minimal>
 <CALxWeYpxvs+fcXzbExJ0n5ebeFtBdzm53ucPndW475CKe2KR0Q@mail.gmail.com>
 <20200511092734.6izjgahtz37iya6v@ws.net.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-16809-1589190655-0001-2"
Content-Disposition: inline
In-Reply-To: <20200511092734.6izjgahtz37iya6v@ws.net.home>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-16809-1589190655-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Karel,
On Mon, May 11, 2020 at 11:27:34AM +0200, Karel Zak wrote:
> On Sat, May 09, 2020 at 09:05:50PM +0200, Michael Kerrisk wrote:
> > On Sat, May 9, 2020 at 9:00 PM Helge Kreutzmann <debian@helgefjell.de> =
wrote:
> > > On Sat, May 09, 2020 at 08:53:31PM +0200, Michael Kerrisk wrote:
> > > > Hello Helge ;-),
>=20
> Thanks for your report Helge.
>=20
> > > > I think no maintainer wants to deal with a 1000-line mail listing 1=
00+
> > > > minor bugs. May I suggest making the maintainer's life a little eas=
ier
> > > > by breaking things up into pieces. For example, one mail per manual
> > > > page (which would be 43 mails by my count).  But maybe Karel has
> > > > another suggestion on how you could make his life easier.
>=20
> Well, that's simple, send patches ;-)))
>=20
> > > Sure, I can do this, it did not see this mentioned for reporting bugs
> > > in util-linux, hence I did not do so.
> > >
> > > Will do so soon, probably tomorrow.
>=20
> I think Michael is right. If we will split it then more volunteers can=20
> work on it and it will be more easy to maintain all the task.

Right, will do so, but due to other commitments it might take a few
days (hopefully faster).

Also Mario has send me privately some suggestions for fixing which I
will integrate.

> > Maybe hold off for a day or three before investing effort on this.
> > Karel may have a better idea than mine re his preferred method of
> > reporting.
>=20
> I have no another idea (maybe github issue(s), but it will be invisible
> for many contributors).

I personally prefer a mail interface and not yet another account, so
I'll send the issues the the recipients of this e-mail soon.

Greetings

          Helge
--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-16809-1589190655-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAl65H/kACgkQQbqlJmgq
5nAECw//WPDtKXZ2h7MR5fkNHlmRwgWgcZaAZMJnLaLicizRqr9aISHf06/7MgNf
bL5v1XBgKnlIc6Eb2/jMh1eaPTiW81Ihz0c8JM3pFSQtEcjvnOL/TQK7QojK+RVm
pcOKWdQv/aEzQqi8gJkOBAvVcHits3lnpXRPB8/AKiwHLHIXa1zwIIrJ5jR+Rkxo
si7xcsxrY3dHtVu7/tYOI219EkrvanrijFPP8io4qNHFIF4khchT4clSWXgRFtZh
lFcrsRTiKqyU1F59PjjIw918efohdb10JDGQGYe+qK2UjKLZC3s+b7Ya/sicEged
ScL4sUmDtLbNhd7Nc9NdTlhIKvnyVvzVzxoA1PhVZfI7hWK1Q5p6/Fl62KsiQO1F
eVvUvwolBJ+XsGiJfvEshsunZO9C+hJiUJDxn0x/CvfpAlWnDuAlib8aNZE8NHR9
ZW3Fwyxcisy4Bzbvo7BEe7vhAIF4mR+oZvW8W33tt91UEkbBGVMJiySHtDeA2q4u
phhDV/zLxXNSyXxsDLF+8Z2zSXvkl04CY0HB2oQ00hcx+/W1sb/gdqsMJOGXHTvm
d7/+2Rkh7JK7KKOaH0s4bZ8XVk5qhUIKGvVq1MzySqKGEond1iyBn4Nmr02RXWqX
BJeNKgN9JorC2fqykuV3ylTNg5HilMjOrNb8tXkeAm8se7gVdSU=
=h9RL
-----END PGP SIGNATURE-----

--=_luckmann.name-16809-1589190655-0001-2--
