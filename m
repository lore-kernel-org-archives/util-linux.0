Return-Path: <SRS0=6zyj=UA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90633C28CC1
	for <util-linux@archiver.kernel.org>; Sat,  1 Jun 2019 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ECF27709
	for <util-linux@archiver.kernel.org>; Sat,  1 Jun 2019 14:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfFAO1H (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 1 Jun 2019 10:27:07 -0400
Received: from vie01a-dmta-pe08-2.mx.upcmail.net ([84.116.36.21]:42869 "EHLO
        vie01a-dmta-pe08-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfFAO1H (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 1 Jun 2019 10:27:07 -0400
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.91)
        (envelope-from <petr.pisar@atlas.cz>)
        id 1hX4yN-000AZ4-Ho
        for util-linux@vger.kernel.org; Sat, 01 Jun 2019 16:27:03 +0200
Received: from router.bayer.uni.cx ([89.103.167.90])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id X4yNhPc3EEZz0X4yNhTweA; Sat, 01 Jun 2019 16:27:03 +0200
X-Env-Mailfrom: petr.pisar@atlas.cz
X-Env-Rcptto: util-linux@vger.kernel.org
X-SourceIP: 89.103.167.90
X-CNFS-Analysis: v=2.3 cv=E8KzWpVl c=1 sm=1 tr=0
 a=PynCJzRKXLGVNAqAubg0rQ==:117 a=PynCJzRKXLGVNAqAubg0rQ==:17
 a=xqWC_Br6kY4A:10 a=dq6fvYVFJ5YA:10 a=P2OqLuV84VS9NIzTtQwA:9
 a=QEXdDO2ut3YA:10 a=qNqKIOR8NvSVwejOrK8A:9 a=FfaGCDsud1wA:10
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2002:5967:a75a:1:5246:5dff:fe8e:a186])
        by router.bayer.uni.cx (Postfix) with SMTP id 278DAA00C1;
        Sat,  1 Jun 2019 16:27:02 +0200 (CEST)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Sat, 01 Jun 2019 16:27:02 +0200
Date:   Sat, 1 Jun 2019 16:27:02 +0200
From:   Petr Pisar <petr.pisar@atlas.cz>
To:     util-linux@vger.kernel.org
Cc:     Petr Pisar <petr.pisar@atlas.cz>
Subject: Mistakes in message strings
Message-ID: <20190601142701.GL3522@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CMAE-Envelope: MS4wfOr4nZ4X3XrzxW8ATy1FDPa8k4o8kBQQ97a5d22RijAaxaEdKHKcXpR3Yh3OSvhibOcfSjj0sDrz3uVccxfPLNimAlaUZVzJwLylw9+ww6mcmfyrN1+z
 elXAat0PWgGsw+2iJS1KiueVxzLEcF4nJ+TJsBMGfa9vjuDs2ZT7PU9Zl7mEH39C+aup9n0GAgtlPViL9FaPfUaS23gEEOZt/lIL5oM9kpnH1i27zfdOKaqa
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

while updating Czech translation for util-linux-2.34-rc2 I spotted these
issues in the message strings:

# FIXME: Remove a trailing period
#: login-utils/lslogins.c:1345
msgid ""
" -p, --pwd                display information related to login by password=
=2E\n"

# FIXME=E2=80=AF"user" should read "group"
#: sys-utils/setpriv.c:139
msgid " --rgid <gid|user>           set real gid\n"

# FIXME: Missing a comma between options
#: term-utils/agetty.c:2352
msgid " -J  --noclear              do not clear the screen before prompt\n"

# FIXME: Missing a comma between options
#: term-utils/agetty.c:2357
msgid " -N  --nonewline            do not print a newline before issue\n"

# FIXME: typo in "is possible", should be "if possible"
#: misc-utils/findmnt.c:1246
msgid "     --tree             enable tree format output is possible\n"


Moreover, I have difficulies in translating this message:

#: misc-utils/hardlink.c:363 text-utils/pg.c:1263
msgid "saved"

because each of the location requires a different translation in Czech
language ("stored" versus "spared"). Please either add a gettext context or,
better, duplicate the messages:

# First argument is "Would link" or "Linked".
#: misc-utils/hardlink.c:354
#, c-format
msgid " %s %s to %s\n"

into:

msgid " Would link %s to %s\n"
msgid " Linked %s to %s\n"

and duplicate this:

# First argument is "Would link" or "Linked".
# Second and third ones are file names.
# Fourth one is "would save" or "saved".
#: misc-utils/hardlink.c:360
#, c-format
msgid " %s %s to %s, %s %jd\n"

into:

msgid " Would link %s to %s, would save %jd\n"
msgid " Linked %s to %s, saved %jd\n"

I believe it will make the messages more undestandible and easier to
translate also in other languages.

-- Petr

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQRLUoOT5qOw37LvOmQSycXHZ8b6ogUCXPKLLwAKCRASycXHZ8b6
oicXAQCMqYliwTqvXpCWEPKYDIvSTHpsvGMiBR0si8+5bA9YjAD/c90w14nu71sm
fSGCOU+fhLkpZ0sJkP91f2l6zxYHits=
=kXn9
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
