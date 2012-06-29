Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43240 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689Ab2F2Dij (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Jun 2012 23:38:39 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: kerolasa@gmail.com
Subject: Re: [pull] /run directory and swapon
Date: Thu, 28 Jun 2012 23:38:40 -0400
Cc: "util-linux" <util-linux@vger.kernel.org>
References: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
In-Reply-To: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2066467.l29fBuBx1D";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201206282338.41501.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2066467.l29fBuBx1D
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 27 June 2012 17:33:25 Sami Kerola wrote:
> --- a/configure.ac
> +++ b/configure.ac
>=20
> +case $prefix:$localstatedir in
> +  NONE:'${prefix}/var')
> +    localstatedir=3D/run
> +    AC_MSG_NOTICE([  --localstatedir defaults to /run])

i'd trim the leading whitespace in the message

> +    ;;
> +  *:'${prefix}/var')
> +    localstatedir=3D${prefix}/run
> +    ;;
> +  NONE:*)
> +    ;;
> +  *:*)
> +    localstatedir=3D${prefix}/${localstatedir}
> +    ;;
> +esac

is this last case just so you can AC_DEFINE the value below ?  in general,=
=20
this is fragile.  defines should be expanded at make time rather than confi=
gure.

CPPFLAGS=3D"$CPPFLAGS -D_PATH_LOCALSTATEDIR=3D\"\${localstatedir}\""
=2Dmike

--nextPart2066467.l29fBuBx1D
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJP7SNBAAoJEEFjO5/oN/WBwckP+wZdhwz03lPPeU7qnaULd/4d
1QSigJCJ6/RLfgTU3BPaXBtqtZ/RQvKJ5OK8DycZLuKdnxKcTchQR1OZuqSRrWhw
ATIPv+EhArW6eUFUNIK/Jcpe6Yr1achiyUVamR/8UJGVmYncRXhiJHkZQjdxpugr
tdsTFE4PbDFBqSmNBCwBfS/qG8xNCkkxOTQS+tyO+89nN7/K059+cLVh0ht0i9wm
a8iJR/8F/Gi8FPIKrUBwggy5hj6wEMeDnSXkMrEdJSDC8snOwX3RyEDWsjU1GzXj
lZPo8KNl7SWFWiy4Tl85aPe2kmoO48nARpyKprgYUWbhpYSPsewDS681F/axz5ii
MZzviH97guUTFxZcPT71eIw2pARQM3bfDiRA5QBACOatH9FAoQNHXcZ94jVwKDu5
DsGqg7eSKb4JCekLy+slUQspiAvCDMdho+kLraG3RyCCvScbW8LA31mQYZZT1MfO
d4175u0o+RGvdP+6/q0TqlGv717xtM5tvMtM7UapqPHvbEdV00ftapsyHu3HAjtv
PGlGoPi4a7f8U/DAM9IH9/EpFZ1GPMSbrhiE9kUsPU1abBllkYiSabFySZS20qxe
XhTo0qIK3zMOfvsbqqoR1r5xIVTHjKCgMxDbKNZLIblleU0g7lQFHWBz3twJLJcZ
BqMECs5KWSWIIZLakTwH
=yrVs
-----END PGP SIGNATURE-----

--nextPart2066467.l29fBuBx1D--
