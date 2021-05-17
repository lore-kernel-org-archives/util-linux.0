Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E3C43460
	for <util-linux@archiver.kernel.org>; Mon, 17 May 2021 15:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E946C60BBB
	for <util-linux@archiver.kernel.org>; Mon, 17 May 2021 15:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbhEQPBt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 May 2021 11:01:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:44168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242511AbhEQO7p (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 May 2021 10:59:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF24EACF6
        for <util-linux@vger.kernel.org>; Mon, 17 May 2021 14:58:27 +0000 (UTC)
Date:   Mon, 17 May 2021 16:58:25 +0200
From:   "Dr. Werner Fink" <werner@suse.de>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH] sulogin: ignore not existing console devices
Message-ID: <YKKEkSc/ryc56IJu@boole.suse.de>
Mail-Followup-To: util-linux@vger.kernel.org
References: <YJPK1JUPtKTuMJ1J@boole.suse.de>
 <20210510145111.x5ap5raymlfoewi5@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YMjZszw4p7eZbbMX"
Content-Disposition: inline
In-Reply-To: <20210510145111.x5ap5raymlfoewi5@ws.net.home>
X-GPG-Fingerprint: 1B06 BF5A 3829 90FB CBA2  75BE 50E9 0D55 1DC1 6B2E
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--YMjZszw4p7eZbbMX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021/05/10 16:51:11 +0200, Karel Zak wrote:
> On Thu, May 06, 2021 at 12:54:12PM +0200, Werner Fink wrote:
> >  login-utils/sulogin-consoles.h |  1 +
> >  login-utils/sulogin.c          | 97 ++++++++++++++++++++++++++++++++++=
+-------
> >  2 files changed, 82 insertions(+), 16 deletions(-)
>=20
> Seems good, but git does not like the patch from your e-mail:
>=20
>         Applying: sulogin: ignore not existing console devices
>         .git/rebase-apply/patch:49: space before tab in indent.
>                     con->flags |=3D CON_SERIAL;
>         error: patch failed: login-utils/sulogin.c:775
>         error: login-utils/sulogin.c: patch does not apply
>         Patch failed at 0001 sulogin: ignore not existing console devices

Thanks for spotting! ... looks like I've missed the a/b prefixes

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--YMjZszw4p7eZbbMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJgBAABCABKFiEEGwa/WjgpkPvLonW+UOkNVR3Bay4FAmCihI0sFIAAAAAAFQAO
cGthLWFkZHJlc3NAZ251cGcub3Jnd2VybmVyQHN1c2UuZGUACgkQUOkNVR3Bay4l
zA//fDGN0hY0bSO+eWuZjfSnKoPJkASvzqD6Wt1f07Ro6ecEtaiI/d9rmUx7Sa+e
68+u3AsEtNhoQwNVKxG5zHdjbmH/qtyrOrDuVILrqj4vtsi65gqROXhG2ay3K7F8
LqvxBiSbHcRGrXIBBTCkGSgoj7hGCErrjPFvpYlmI+yR+tyqbgEeJwTW0Z4Qwd0R
VRR8Qt3vYpnJ1nnrp4E0AyG3AmvGbf8uq/z11lbtLZ8eTtzXcsaSE+JvpvnNAlMJ
MNRcNh/D7X5fCOC9YRpb+NoMARHNOiKBk9dcw1GplfpgtVlIQn8b8EgyiPB5CH2P
ZkvU9jlhDNxe2R4JgtWdDz0mKXMCaqKwzV2N6go5DcC0w9wW9SdDJOuGtZb44X0V
ZWL0EFlSZB3WT4na2TpBmdXejhXb1e78UfP3KoQB7+MF+W5bhn4e8sAeqzAhIZY7
bMJ8zlIjhqwOdLCvw9NECvs7DW/dlnGlJolQpU1O3wnwb9IFQlfp2Y1C1uUfM/07
kh/swUxssScUhaxF7rQGsouDe1fjUAUUuLI9BpF3c/nJ+YHfSmDd30nZyIYwFmvs
6wwlbwOidK5RFRPw3m/In0SC0I+9vSmJiwIfBCzTRJf5ePOn3tBlV8VVx7zFD59v
ejwGZbjCfcm3v5peB73bhj7xV6YRt+UOrOsPoTuTeMOZOgE=
=q5EB
-----END PGP SIGNATURE-----

--YMjZszw4p7eZbbMX--
