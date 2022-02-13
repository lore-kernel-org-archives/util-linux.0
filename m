Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709A2C433F5
	for <util-linux@archiver.kernel.org>; Sun, 13 Feb 2022 07:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiBMHzS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Feb 2022 02:55:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiBMHzR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Feb 2022 02:55:17 -0500
Received: from static.213-239-213-133.clients.your-server.de (luckmann.name [213.239.213.133])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 76B745E74F
        for <util-linux@vger.kernel.org>; Sat, 12 Feb 2022 23:55:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E54037.000000006208B95E.0000042C; Sun, 13 Feb 2022 08:55:10 +0100
Date:   Sun, 13 Feb 2022 08:55:10 +0100
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     util-linux@vger.kernel.org
Cc:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Errors in man pages of eject
Message-ID: <20220213075510.GA1041@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-1068-1644738910-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-1068-1644738910-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear eject maintainer,
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including eject) as
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
should use another channel, please let me know.

Man page: eject.1
Issue:    Markup of command names: eject =E2=86=92 B<eject>

"The option tells eject to not try to unmount other partitions on partition=
ed "
"devices. If another partition is still mounted, the program will not attem=
pt "
"to eject the media. It will attempt to unmount only the device or mountpoi=
nt "
"given on the command line."
msgstr ""
--
Man page: eject.1
Issue 1:  eject =E2=86=92 B<eject>
Issue 2:  than =E2=86=92 then

"The option tells eject to not try to unmount at all. If this option is not=
 "
"specified than B<eject> opens the device with B<O_EXCL> flag to be sure th=
at "
"the device is not used (since v2.35)."

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-1068-1644738910-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmIIuV0ACgkQQbqlJmgq
5nD18g//SCTxKINZ5nhAMbQjiDaSSsRz4nxpDGO9jd+GYZleDB4NaMlaJIE4SDw8
j/Xp1rQIvVjz/N/st/BVNyMHrIlJ/o2INfBWW1bPoZtS0z24AzEGTrBfXc79i8Uk
eq569x58WtFf6wdNwDN1wRT29Adf3S1/yAfGBSqnG8yZSORN4lNgF0G8h3crsGvO
JDbbGj7brW1ncGqbqgiC9YqYJq22OcnmFJp+kKUS1eMacAAQbxaZ5WmfRqdaf0SD
oyGJavIRa+dypfLHLyn3Ld/tvCNvYdlZHRdkUoYgY1IP0cVu83UDuSQB67qb6E7N
Act9GQJd6avQ9X8kp+IKGniv+qW3v1K8MhPUd+1QGl2IzMYr7KDUVA6ABZcdMlKl
71XPWMwO+36+31u/EJvREiOOJDa+9/C33HyjKfFMpOQIvBVNgQZKAIfxkkDi+9w4
8AvRPCwgvewy9JOF/x/jTOe0kwf9CVdXaw9G5Wbwi0wj1T43oGx9T8iYso10zBzJ
AIxuNMvTfP8eC0DrRfdrymtMYcpMXZyU5IHaDBU7qJaLdpOY/OQneFL/+HCw1JLk
8rg6FDU5H309dxgL9u8T94skjxr0hPRBEG8BT/zgQDFux1m/W8IExM4DvRiL/9R4
2/v779OhJ0od4B9srypiw5QW9p4vqcgoZFTh4VTsjerG4Qx4X0c=
=33SM
-----END PGP SIGNATURE-----

--=_luckmann.name-1068-1644738910-0001-2--
