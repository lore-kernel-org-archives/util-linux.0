Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A15DC433EF
	for <util-linux@archiver.kernel.org>; Sun, 13 Feb 2022 18:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiBMSvN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Feb 2022 13:51:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiBMSvN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Feb 2022 13:51:13 -0500
Received: from static.213-239-213-133.clients.your-server.de (luckmann.name [213.239.213.133])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id D9FCC580D8
        for <util-linux@vger.kernel.org>; Sun, 13 Feb 2022 10:51:06 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E54055.0000000062095318.00005B3B; Sun, 13 Feb 2022 19:51:04 +0100
Date:   Sun, 13 Feb 2022 19:51:04 +0100
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Errors in man pages of util-linux
Message-ID: <20220213185104.GA23259@Debian-50-lenny-64-minimal>
References: <20220210192341.GA23576@Debian-50-lenny-64-minimal>
 <20220210203542.GA25645@Debian-50-lenny-64-minimal>
 <CAHi0vA_7ZWjT=BY7Tc65N4sajBjkKd1LLbd1CmmYPWfgwWvg1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-23355-1644778264-0001-2"
Content-Disposition: inline
In-Reply-To: <CAHi0vA_7ZWjT=BY7Tc65N4sajBjkKd1LLbd1CmmYPWfgwWvg1A@mail.gmail.com>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-23355-1644778264-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mario,
On Sun, Feb 13, 2022 at 07:33:07PM +0100, Mario Bl=C3=A4ttermann wrote:
> Am Do., 10. Feb. 2022 um 21:35 Uhr schrieb Helge Kreutzmann
> <debian@helgefjell.de>:
> >
> > Hello all,
> > On Thu, Feb 10, 2022 at 08:23:41PM +0100, Helge Kreutzmann wrote:
> > > I will send the issues in individual mails (like last time), without
> > > this header. This will be a total of 84 mails.
> > >
> > > I'll wait with sending for ~ 1 hour in case you would not like to have
> > > them in those e-mails.
> >
> > Mario asked me to provide the issues, therefor I send them to him
> > directly for handling.
> >
>=20
> I've fixed most of the issues in my Github fork; see pull request
> #1601. However, there's something left (my comments are in brackets):

Thanks.

My 5 =C2=A2:

> --
> Man page: hwclock.8
> Issue:    date-time =E2=86=92 date time??
>=20
> "There are two types of date-time clocks:"
>=20
> (We have lots of occurences of this "date-time" thing. Don't know
> whether it's good English or bad English =E2=80=A6)

It's used quite a few times in the file, so better leave it as is to
be consistent.

> --
> Man page: lsmem.1
> Issue:    The first sentence is broken
>=20
> "The B<lsmem> command lists a new memory range always when the current me=
mory "
> "block distinguish from the previous block by some output column. This "
> "default behavior is possible to override by the B<--split> option (e.g.,=
 "
> "B<lsmem --split=3DZONES>). The special word \"none\" may be used to igno=
re all "
> "differences between memory blocks and to create as large as possible "
> "continuous ranges. The opposite semantic is B<--all> to list individual "
>=20
> (Not sure what this means. I can't remember anymore why I wrote this
> comment more than three years ago =E2=80=A6)

Sorry, the english is rather hard to read:
Suggested:
The command B<lsmem> always lists a new memory range when the current
memory block differs from the previous block in some output column.

Greetings

             Helge
--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-23355-1644778264-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmIJUxEACgkQQbqlJmgq
5nBOmg//aq8JQ8XR5ax19wDBY1E54JfpFe6g8+e4twK1utZEH6vP5kKy8FZERCm4
L3RCo6LdVVysYt4hnPv3z9mwsyfG+EfdPnPO03E4N7yA5OuI39mDi3NObGE/Wl4x
08naBemgGjBCbYlZZ3/CQnaoz0iVnmwNZ4EgFOAlfMNTT7f7fUkVnhVT81j2I0ti
d6qvShTiQKn3AYfSC6PBLAfTdgSiRfGUnyeJc5CTlinHRa/MHaMhl/j+lA9aXe8z
7XFJmSu0f1YI91dqKwg80IARGYgnDRZ9p12wlClkUiBxtQGhkTIuEt3knLuFhGvb
x2wYwg+FOb4AL9JkOmvIieNgxL1MrS2Rir3hmaDV9cQL6f+PvhPwOokbc3+iMlXi
zX2uwrBw+ypTkoeghrVzq01yMwnEIcg9UzDKxRUEAUXy7umJ0xynfIiBN5w09khj
JLXzGzdbnXWabNGNl5Pg4RklJBJ3eNxUAC5Uk+VZOOheB7Wd6dHOewUVt/WnmUIC
5470DQIpH0pQlXWCp3/NDOLCz5WETzOpG3NhDnWZ6xbRY9NlC/jtA6vESsyFgDuZ
A84SZ/PDlw3Ff1Zes8eSaitavgYoQNkHUwRi3gJiXyY0FR/g01ZaBd+GX1eNChUQ
AhxraVuZ2ZVWJLvVdDDKqcx8/5SXAciR480yB8YjFB1OiLkW4HA=
=eTL7
-----END PGP SIGNATURE-----

--=_luckmann.name-23355-1644778264-0001-2--
