Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:36304 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162AbcEKQj6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 May 2016 12:39:58 -0400
Date: Wed, 11 May 2016 12:39:56 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sassan Panahinejad <sassan@sassan.me.uk>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] libfdisk: Add support for altering GPT size
Message-ID: <20160511163956.GO26300@vapier.lan>
References: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1IYcr18XUmgwOrO2"
In-Reply-To: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--1IYcr18XUmgwOrO2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11 May 2016 15:54, Sassan Panahinejad wrote:
> This is useful in two situations:
>=20
> 1. More than 128 partitions are required. Or
>=20
> 2. The partition table must be restricted in size, such as when a system
> expects to find a bootloader at a location that would otherwise overlap t=
he
> partition table.
>=20
> The gdisk partitioner supports this feature.
>=20
> libfdisk is already capable of reading and writing partition tables of any
> size, but previously could only create ones of 128 entries and could not
> resize.
>=20
> This change should be fairly safe, as it has no effect unless explicitly
> activated.

i'm not super familiar with the codebase, but these look pretty nice.  than=
ks!

> +	fdisk_info(cxt, _("Partition table length changed from %u to %u."), old=
, new);

old & new are unsigned long, so you'll want %lu

> +int fdisk_set_disklabel_length(struct fdisk_context *cxt, unsigned long =
entries)
> +{
> +	if (!cxt || !cxt->label)
> +		return -EINVAL;
> +	if (!cxt->label->op->set_length)
> +		return -ENOSYS;
> +
> +	DBG(CXT, ul_debugobj(cxt, "setting %s label length", cxt->label->name));

want to include |entries| in the debug output too ?
-mike

--1IYcr18XUmgwOrO2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXM2BbAAoJEEFjO5/oN/WBe0wP/jJgc6dKLzjxE9Bb4HcAisXs
Ibet4h5Z3Fi+ZVJgY3+9C72jRreKuQ+hag9I3+Vc03lnmgW/flrioHRtWIZFF/n5
7O7BL0QCtLnNBJkW8b7pU+2eVAdX5zFjw9H3pv629yJI4wfeUcA7/3KyuVOnTdcW
eGULyjJTjrTtT2tMba2F2F0HRiUf769S9b32rRudLGf9enidCxUo69yY/egvkasy
87ijOinJwz4iwLR2j1ZGjwkTvNJA7HtY5ljHGVJdt+HNL4OlkCGQOeoNulu/HfkT
4n9Urq6PSyjJuQPziD3NEAfUdllRuAAm6NDVQr+rz3pS5vADtu1XgnXO/9n921TW
DAM+9RCKpCeXTsxVw+EB+OhsYud4TaYi6lwIfqCRP1xArlHx42h1Vs570BbmUtK4
1uxE0amKmnpLNWxS9/qJufLzZlcisxbf8YfnTnEPrOAdqUBS93OO6gZiK/ddhmh9
5cJg6pNSRKjVrTUrWxVv6NpkOu29gaxUbDpnnjKZnfiP4BsIVV5gNPQvy8ZjpgTZ
Nrhd2af9NYLckhXhRY3q8PbcZ6SBfrv5/X/yJbdbVYLAfzI9fFLg+iMcuJnO6Pxj
Yh/fO/ORTRyJyvY49Rj6nGXi/37MpXbZuLkIAfbkLe2ZnT8q6IckPugtgy76UOI0
rUzw5lmvLR+CfI1c5+N6
=ELNk
-----END PGP SIGNATURE-----

--1IYcr18XUmgwOrO2--
