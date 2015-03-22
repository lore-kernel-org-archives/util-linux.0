Return-Path: vapier@gentoo.org
Date: Sun, 22 Mar 2015 02:24:37 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: unshare(1) --propagation
Message-ID: <20150322062437.GK4504@vapier>
References: <20150318172603.GE28925@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="96dIhm/ZjrNld+BP"
In-Reply-To: <20150318172603.GE28925@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--96dIhm/ZjrNld+BP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18 Mar 2015 18:26, Karel Zak wrote:
> Comments, objections?

i was looking for exactly this sort of feature recently :) -- namely to uns=
hare=20
& mark everything private w/out having to write my own dummy wrapper.

i just worry about the next request where people want to mark everything pr=
ivate=20
except that one special mount ...

> +static unsigned long parse_propagation(const char *str)
> +{
> +	size_t i;
> +	struct prop_opts {
> +		const char *name;
> +		unsigned long flag;
> +	} opts[] =3D {
> +		{ "slave",	MS_REC | MS_SLAVE },
> +		{ "private",	MS_REC | MS_PRIVATE },
> +		{ "shared",     MS_REC | MS_SHARED },
> +		{ "off",        0 }
> +	};

static/const ?
-mike

--96dIhm/ZjrNld+BP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVDmAlAAoJEEFjO5/oN/WBbx8P/ApJH8MLZPW5F+sqKWSAUnbE
/nASQGP2K16ckMcB4FJGIBmORfVJOhRLImEjeG5P+I/9uIbHT8ot6K5nQpl0+Ecp
JLLezbw6GVFhxzTg7PWyKvbJfm73a7OKBK+drnafzYrKyoGz2B2KmvhCDz+hipDe
iUDSzdaPEvqMeX2Hq7szBkcyVCPv3vemZmKzQevnkCwXmyNiPPqD2qOvYR1Frk6r
EYU1seMhlVer4sFjTMIEFvmQqUnY7Qf9FpSU+Kijc7tjXT2g+aFVxRMuVwXS7Uft
nIi2k3RC9GlFBCW7GzjZQbp7WVBRy8c7MsKE+8giwU1KFC1w4Ll3o8VCSPYYcX0Y
gCJJA1KoJ0KWnYgS+FpoNuPzoxS7HF+ZIxuQ+9ZxKSYlq8hftk36+0CDnSKTJk9C
dqEoDm9RX2e3P77x3+WDxngy/EYEKgbluXi9glyFYhdDTXrabSsmIpbEt81f17t0
7z8Gx0362rGJJaq91rtN2wrzNJFmkKKER8LSi3T+1r/mW4REihWoor0CCmpdpnWR
rq4hF6hHMgRK1SZ5wTBwsS2QWSNzgKbYPgLWWe/nFuw+vDr4lE2QSDOAlyVJUb06
xPoIEq+lRDTHHReDLyAR+9SLP+pn8MYsDkLLGzeohYcKnFolBdLhNqvkkEgwDgbg
C9koY62Y+cUgByicX5ry
=kBcW
-----END PGP SIGNATURE-----

--96dIhm/ZjrNld+BP--
