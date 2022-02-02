Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DCAC433F5
	for <util-linux@archiver.kernel.org>; Wed,  2 Feb 2022 14:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345106AbiBBOtr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:49:47 -0500
Received: from 139-28-40-42.artus.net.pl ([139.28.40.42]:42182 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S230320AbiBBOtm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 Feb 2022 09:49:42 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C1AA31C2;
        Wed,  2 Feb 2022 15:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1643813379;
        bh=YotHt4Fa+k3hQsfRe8RndqmHMaLItpfygO64O2G+EOM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=nVm9XFkT1rPfTZhF/SoxrauAw0vXarIql9K++QC5P94BhHIUg70PGtxPGOjN7NvYq
         8EEVSQ+72Zsd8Ep2RClloa7Tq7G2fPR2OjujFzzcWDpjW/BVCZMs5ajKOiUS7he5eI
         CVHSk1iorSwg/yMIFUGx7eitptBRd8ClwZ0rTiAWQQ6KciaX4/JOBIEovYuUVyPr2a
         QE/79bIcS5g7lEFhWqCdkxDbbUPF950IOFy/r1/xtp3xp4fu7n/7T1OuVSmopJPpRR
         28MiNqN3tJnQ57zhsOpp/lNgP5bSJ+bcu49i3B5Buu1VWJi1N4pcWcFdalIqC7gWgh
         bIRe0wvQ0we2Q==
Date:   Wed, 2 Feb 2022 15:49:38 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     1003095@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220202144938.eypexs65ujillsrg@tarta.nabijaczleweli.xyz>
Mail-Followup-To: 1003095@bugs.debian.org, util-linux@vger.kernel.org
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
 <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
 <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zeat7hiz7gsgdaby"
Content-Disposition: inline
In-Reply-To: <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--zeat7hiz7gsgdaby
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Bumping this patch after 2ish weeks :)

Best,

On Fri, Jan 14, 2022 at 12:28:12AM +0100, =D0=BD=D0=B0=D0=B1 wrote:
> Subject: Put master PTY into non-blocking mode and buffer its output
>  to avoid deadlock
>=20
> If we filled the script->child buffer before the child had a chance
> to read any input, we'd sleep forever in write_all(pty->master),
> and the child would sleep forever in write(1<pty->slave>)
>=20
> By putting the master PTY in non-blocking mode, we can
> poll(pty->master, POLLOUT) and keep supplying more data
> as the child reads from the buffer
>=20
> Fixes Debian bug #1003095

--zeat7hiz7gsgdaby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmH6mgAACgkQvP0LAY0m
WPEhjA/8CqJH7A7sSTm+3hC1+O1OATHFu8TObd+EJsv+EQvwuhakEoc2GJ4V1Fbe
UNhGm/ziyL9RePMKEYKXvZSvAxv5EzdyXhWVHodTflWW0yz2bNd/5aPerZgZC2PL
Wxs59f/XSyubu8FDQPXbRDvRuIPlb65unMOw8DBO752DleL92Z5Wpw2O4h9aKvGO
5gZeqhDkPPXAJ6X1tNREvzu7U1dvUdLH4YyN7puUbsvzYDDllkkWm2j0Z+Iq73Yd
PpR0WVdJwrdeef0G65DVdJPKOuy0QZDgd7kRIoqcnZHVr/YFwIMigKdmpUU4modI
WDC3nQWP5ZFkcavrzlQ8S+Z4z/CYIIe6CSMLCI7u7WoV4iHzt40SzmF54SliC6uC
vyFisF5HfgT6mZowdbEyfeot71ApozMgzTCK7WYci57BxG/5LF5NmPtziSjIo/0V
14Z2nWwYGhY6k3pg+VpAq0BS3HiGjkO+0Pg6uNrsU4E6Ii3ZttgInYEzZ3wTrW4x
Lg6oGbxP2KCt5JsKznt8q3aXtuaoourvXsFewJX0zUBzXQ7Lw1MvTUL3NBPNAWdl
Wh1QK2Eyv7xEkVnXmtAE2T99kWFqIM8U4lUfYP9uiliO8k8d1Kq9Vt7id8qyH64W
4fDUB2nNkX7qJXOrDHal95i5/+xFcGlbajpVRzJCcFfIhfPGiWk=
=hACr
-----END PGP SIGNATURE-----

--zeat7hiz7gsgdaby--
