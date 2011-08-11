Return-Path: util-linux-owner@vger.kernel.org
Received: from karif.server-speed.net ([188.40.51.140]:39230 "EHLO
	karif.server-speed.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab1HKSwg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 11 Aug 2011 14:52:36 -0400
Received: from karif.server-speed.net (karif.server-speed.net [127.0.0.1])
	by karif.server-speed.net (Postfix) with ESMTP id 275CE90009
	for <util-linux@vger.kernel.org>; Thu, 11 Aug 2011 20:52:35 +0200 (CEST)
Received: from [192.168.4.247] (h081217049118.dyn.cm.kabsi.at [81.217.49.118])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: flo)
	by karif.server-speed.net (Postfix) with ESMTPSA
	for <util-linux@vger.kernel.org>; Thu, 11 Aug 2011 20:52:35 +0200 (CEST)
Message-ID: <4E4424F2.3070007@xinu.at>
Date: Thu, 11 Aug 2011 20:52:34 +0200
From: Florian Pritz <bluewind@xinu.at>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: mkswap fails to use more than 2GiB and doesn't recognize LVM
References: <4E43F629.6040408@xinu.at> <20110811181454.GD32051@nb.net.home>
In-Reply-To: <20110811181454.GD32051@nb.net.home>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig31A58BA39D5032D700CBFC06"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31A58BA39D5032D700CBFC06
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11.08.2011 20:14, Karel Zak wrote:
>> busybox mkswap crates the expected 8GiB swap, so I think this is a bug=
=2E
>=20
>  Do you see see 8GiB swap area in /proc/swaps after swapon? I don't
>  think so...

> cat /proc/swaps
Filename                                Type            Size    Used
Priority
/dev/dm-4                               partition       8388604 0       -=
1

--=20
Florian Pritz


--------------enig31A58BA39D5032D700CBFC06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIcBAEBAgAGBQJORCTyAAoJEG0WVcFM4cE+n6gQAItb/Vqq7ntHvLPIByBLleIk
5iyh7vQ3x8ajlg05r6wvN9oO+C7PkDaEcTQsL9F3YqpEdC8yANxwGhUSonEP7aWM
tQbTOLZx+qCtWwQT0PXISOy8B1bPKoHQV6WGykV15iYnn2lAqDxe7rJtr2suTb0i
nh8UmpvVh3/pDJRwkAqwVs5qKJlyljEF5QSzORsCGVzoGgelCXEcqqMlWvPDAQxm
50gfdQG/DWEwTqAICyUetQi7RbxixOPXGoW9Xg6uhmg4J6w1j5tfjDavEtdOPNag
QxmnXoupdyEQCG28Ax1leyhanjQHlGu++jZPgX3tZVshp49p+ajLIpqe9GibKuc+
p1UVDTUpQ9TKshgD7DE4OU2qvbSne8qp/vPWSdbVuda7+lhu5mmS82ZDDkY1SxpV
ViHkJIdBuxSJbTMdsLBZ7hqGpFMvGmbYgV7JNp3cgKURwU50QTokH6cz8L+D1AFH
ZQYyXbFgEMVGKPpfI+V32suJkUUE9GUisc1YwaO1mGPrmKj/f/7Tqb2AHWr5RRA+
MlT/dc7oNrDse2hDgnNkwwnB8oOa0pMbzVBNyycWw5mSdbKajkuedwkKSSNynoe3
CwGtSREyhv1hx16gq77heXoh9LD49fDHnZRXwVbfxHGF/ZyYFzSb0NbSE1U8jUTk
p7aO3n+DyTQOJX4xncd9
=/9CY
-----END PGP SIGNATURE-----

--------------enig31A58BA39D5032D700CBFC06--
