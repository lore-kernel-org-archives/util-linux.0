Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C3C433EF
	for <util-linux@archiver.kernel.org>; Tue, 14 Jun 2022 08:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354109AbiFNI5t (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiFNI5r (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jun 2022 04:57:47 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 01:57:45 PDT
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EEF25295
        for <util-linux@vger.kernel.org>; Tue, 14 Jun 2022 01:57:45 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id D9E195F8CB
        for <util-linux@vger.kernel.org>; Tue, 14 Jun 2022 10:52:08 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     util-linux@vger.kernel.org
Subject: bashcompletiondir should not be set or tested when --disable-bash-completion is given
Date:   Tue, 14 Jun 2022 10:52:02 +0200
Message-ID: <2832693.e9J7NaK4W3@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3174171.aeNJFYEL58"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--nextPart3174171.aeNJFYEL58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: util-linux@vger.kernel.org
Date: Tue, 14 Jun 2022 10:52:02 +0200
Message-ID: <2832693.e9J7NaK4W3@mobilepool36.emlix.com>
MIME-Version: 1.0

I tried building some util-linux libraries in a minimal chroot (no pkg-conf=
ig).=20
At the end it boils down to

=2E/configure --disable-bash-completion <other stuff>

The result of this was:

checking for ECONF... no
=2E/configure: line 37542: --exists: command not found
checking for a Python interpreter with version >=3D 2... none
[...]

        Bash completions:          ${datarootdir}/bash-completion/completio=
ns
        Systemd support:           no
[...]
 /bin/mkdir -p '/tmp/e2/root/opt/emlix/master/sbin'
 /bin/mkdir -p '/tmp/e2/root/opt/emlix/master/share/bash-completion/
completions'
 /bin/mkdir -p '/tmp/e2/root/opt/emlix/master/share/man/man1'

The problem with the "--exists" is this line (of course at a totally differ=
ent=20
line number in configure):

  if `$PKG_CONFIG --exists bash-completion`; then :

The PKG_CONFIG variable is empty and in contrast to most other places, the=
=20
other notable exceptions being the checks for tinfow, tinfo, and=20
libcryptsetup, the variable is not checked for being empty before usage. An=
d=20
at the end this should probably somehow depend on enable_bash_completion=3D=
yes=20
to avoid creating an empty directory as well.

Regards,

Eike
=2D-=20
Besuchen Sie uns auf der Embedded World 2022 in N=C3=BCrnberg!
=2D> 21.-23.06.2022 - Halle 4, Stand 336

Rolf Eike Beer, emlix GmbH, https://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart3174171.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYqhMMgAKCRCr5FH7Xu2t
/HtQA/9Nsr4c1x823zqjeYhLNWv2agbrZkSKjMMxEemu2F63ABFjnWfGNz/SWn8m
5lEe6Hkci9dasA1hRQrEMQtV/n3hl/raLENnJS4oqSeLj8DporPZbX8V4NSTRLFo
Z8R5g5u3VHbTKIaMrzlj/bIzmJCIfaLZoBd63ghCwIanDQqORg==
=wEEg
-----END PGP SIGNATURE-----

--nextPart3174171.aeNJFYEL58--



