Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:39980 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbaHLBRE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Aug 2014 21:17:04 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
Date: Mon, 11 Aug 2014 21:17:02 -0400
Message-ID: <1549603.ZWLTNRFnAF@vapier>
In-Reply-To: <1407768431.5984.23.camel@oct.suse.cz>
References: <1407768431.5984.23.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6830290.cyzizNH9zj"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart6830290.cyzizNH9zj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Mon 11 Aug 2014 16:47:11 Stanislav Brabec wrote:
> Solution 1:
>=20
> Modify make system by adding:
> --enable-build-stage-1: Distro bootstrap stage 1: Build only code
>     without systemd and python dependencies.
> --enable-build-stage-2: Distro bootstrap stage 2: Build code with
>     systemd dependencies (even if they are optional). Use installed
>     instances of libmount, libblkid, libsmartcols and libuuidd, do no=
t
>     build them in-tree.
> --enable-build-stage-3: Distro bootstrap stage 3: Build python-libmou=
nt
>     only. Use installed instance of libmount, do not build them in-tr=
ee.

how is this any different from just passing --without-{udev,python} ?
=2Dmike
--nextPart6830290.cyzizNH9zj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJT6WsUAAoJEEFjO5/oN/WB8CIQAKBvB3ZUQPwkVJCq29N5ZA/N
D/PwYZrTJc2dytJ7JS3LvjrUwq8WZKapDVK5lSAbKi7KjECdwYpE85voaXRMJmgK
kXTEjGW5FHgVa4X8EdIqBuwhsKnC8BnLhOcmynv8TrrQBFYFh+AxdDu4Ztx1h9Ip
ysGscOrEl8gOTzx1bdzbLZeBRDP6lSGeIMf/9of2Ex3/8KcqRsDE8J/VBTGn+MCi
p0XIy4SKUh63Suw/yEBeWFVWmrDcW3OHt6hgeHQ1Yi2+2Ajnb+rJtZtu5kRJCPDj
JuKGeDRpGVqovQ251HlCJStz/EaKU+ulu+cos+3SytIW4LTSxp1wkcA/kjf2rbnn
pqaB6HzDZrDslRtXRoITaVQOO/fElXZyu/zjZrOA9zt9BmzEVFZSTkoVN4lBBtbg
wsofrR7iOKsZQXfrZLWvSl28Ig/5QDuPuIT5gJtBwNlPQA70eRopjTZa5dsyq4+c
rG6riu6OOte8rPYWlXmY0PvR/RIFqBKR0RxQ3nyptTvYJLE3QTzXE4VzrsMDTI6N
nEm51h9wqwG6ldvK6nm7v6IZOU43D9yQ/9JULyoVVBNNhumjUMMZ8wzd7GNluTWr
wTwrCc5yo+6GC6wI8yWIMxVfwfF9cxBC3YjflYDFWfE8qrqJohlaAOqv5io2nsvs
2yzWqt2LBnfQFgsguQ9Z
=VO6l
-----END PGP SIGNATURE-----

--nextPart6830290.cyzizNH9zj--

