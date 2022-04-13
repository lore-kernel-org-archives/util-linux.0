Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C61C433FE
	for <util-linux@archiver.kernel.org>; Wed, 13 Apr 2022 13:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiDMNUx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 13 Apr 2022 09:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiDMNUv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 13 Apr 2022 09:20:51 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D20503CA77
        for <util-linux@vger.kernel.org>; Wed, 13 Apr 2022 06:18:24 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7980968E;
        Wed, 13 Apr 2022 15:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1649855902;
        bh=psLReNLwQwul8On2IqdjLwu9qdMFcIx55BoOPR75isE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ou3VaJV/9RxHtajzuZdYVjjzrQsyIxpxVlW8ZQxRmNq/m/ypnTwIzRsSMrT25+j6m
         dOXkuA0MwPToU8kO1dceUnqC6TLNnLODBt19JCmATPYXJo3N1pT29A0+PdTPslrezw
         MZdzljytFLvcxQ08DWeTM14MC7QvTyH2ljyJsUMGcbuILFjLZLIPKUE7Am6PGl303J
         jkV/q7C6nHcx9eLjjPFmjyfoUsWzkfi6tEgdH1HFspl5jptbdkoU/Wwffbmt+pH27c
         uG5Dz0jTMTr0TPz7OnV1fQpKSniWEH6cn5a9k0dZnMSGEvkw0Yn3xQ/9RmTEkDWq+z
         ywZzz38ae5jcw==
Date:   Wed, 13 Apr 2022 15:18:21 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC v2] libmount: accept X-mount.{owner,group,mode}=
Message-ID: <20220413131821.cep2jba4cn5n6uvp@tarta.nabijaczleweli.xyz>
References: <20220406113814.twdo4mwkevwuayht@ws.net.home>
 <20220407183913.kvchb7hbrfhyxjoc@tarta.nabijaczleweli.xyz>
 <20220413081234.65rtnj56qocowifz@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="63c5xhrli6ci5hlk"
Content-Disposition: inline
In-Reply-To: <20220413081234.65rtnj56qocowifz@ws.net.home>
User-Agent: NeoMutt/20220408
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--63c5xhrli6ci5hlk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2022 at 10:12:34AM +0200, Karel Zak wrote:
> BTW, we have discussion about IDs mapping for filesystems at=20
> https://github.com/util-linux/util-linux/issues/1652
>=20
> The idea is based on user namespaces. Please, see the discussion,
> maybe it's something what could be attractive for your use-case too.

AFAICT, and as Christian points out, they're entirely unrelated,
and idmapping would /not/ be fit for purpose in the zram-generator
use-case I'm trying to solve (setting the root to 1777, at the very
least; you /could/, I think, finaggle the chown/chmod stuff with idmap
but I'd have a hard time recommending it and I'd expect it to be full of
footguns a simple chown/chmod avoids, and the ergonomics are better).

Best,
=D0=BD=D0=B0=D0=B1

--63c5xhrli6ci5hlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJWzZoACgkQvP0LAY0m
WPHRrA/9EUod2t3janQuO9jIc1mk6WD+DVjCC8vUZHQ+yvl6Xey5v2bYcnyTPkqQ
dPaX2IXrJDrGt+bC8ltbZLBzZENvZfPGkzeCiE64SQ4GQHYhoixRMzyJbDtqqXjI
ypceZoCPY5CZFHW86pg3MkqSkYCI8MB2FdEs902Bqch4xKcx2YoAqPb6w64m7q7v
Y8EdFp2iiSCZdib9+YqC/SMqgegyTPDCpAL/na4YLP0wtrsd798JC6/ch+W+HF1s
PbNmZLl30lRqT7pXXl6d1sC/yBYieDzVELiKa+WP1yLj7IjzSrtlrp1l6VEATqor
k4ck5mEX+f8R6mKrpQbMjo5z7v0cZIoqynEghDJynZDyv6JxYyrzA9gVChtm3iKM
9RO1YyX3jhXGjGvTWvURah73nKp7S2XcO/ZFK6gA9M2T/qddo2AhL5ael8zWgi18
/EtMea4adhYwDzvh9AGhy2xDahK0qyEW/gPPwkw9W+46WEgjGAnILEczYLKM4tUI
8RdIMU53FZCbNwoSIq9A/mxtX3qNd47Y+VYKIVX+6hMILuBZGEBSoDfrEDnC1C5V
sHuZWq8Sj4Glgb3Ag2KfucYL74JBLGOuepLUh9S8ekyRraMoA1MsXbynWpc4/QhC
GcKkiwaMd+zoev22eljGAmw1EIErWpmYrk5Lzz5Ya+/JWpUqZME=
=DL0i
-----END PGP SIGNATURE-----

--63c5xhrli6ci5hlk--
