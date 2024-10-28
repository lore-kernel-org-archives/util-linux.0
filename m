Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E91DF98B
	for <util-linux@vger.kernel.org>; Mon, 28 Oct 2024 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139580; cv=none; b=pMFgi01PFHSarKdr9xejXNcGZk8TIcwXXBDvJgiVU5ZqN6cUiM9vEmoCCrkUBwbcNC2OjD3egf71fPbT62SBEgnD3Cj/VeNmFRWEzr7DBDH8IB7n7pW+ueF/pnJUHBEMSKwPZnwjyz6OgrGNt9iugPLzNiN0k1Ew1fdKy3oOaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139580; c=relaxed/simple;
	bh=CzSpf4zFK81G+eyT/qCWMevRzXcWrnLQxt43i/wrUOY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/4xAvFAWbARWt807poC/K36Ii/40TxrU+ahxL6YwSQyabAJorSlnseUWFYkKeCK+1iHPODgnRke5y60f33LLCa5eAZZNDvK391F96e+euhJi+F+630blIc7ilLoFXJ/cW3Fx8X0ahNZYYFUNsVkog7FxV2KblNuUm6wleyN8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=TtjaHZbg; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="TtjaHZbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1730139574;
	bh=CzSpf4zFK81G+eyT/qCWMevRzXcWrnLQxt43i/wrUOY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=TtjaHZbgzG/ldP5o3EKDXNdA7GPk/I6e2r3W5um2hJZwfr8V36fhvB0io0kIu1Wvk
	 o/fDsf1IEJ2BWOjC2t7gQRq0Or7KyFq9DzEcrVVgdn8Mcx3Bh4lzuBGVlxy8wFMy0G
	 rqFH+/GEp5rK4IKfY1NQEkE3FeBHoG9sipOZbNlqjT17uwhM38U8L8QtO/3FPHmlEN
	 /Oa2GjZas++HkWEFqkC48p3FTw3I57/zJXGmrvMeNfh0art6xkyZvPGGxr+T9TB01w
	 I7bgBhil3yaqrIOb5cr9MwRJOYqYocSdmWks0eiW7fRxMJt+dqZveTXC5lA/8AhEpX
	 MyuWcpCGIWa3g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 752BB567E
	for <util-linux@vger.kernel.org>; Mon, 28 Oct 2024 19:19:34 +0100 (CET)
Date: Mon, 28 Oct 2024 19:19:34 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] hardlink: fix 0-sized file processing
Message-ID: <6a5c5b7ea8a584bdec6c82c5d1277fab6ebe4e54.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
References: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qrkmkmwjklmjg3nz"
Content-Disposition: inline
In-Reply-To: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--qrkmkmwjklmjg3nz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The manual says that -s0 will process 0-sized files normally,
but as it stands (a) hardlink considers 0-sized files unlinkable
(so, with -l, unlistable) and (b) fileeq considers reading an empty
prologue to be an error
---
 lib/fileeq.c          | 2 +-
 misc-utils/hardlink.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/fileeq.c b/lib/fileeq.c
index b40eba2b0..1f7f90ccb 100644
--- a/lib/fileeq.c
+++ b/lib/fileeq.c
@@ -465,7 +465,7 @@ static ssize_t get_intro(struct ul_fileeq *eq, struct u=
l_fileeq_data *data,
 			return -1;
 		rsz =3D read_all(fd, (char *) data->intro, sizeof(data->intro));
 		DBG(DATA, ul_debugobj(data, " read %zu bytes intro", sizeof(data->intro)=
));
-		if (rsz <=3D 0)
+		if (rsz < 0)
 			return -1;
 		data->nblocks =3D 1;
 	}
diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 643df7cf2..8c5f24aad 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -649,8 +649,7 @@ static int file_xattrs_equal(const struct file *a, cons=
t struct file *b)
  */
 static int file_may_link_to(const struct file *a, const struct file *b)
 {
-	return (a->st.st_size !=3D 0 &&
-		a->st.st_size =3D=3D b->st.st_size &&
+	return (a->st.st_size =3D=3D b->st.st_size &&
 		a->links !=3D NULL && b->links !=3D NULL &&
 		a->st.st_dev =3D=3D b->st.st_dev &&
 		a->st.st_ino !=3D b->st.st_ino &&
--=20
2.39.2


--qrkmkmwjklmjg3nz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmcf1bUACgkQvP0LAY0m
WPH7Dw//SxP1aetzycX4z1bEb01Z5M5R9NYKt4oMAmGp3xCGwaOheA4o6mkK42b5
mOUPzUa7Q/rdAmS5/8rSHi/358Z0gkAKdEZa6Lz1T82MOkoJLNzvVZXS1YlYX7vt
SI1V+4IKb8nUdEvA/4Ej4NC+xJi14yhLr4MsIZG+AFVhvrNa8av5sRYjAIeS6iKM
SvGMeRvD6iQDzDWxxZ8ywEOi4J1nOto+XsQoa6zS79VqqF5suwnt9omsMfeNwZb3
siqAuD3QHnvWn2rqIkXeMgJjfGY+HNHgayEUxKvXNWJFHj7ZoIe3F99QMM3P77lj
7yCALoPxUEmql10F243h8YLztYcWYpPcLaDYsmKNLIErEg4JkzeG89XiBgXm3wtG
p7UrYY+G/T2tCUNz0D5GYqk6CU7pMD4Eb0qHKebfMO4S56tGnsUA6XmSnJbWCzqd
6yjdDfnYk2v3RdcV7t3mMoqJWI6EQpPpF8Pnu5LQLRlz6tf5heJ3DWocuDhmia52
4RYZC/F2DloEWzcbCHy0z6PupJQ5p/NFRoFMze5rlHGefc6LOwfr1b35U+HPw176
8eG7hJGXi/fIR+uy9akbooHgLhWTZCk7XOawpqQey0XJgAe259e0zg6JI1gS+ff6
sXXgTjoNaOIxezQv8oiibyFOgFiKaPKeemhn46WszBEskKp5DMk=
=y3Uy
-----END PGP SIGNATURE-----

--qrkmkmwjklmjg3nz--
