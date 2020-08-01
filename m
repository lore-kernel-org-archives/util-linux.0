Return-Path: <SRS0=LFDe=BL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FACC433E0
	for <util-linux@archiver.kernel.org>; Sat,  1 Aug 2020 13:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9696120723
	for <util-linux@archiver.kernel.org>; Sat,  1 Aug 2020 13:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgHANzx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 1 Aug 2020 09:55:53 -0400
Received: from luckmann.name ([213.239.213.133]:36437 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbgHANzw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 1 Aug 2020 09:55:52 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Aug 2020 09:55:51 EDT
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E58059.000000005F257335.00006A10; Sat, 01 Aug 2020 15:50:45 +0200
Date:   Sat, 1 Aug 2020 15:50:44 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     util-linux@vger.kernel.org
Subject: Errors in eject man pages
Message-ID: <20200801135044.GA27105@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-27152-1596289845-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-27152-1596289845-0001-2
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
Issue: Missing markup for command names (B<>)

"The option tells eject to not try to unmount other partitions on partition=
ed "
"devices.  If another partition is still mounted, the program will not "
"attempt to eject the media.  It will attempt to unmount only the device or=
 "
"mountpoint given on the command line."

"The eject command is part of the util-linux package and is available from =
E<."
"UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> Linu=
x "
"Kernel Archive E<.UE .>"
--
Man page: eject.1
Issue 1: Missing markup for command names (B<>)
Issue 2: than =E2=86=92 then

"The option tells eject to not try to unmount at all.  If this option is no=
t "
"specified than B<eject> opens the device with O_EXCL flag to be sure that "
"the device is not used (since v2.35)."
--
Man page: volname.1
Issue: =C2=BBdevice-file=C2=AB =E2=86=92 =C2=BBdevice-file | iso-file=C2=AB

"volname [E<lt>device-fileE<gt>]"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-27152-1596289845-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAl8lcy4ACgkQQbqlJmgq
5nC++BAAlNLfjAh518YGZA6h+NTc14cjIPHQIDPq9jEzXEg1gLAwKv9xjF73AGRn
qAFidZ7lkDkdWCb6fwtnXbt9Oaf+DkFDzQGmyBgiYDMVcdDVm11i/BXwCPEg27ZG
9kbjpAEuGQvJr/qlL3GwM8114E5l7VjYmHhbc+q8j73sdENAcYta7YOi4WTRSr7+
4gjsdbe6+wvRREfhEtlFwU3Ka6wG12cFSr7lo/G+ebKwqTVJAv8weXXrJ071g9XJ
xCmd9Rc2Rf7w6IyUdHxeROldxlDrU23kCiuQrNBwtbjK/MfFlEdqjFjIHUaD6zTM
gCQbVVmyawbfweQqA0NzKuI/se2mnCa3Q0m4fNirqLZ+cnsE48YfvvNli4lLlL3A
2Rd8dwFV0ovXjeSm3PJ4VD660hgWYVBtPnNSbLqM8uT6U0bsxPVhUMC8sRm9vJXY
6ayynBDAx2wUXhVnwVeppK+Xn4AN1xUd/7q+F93x5Mud/MefGrL3roFlHhgDYHm2
XPYPb7OfSv4ZYiU+nvWlNZKUw1o7CCRcOLBlUfXJJmhm8H+bYcBrkhfXpWD2rFXq
8tBZpx6P7Dy5x/Vlmlthtbno+oXlNEBCX/i4cT/xLR+QalIQdOSYeW292sVWRNhU
1uspAk7hRRgQPwyAr6sMdEAmLtQ3zxgBINfqgTh2lXyx2kwKEYs=
=22gS
-----END PGP SIGNATURE-----

--=_luckmann.name-27152-1596289845-0001-2--
