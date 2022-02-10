Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFCDC433EF
	for <util-linux@archiver.kernel.org>; Thu, 10 Feb 2022 19:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbiBJT2q (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:28:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbiBJT2p (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Feb 2022 14:28:45 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 11:28:45 PST
Received: from static.213-239-213-133.clients.your-server.de (luckmann.name [213.239.213.133])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id B0B51D61
        for <util-linux@vger.kernel.org>; Thu, 10 Feb 2022 11:28:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E5409B.000000006205663D.00005C3A; Thu, 10 Feb 2022 20:23:41 +0100
Date:   Thu, 10 Feb 2022 20:23:41 +0100
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     util-linux@vger.kernel.org
Cc:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Errors in man pages of util-linux
Message-ID: <20220210192341.GA23576@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-23610-1644521021-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-23610-1644521021-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear util-linux maintainer,
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including util-linux) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometimes this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
the latest upstream version once in a while, so the error might be
already fixed. We apologize and ask you to close the issue immediately
if this should be the case, but given the huge volume of projects and
the very limited number of volunteers we are not able to double check
each and every issue.

Secondly we translators see the manpages in the neutral po format,
i.e. converted and harmonized, but not the original source (be it man,
groff, xml or other). So we cannot provide a true patch (where
possible), but only an approximation which you need to convert into
your source format.

Finally the issues I'm reporting have accumulated over time and are
not always discovered by me, so sometimes my description of the
problem my be a bit limited - do not hesitate to ask so we can clarify
them.

I'm now reporting the errors for your project. If future reports
should use another channel, please let me know.=20

I will send the issues in individual mails (like last time), without
this header. This will be a total of 84 mails.

I'll wait with sending for ~ 1 hour in case you would not like to have
them in those e-mails.


--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-23610-1644521021-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmIFZjcACgkQQbqlJmgq
5nBE3Q//ThzPZ4k4ROiX6kAjokaRhD2OBzFLR4N/bAEay8GC6eKjUmkrwTZCg24F
eQuGkMmZBzmc35rByFS5ogWEbWVt+IPbw6ftJhT7rJcX8puQE/vO2LJisFJ7gLtO
NM3VyIaWTwGe8LJUC6hkhRcT8l0LVEV/rvbQXLcDwoWLmBEhi74AxbJRPkHKNrv9
o00iVWDitBKwZp+Bn333jEzSwoIhNWeMHqBqhR67Dddnh4cWjLPvGJJitIPfQrKz
OBNyV5l/U5attlxKMHv0O6ZLXwGvk74j0DRY11aHZNGHc2lupXmJOci5sFsYyPj2
PVCA9ZRj4cU8OdllZqHsVZqu1U7yVVSrGQBu9Z1o4sMdcv1KZkXxPc2Sz6P8zLx4
/K4aWCkklQZwaTI3E8/zfqCIse9gAUYYff0OBqvOY11P1S60eFfcudrMmaTMhOWc
HNQ+FeO6rjTP61kJ/nTOizcJE2FTdbossg/zNYL/NVbOwnoimIvxQpf9zXKJooUF
yDFYxb+yQNNscbqnjg8zOzU0dDxFezQxmwVJSY8txs3BLoyxe04YhhAV4DFGDPiP
SvW/9qKNv9I5oPFAoHBZ77CzhygXW0fuGuUk5RidB6i9feaSsJpfsoQwjo7PZmlt
vJIbsd3d7kYJ8qCQaLV9HFic6a1y7I13lC4j62HcFxNaAFzyGMk=
=2z0V
-----END PGP SIGNATURE-----

--=_luckmann.name-23610-1644521021-0001-2--
