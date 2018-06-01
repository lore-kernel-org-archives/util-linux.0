Return-Path: util-linux-owner@vger.kernel.org
Received: from vmicros1.altlinux.org ([194.107.17.57]:46070 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFAN3b (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 1 Jun 2018 09:29:31 -0400
Date: Fri, 1 Jun 2018 16:29:30 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Karel Zak <kzak@redhat.com>
Cc: Alexey Gladkov <legion@altlinux.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: hardlink util -- files de-duplication
Message-ID: <20180601132930.GA5803@altlinux.org>
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 01:38:07PM +0200, Karel Zak wrote:
> For last 17 years in Red Hat based distros is available hardlink(1)
> util, man hardlink:
>=20
>    hardlink traverses one or more directories searching for duplicate
>    files.  When it finds duplicate files, it uses one of them as the
>    master.  It then removes all other duplicates and places a hardlink
>    for each one pointing to the master file.  This allows for
>    conservation of disk space where multiple directories on a single
>    filesystem contain many  dupli=E2=80=90 cate files.
>=20
>    ...
>=20
> the util is little bit orphaned, what about to add this util to
> util-linux to make it available for another distros and keep it
> maintained in serious way? ;-)
>=20
>    https://src.fedoraproject.org/cgit/rpms/hardlink.git/
>=20
> It's one .c file.
>=20
> Comments & objections?

Better late than never.

BTW, our hardlink package has some Owl patches applied,
please remind us to rebase and submit them. ;)


--=20
ldv

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbEUo6AAoJEAVFT+BVnCUIZ/0QALvZCx44c93mUVdI6UeUbzQ4
GDv9K2FY8i+ZF/Z0BTtHHVRnoMlMfLnfPA9pQDRmHvhRxRzHy0NUN08k2Bwae5WR
pbrpFA6JWWGBBFSmk7gA+M0LFbDFGA3f8MGHSBcPxYYLMVhZNn+dAs6Mr4KECGN+
jtJDNe78ViAQqb0Ej3X4lGwAKA4MXf3xi/r2veYfEZSLmxNYhxWknQj5jV2Gij72
C0qodKDL6AC21CRPps8xUBUS3MnpyRIqxYn2FIYSSiZLNYHafq4mXWPiYysYDvwh
17RvgBiBjYhNAa5WPUtCwyUJYSbZN6oKWft6GwmV2j00PKdDmaH8l4Sb1apx6rT9
XQYQqyrI2EZ/8QHQiVJbfKiZwp/MlVt+DUW841yxbLYOx5ynHBcHheFM/TiXpXEw
Kj+OwA/ulNjTiB+nrav2pM0jlOgBOXl7zb2xacjKVdHJoCZjes47K38g4IZ0a1X5
erXUaLcPYFe+x0wMFhKtPQGvZxXtCbkpcIWYecUGsNHc1UCjId5Wox5A5myIgxPN
JpBz8zozZsXJTBDdniIbJyhhFf0xj+yQY//PLZgpVr9c/E0Br94V7NarOl6JkPBb
LzutX81UsOWnvQu80EzFN/CT+Cd4ZgOnfsHjds1b2ZFOklZIwgTmGZ+8LNe/640z
fJCjQ+Wu07fpsdQfVBxv
=DwLI
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
