Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46704C433EF
	for <util-linux@archiver.kernel.org>; Sat,  8 Jan 2022 14:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiAHOyM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 8 Jan 2022 09:54:12 -0500
Received: from 139-28-40-42.artus.net.pl ([139.28.40.42]:57416 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S229703AbiAHOyM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 8 Jan 2022 09:54:12 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EFF3A18F4;
        Sat,  8 Jan 2022 15:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1641653648;
        bh=eek8bppQlqDK4ip/7CDpRJc3uTo0BmEzhL7cdljVeso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7Rryw22MaK7yK6rEvZWaQzsT25EtIUDDtRxTyWehnGmJPLQIRMOMQjFRS1eSBDKI
         81Pgha3E6aknYFqepzCj1IvZzMKnjvuJy9BXAixXb9GQmWXfKPSicKpYVf4xVpHEWL
         Tz2e57K6B6wPKuJ65QJawa5XQxO9rftZkBf5V8RPxUSAEi0lslmiiM5rS6b6i/KkR+
         ApDU+T+vQFp8H7KGzsnOYleYBogcv7cpg8vN2ke57TorPe0pcSY5WsMoi9xz08gzFU
         7GKeAGe3ZFD4IJ4p5IvWmmXqfL4UriBdwzT1ulJ5/9dvbF8rIsTuc53833DGH8RvZi
         ZIHO0p7zGUCCw==
Date:   Sat, 8 Jan 2022 15:54:06 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     1003095@bugs.debian.org
Cc:     Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
Mail-Followup-To: 1003095@bugs.debian.org,
        Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4qitzd6cppbrssi6"
Content-Disposition: inline
In-Reply-To: <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--4qitzd6cppbrssi6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FTR: I've also reported this bug against FreeBSD, which uses a similar
model but with select(2):
  https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D260938

The proposed patch consists of requesting O_NONBLOCK on the master pty
and stashing the input received from the child into a buffer,
pending such a time that the write won't block:
  https://reviews.freebsd.org/D33789

This seems much easier to apply to the current single-process util-linux
model (which is to say: I've tried to cleave the current implementation
into two processes and failed miserably).

=D0=BD=D0=B0=D0=B1

--4qitzd6cppbrssi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmHZpYwACgkQvP0LAY0m
WPFlxA/9GuG4YTWL/ePaTagVCjddmAu2I6WOW0bDIbt0i/XsIbKL1vXMJdBZ0kC1
kX872hsVjemjLLAGZ06HPbuuPY7capZ/fGDV8nwo/QKh7cHWUNfU00D3zxKTjXeq
l/Sc0AxmEBdcQQTEwqZN15UC0GsvLXaKgPg2HuZTQHSZmvG9us+3PyVbRwYNr+hH
3OuFpmbZOqRhhXZYrLofdqrZYsiBnYyF6iz3Q5pous5bTvSRk+mT138CrWLr4Lin
ML8mse7ifWYubBjw5YV2Z6DecgUXvyPQT7UsNwE9+7Qm0m0VBzyNqQuWTMmwmhoN
K9XrgVsUeKBRBxmsNSEq7+KOVgodwKgr7IJytfreGyFM6XLHXB1b44prIcdVVHPg
TTc7voWEunneWAg3qvK+jLysdbewNXdnd0jcVNd3GpzwORVgkbZmosyJPNI76QKp
4fJUVYkPWY26Hff79iHnHTLAoK2Fn5fd69wyEMSsDrzUUqzTSQmnpKPPyHmiBw63
rRqMlA/cuLl5MfgR6qrtxZ7/NicNxqULMIb3ODr/sr/hObYb73CKl4hb/3ZpJMV8
VdKCtSU9L/OCaDLQXr1gQTC7sGvrotW39l+eA3C+xc/YlsPIQg7/wDg2+VqN/i0e
T1aug4xGYhG9IoHszLlrom0c29QFf2voFYBp0u34KjnNpfAf3+0=
=cEv9
-----END PGP SIGNATURE-----

--4qitzd6cppbrssi6--
