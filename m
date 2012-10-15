Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:37835 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab2JOCOA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 22:14:00 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 08/19] libmount: replace usleep with nanosleep
Date: Sun, 14 Oct 2012 22:14:06 -0400
Cc: util-linux@vger.kernel.org
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi> <1350246070-10544-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-9-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5923449.pzbJ9kPhXI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210142214.07066.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart5923449.pzbJ9kPhXI
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 14 October 2012 16:20:59 Sami Kerola wrote:
> POSIX.1-2001 declares usleep is obsolete.

this is true, but it seems like a better answer would be to add a usleep te=
st=20
to configure and provide a local fallback using nanosleep if it doesn't exi=
st.
=2Dmike

--nextPart5923449.pzbJ9kPhXI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQe3FvAAoJEEFjO5/oN/WBZ5UQALdq6hYrLJp7zivKkMgPkfql
l7ZgnVrWEmasUCikC0pCw+gzHS23ZuKTZsDaeyVAh5UX5SxzfkjLK3dCOKEHOivs
XIja/9DLKQGY4lTkrAYwnDVjc29W5bU5ZWThGBBruCIdO6grOuO9nMjjtsDMD2+W
sR2HfdPzoEdu0ECn3ViwS87TeO5d13GvwfaSP4in8ctVGhKNZiTSGl/4IPS4nkp9
jLeMge9lDEOMnXopIf1Q9KpyE3tCw7gF4mH+L8Ouv9DGHO5/FMiwLJdKy/9EaQrK
K7jlWcahnr+BZAWsBhpYjDwLwZdIx58Y3bRwbLlHiMOpoFMFD/glgRtmBQaemlOX
gq+V1yB40HoTsazG/tdI9HBytO/Wx0y0V4OIjqiGi2YOUhfd1497zI7YBKaFzYq9
9jkJFtEbhihBc9VkWPIpQLLc8JWCR899nHJ1szeoyjTjVDWaG8nx8WI1exBzIDvv
H68LDUEHCaHKNhDhrsgrxda1wwk9THm7mlwstI3+t25gPy9CaGj2fkA9FvPnzHoD
MA5PrAiOWPbi3+V9Y0xv7NDba5TJiql/mIDbpRxC2KSChbxq5wFtGYjhnyN16RT0
YLWitAr2fyZtwLQbVyLfvrI7kV4bjDL1COkHLQ0wFqQsWJEvZjH9GoRmedr6R9Rz
46aR5QTg2zEEfUYFyFu+
=7+68
-----END PGP SIGNATURE-----

--nextPart5923449.pzbJ9kPhXI--
