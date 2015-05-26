Return-Path: util-linux-owner@vger.kernel.org
Received: from [82.195.75.110] ([82.195.75.110]:59656 "EHLO master.debian.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751142AbbEZEqM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 May 2015 00:46:12 -0400
Message-ID: <1432615401.2154.37.camel@debian.org>
Subject: Re: when would blkid success but not filesystem type?
From: Paul Wise <pabs@debian.org>
To: 784709@bugs.debian.org, util-linux <util-linux@vger.kernel.org>
Date: Tue, 26 May 2015 12:43:21 +0800
In-Reply-To: <1432614096.2154.33.camel@debian.org>
References: <20150520145904.3e4645dd@patagonia>
	  <1432196678.28686.58.camel@debian.org>
	  <20150521110735.GA4730@ws.net.home> <1432614096.2154.33.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-b0viTVbfLXklvPTQkGyE"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-b0viTVbfLXklvPTQkGyE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-05-26 at 12:21 +0800, Paul Wise wrote:
> On Thu, 21 May 2015 13:07:35 +0200 Karel Zak wrote:
>=20
> > The option '-s' does not affect return code ...  we have information
> > about all (including empty) partitions!
>=20
> Ok, I see. Sounds like the proposed patch is appropriate then.
>=20
> https://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D12;filename=3D0001-Fi=
x-by-forcing-fs-type-to-not-detected-if-not-named.patch;att=3D1;bug=3D78470=
9

Actually the code in question already contains a code path for when
blkid returns success but an empty string. Needs more investigation.

--=20
bye,
pabs

https://wiki.debian.org/PaulWise


--=-b0viTVbfLXklvPTQkGyE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVY/nsAAoJEDEWul6f+mmjZ7UP/05iYweoZRUR47sJfQuk4XkZ
r6qnkNHgoCR3hUJ2Ii6Iuk9nhPhgZW5lWxAdUtzniERjMQGN7wko8ljgGoLe+Z8s
mpit9v08+n9+08JHG1vj6z+IuZbhzJs8l04L+0S1IPdUIckJ2IqfVGv9V9Zn5yL3
+JERabsoIArB2dLNXtO1Rn1fLhCODk/jagAxCgPzT3gQE/YS371nxUWUgdQqzm98
bsnQAZV8PadtkX0XkwSb7aidVUAZuZmLjg55q/OM0bA39A/vkmgUInI+qARyV7w1
6l41vLUyOGbDHlBAmWZKQ2Bg3EA5CABQx90cam1KyUn7fdwIVnshBWreLwl4e+cG
FqK4c9zzxGsOGBQDAtLx5ddhb3QHw/P1pM7TAsPIgHlcXogPN1AvmaLtIQSRsDPu
ZsGa23DFWGfB11G5ootMwu4W1mzHH6/r9WHya+Ei8iA4KeLy2k2j0aLa54HNWAje
XMmZrIF2uFOdoa1k65GmUb8gqbOlG0iSHI5HOzueAq4AJLezo+VZFjD0OOfBkMPm
jtLcDv9AQwUR3ILCSEQMPQmd97tEU8vfCCj4T5MBIhrGVTEYpJMMuNz92fvsvjTp
q/uf8H+GuCbLGhmD3txDQEObbtE2XLgFXeHOdsD9TozdTEdUPM1iAtQ07mq+pKtB
H3TEcnoJW0dZMO1LswBN
=ZD0g
-----END PGP SIGNATURE-----

--=-b0viTVbfLXklvPTQkGyE--

