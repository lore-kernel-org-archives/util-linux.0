Return-Path: util-linux-owner@vger.kernel.org
Received: from vmicros1.altlinux.org ([194.107.17.57]:55248 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbdLIB3j (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 8 Dec 2017 20:29:39 -0500
Date: Sat, 9 Dec 2017 04:29:37 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Sami Kerola <kerolasa@iki.fi>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: improve setarch(8) manual page
Message-ID: <20171209012937.GA27446@altlinux.org>
References: <20171203125117.28159-1-kerolasa@iki.fi>
 <20171203125117.28159-3-kerolasa@iki.fi>
 <20171204120404.aa4p6p2o3goupsq3@ws.net.home>
 <CAG27Bk3ScbYMxT3xi8x6tmx6map3_gRbddbU1p9nN=k3NJQMuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <CAG27Bk3ScbYMxT3xi8x6tmx6map3_gRbddbU1p9nN=k3NJQMuQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 01:20:01PM +0000, Sami Kerola wrote:
> On 4 December 2017 at 12:04, Karel Zak wrote:
> > On Sun, Dec 03, 2017 at 12:51:16PM +0000, Sami Kerola wrote:
[...]
> >>  \fB\-\-4gb\fR
> >> -Ignored (for backward compatibility only).
> >> +Ignored for backward compatibility only.
> >
> > Dmitry is right, the old version is better.
>=20
> How about text:
>=20
> This option is no-op compatibility with an old Debian setarch
> implementation. Please do not use.

Let's add a description that is informative but without giving advice.
For example,

"This option has no effect.  It is retained for backward compatibility only,
and may be removed in future releases."

or

"This option has no effect.  It is retained for compatibility with ...,
and may be removed in future releases."

> >> +This makes
> >> +.BR select (2),
> >> +.BR pselect (2),
> >> +and
> >> +.BR ppoll (2)
> >> +system calls preserve the timeout value instead of storing the unslep=
t time
> >> +when interrupted by a signal handler.  Use when
> >> +.I program
> >> +depends on this behavior, and the source code is not available to be =
fixed.
> >
> > See Dmitry's note ;-)
>=20
> How about this:
>=20
> -- snip
> This makes
> .BR select (2),
> .BR pselect (2),
> and
> .BR ppoll (2)
> system calls preserve the timeout value instead of storing the unslept ti=
me

I'm not sure about "unslept time" phrase.  Wouldn't a more formal
description be better, .e.g.

This makes
=2E..
system calls preserve the timeout value instead of modifying it to reflect
the amount of time not slept when interrupted by a signal handler.
=2E..

> when interrupted by a signal handler. Use when
> .I program
> depends on this behavior. For more details see the timeout description fr=
om

s/from/in/

> .BR select (2)
> manual page. Turns on STICKY_TIMEOUTS.
> -- snip

On the whole, this looks much better.

> My remote git has the latest.
>=20
> https://github.com/kerolasa/lelux-utiliteetit/blob/2017wk48/sys-utils/set=
arch.8
>=20
> And that branch also has FIXME item near FDPIC_FUNCPTRS description.
> Proposal(s) welcome how to make that text understandable.

What about this text:

"Treat user-space function pointers to signal handlers as pointers
to address descriptors.  This option has no effect on architectures
that do not support FDPIC ELF binaries.  Turns on FDPIC_FUNCPTRS."


--=20
ldv

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaKzyBAAoJEAVFT+BVnCUI8SsP/39/gpYLobCXiEuUkCufIKWT
GxmHFCxD7kbguStrWO9H2NtSmu/+78VWAfk3EfLxPXXb1lphhddtdllePBLlUDZq
MiZK8InLw1imQyBxHXEXfVDWQqWljxAvn6EPKy1rJAUcqVtselNJ4ozChh0DEqRI
OK0eKyIpBtPr6bKw8v432016MSEEDiqsKCQbrPcUHvHmwdHLVOE5xVh00tQOofVA
6ehwzFwQaREYRCmdDSF6uvFRIBygwkaJfQWev5VKbwhAqcDryVySlHzuFiPZUMST
+LtwJQQa88NUwoBGpnO0+ExYbdNMPy/kTPYCTQbCxaU3kPBRzszw+4JXVNa9jX8B
D0CAjDv/ao6c43hIpVpOieC22Q5l1SrhWhrL9ZsRCDbpKtVqpkKwF9ua6G0BJMPP
qaf4+WKCixIgioCLmBHCx/QfPNAApl6ZImv2GGhv183m9dpq1EjWs/4QhsrCDZ+h
QQxglns8aXOgAPqHVpwpqxYk43VZ5WVA13X6aLNvl1rPNPhWgX8iFFAKoZuSe9tT
MimJCN7vDi2swUk0pKAZ9B3wq9Iy3stc2laIexDCbpmvuz8HlrWd5Yvwez3+thkc
Ck74nWcafsrT9iG/EFI+whwgqTCgEIHf0dLGmLlIAQJ0ay1108zXnHGFrlEmrbXQ
YOowVMu/pvy8XHaX2sK7
=Wnz4
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
