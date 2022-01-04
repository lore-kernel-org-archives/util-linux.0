Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC2BC433F5
	for <util-linux@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiADRh3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:29 -0500
Received: from 139-28-40-42.artus.net.pl ([139.28.40.42]:46362 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S235864AbiADRhY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jan 2022 12:37:24 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 12:37:23 EST
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 93129137A;
        Tue,  4 Jan 2022 18:31:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1641317485;
        bh=l5o+R3QMTcZO9SgSQ8NASMmcv8DIIFI7iF+uYNKAPWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9sx/dJvU3MOw4qsajq87DdKhGED8F/5LtlF7dd1gCKWGFLeh/I3/5XQ44X5Ckh+u
         wjmB4TW3/f7TK13mB1tPYLANuU05SQRdUxj8Rb/fJrZrlNXNZDkZ8jfHA+lHmDlP8c
         CRcsG+6ZOgNyc8qQWL6N73utGK4m17U85PhMHoCODAE7mE9LlH87sn0Oe9oDOAKYKv
         4hvUDTZiEfBvsrDB1fLqU88oDY9OLCGOabFE8CLTMSj+LaGpSO0ZhO4aouz5EnXmZr
         f0R/OzT71z4kYxVdiko1apZflwmzTxcGj0L50Tiu8inS+Msc9O7qE3WD8Cce25+KQQ
         yoqxUqr2deisg==
Date:   Tue, 4 Jan 2022 18:31:24 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     1003095@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
Mail-Followup-To: Chris Hofstaedtler <zeha@debian.org>,
        1003095@bugs.debian.org, util-linux@vger.kernel.org
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrxhe6zl3klaeej5"
Content-Disposition: inline
In-Reply-To: <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--jrxhe6zl3klaeej5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Control: tags -1 + upstream

On Tue, Jan 04, 2022 at 05:24:54PM +0100, Chris Hofstaedtler wrote:
> * =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz> [220104 00:06]:
> > (This, at least, responds to ^\, but it also seems to function
> >  slightly differently. Also, this is a race and you're more
> >  likely to lose it under strace. The loopy thing seems
> >  like it's pretty good at hitting it 100% of the time.)
As an additional note, because it's a race, if you're using bash,
  script < some-photo.jpeg
also hangs, because setup takes long enough.

> 1) is this Debian-specific or already present upstream?
Debian doesn't patch script.c at all, so this is an upstream bug.

> 2) did this work with previous versions of util-linux?
The oldest one I fould from the site at Homepage: in d/control is
"util-linux-ng 2.13", dated 19.1.2012. It's much closer to the original
4.4BSD-Lite implementation and still forks twice. As expected, testing
reveals it does not have the bug.

Performing a simple manual bisect across the versions available therein
reveals that 2.25 is the first broken version. (Though, skimming the
source, with a slightly different code path (select(2)?), since it still
double-forks and is not so hard-stuck so as to be immune to ^\.)

The first version that does get hard-stuck (because it forks once
and only uses poll) is 2.27.

> Best,
> Chris
Best,
=D0=BD=D0=B0=D0=B1

--jrxhe6zl3klaeej5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmHUhGkACgkQvP0LAY0m
WPFC8g//dqy6CsVu1yEKdnyAHtYm8fHCIBi2ulZS+GoIJrc4szU3W3zcdC6suBy4
h7he7up7ifzv3V8BGRwT0BUT6bW3ZBBMw/+Qorb4qHml8f6fxIw0+g2ZEjjwHYYz
rwz2XPGgwTzKwovGr7RLh7eP/NuZ8UAw8snqS+1txmL2P1SWvdUppdk5F6P02DIz
iFWaONvXiz2DaYvFFVoD5SNnyUCoJIAbKDoed+ci7CXJQbwuL72lKcJVsPBYLeAH
WLWBNQzqIrb6hh1pMADTZZ8tslC6U3VREiA0Hy2k78cSSX2vlpYpWwe4LBo50lR8
5Y90SD/3V0E0pS8P/JYLdKR6KOZ24Ge7dnNHxTE9rzGmrbzXIiq8yhAOGOy/RICi
L321NMq4nCgKywqkNhcySxJVgBNE62yVGMtRthLVnvUm5MtHxLBlGQKbY14GJi2T
PaWfBM0uhGfvovmTYvsb4O4wf+8p7W6xO7p8LiRih8wTFlTmpMd+rHpuyFKW3e3c
2mTIu48yHJ0zJWP9FaWhYzhcp00iMfUkLfuZYwUdzJz9E3TblPwCmrBHXxoUi/tO
H0D/DOTtKButxlf8hZdoTVzcUS+scNCnwOFRgNwVVdoNDdnGM0ltDVqImTlkEYuW
sE/8xi5hDK2hU5Gr57HwQHkoqbbd8EytuZEB+Ylo0HdoWq5QCik=
=Szoo
-----END PGP SIGNATURE-----

--jrxhe6zl3klaeej5--
