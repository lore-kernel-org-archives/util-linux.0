Return-Path: util-linux-owner@vger.kernel.org
Received: from vmicros1.altlinux.org ([194.107.17.57]:50446 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbdLCNeT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 3 Dec 2017 08:34:19 -0500
Date: Sun, 3 Dec 2017 16:29:09 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: improve setarch(8) manual page
Message-ID: <20171203132909.GA1559@altlinux.org>
References: <20171203125117.28159-1-kerolasa@iki.fi>
 <20171203125117.28159-3-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
In-Reply-To: <20171203125117.28159-3-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2017 at 12:51:16PM +0000, Sami Kerola wrote:
> Add more information when and why one might want to use various options.
>=20
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/setarch.8 | 51 +++++++++++++++++++++++++++++++++++++++++------=
----
>  1 file changed, 41 insertions(+), 10 deletions(-)
>=20
> diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
> index 73874c8b6..ce7ba97ac 100644
> --- a/sys-utils/setarch.8
> +++ b/sys-utils/setarch.8
[...]
>  .TP
>  \fB\-\-4gb\fR
> -Ignored (for backward compatibility only).
> +Ignored for backward compatibility only.

The new wording is more confusing than the old one.

[...]
>  .TP
>  \fB\-F\fR, \fB\-\-fdpic\-funcptrs\fR
> -Userspace function pointers point to descriptors (turns on FDPIC_FUNCPTR=
S).
> +User-space function pointers to signal handlers point.  Use when kernel =
does
> +not have MMU.  Supported on ARM, Blackfin, Fujitsu FR-V, and SuperH (as =
of
> +2017-12-02).  Turns on FDPIC_FUNCPTRS.

The new wording is more confusing than the old one.

[...]
>  .TP
>  \fB\-T\fR, \fB\-\-sticky\-timeouts\fR
> +This makes
> +.BR select (2),
> +.BR pselect (2),
> +and
> +.BR ppoll (2)
> +system calls preserve the timeout value instead of storing the unslept t=
ime
> +when interrupted by a signal handler.  Use when
> +.I program
> +depends on this behavior, and the source code is not available to be fix=
ed.
>  Turns on STICKY_TIMEOUTS.

The use of word "fixed" is not appropriate here.  According to select(2),

"On Linux, select() modifies timeout to reflect the amount of time not
slept; most other implementations do not do this.  (POSIX.1 permits either
behavior.)  This causes problems both when Linux code which reads timeout
is ported to other operating systems, and when code is ported to Linux
that reuses a struct timeval for multiple select()s in a loop without
reinitializing it.  Consider timeout to be undefined after select()
returns."


--=20
ldv

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaI/wlAAoJEAVFT+BVnCUIGiMP/jVn1oGeB4tzBifMMPI0cqOF
oNCXMEMTgRA5xd3p2k0oF7MDe5Y71ZwqZPrEv/etUTM+7AuyDW/JJeITeCbPrUsX
uDnpT/xDac3tCTad7X3wBwCSphOHXO9OOAKHKYhjtnEGnYWIjcrGnb9tyacrcDii
3VfaoTML46n5tXfbntMkfUT6n3JEFL4/FqIws4gsoDstXP3EhOIk3+wivhR7U3c7
ADI+MAfjiMX/8wu+sZUpEaHKHqgQlZiptWFU5EmpaDF8au68ap0FYELJzUvrrODK
mX+fRZMieh9arZ61WWy9/DvFwaDz+h6Of3cLxXDhMKdj9TF3wId9ibr7wYhwTwMi
2NNuyaCEvy+aFMcPgtEFIZ/d1p+VkOYDwKQoWOoaUWP7DKXyA1bXSLutW0DQ1kXQ
2nAVkLkRGmI+15J0DQZfvwKlHGL5NVggIM5ltRDpy9wxUlrK/VCorPmU+VMM9xuf
Qn7iRlme0vzDvFAQ5FtbWO8dFrU3ObjkHJH6XfLM3ZZpK5MyuvHHbqNXnXdDkK7D
0Om1lVzTxMc4GvTER+5i5fvJUWN/bbosazyY+m5U3W8TLBT5voOPdh+9o9lbQaVP
+FU52NfypEAhHmZ0l2ObU1/wuwQrKPaTFyG78olXFK140V6Z89536EOf13yRGiMo
mpnK0XX97enCWwZvNtBI
=7GPZ
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
