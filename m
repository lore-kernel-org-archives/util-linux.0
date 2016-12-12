Return-Path: vapier@gentoo.org
Date: Mon, 12 Dec 2016 13:27:35 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.29-rc2
Message-ID: <20161212182735.GQ10558@vapier.lan>
References: <20161019132505.cumn37cmgazlumcu@ws.net.home>
 <20161020151948.3y47rv5lwmqppubf@ws.net.home>
 <20161210171510.GH10558@vapier.lan>
 <201612121501.57462.sweet_f_a@gmx.de>
 <20161212142834.jnspem6oeqqbly4g@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bDDjztrZmyyMv72E"
In-Reply-To: <20161212142834.jnspem6oeqqbly4g@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--bDDjztrZmyyMv72E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 12 Dec 2016 15:28, Karel Zak wrote:
> I have add one AC_IF and PKG_CHECK_MODULES to our UL_NCURSES_CHECK to
> prefer pkg-config and fallback to ncurses-config. It's trivial fix and
> it seems it works as expected.

thanks

i'd also note that the current logic isn't the preferred method for
finding tools like this.  the code looks like:
  if AC_RUN_LOG([suffix[]6-config --version >/dev/null]); then

which means it runs xxx6-config directly.  in autotools, you want to:
	AC_CHECK_TOOL([NCURSES_CONFIG], [ncurses-config])
this will make it search for $host-ncurses-config first, and when
cross-compiling, it'll warn if it falls back to ncurses-config.  it
also means builders can set $NCURSES_CONFIG to whatever weird path
they want to.

based on how the current code is written, it'll be a little more
difficult to integrate.  you'd have to use like m4_translit.
untested:
	m4_define([SUFFIX], m4_translit($1, [a-z], [A-Z]))
	...
	AC_CHECK_TOOL(SUFFIX[]6_CONFIG, suffix[]6-config)
	if AC_RUN_LOG($SUFFIX[]6_CONFIG --version ....
-mike

--bDDjztrZmyyMv72E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTuwXAAoJEEFjO5/oN/WBXt4P/RMKA5nWp2BYS1yE91Gd65US
SRTRNyoobfW8pAeITxGSOYbAx8V3FiaOKi89cv+YuBYuVSqhNSDRi1CsqktaLjpu
AZ/mSbZzIoWLcfGvQz0GJTWVyYYBlzKE4VrsVwFobA5K9LLln0C6i+CVVmcJCkmr
cKBqKWgXKHImCSzS052nEwf5Wnznzo6o+NEjGTuZSXlHycJF5tqpZaVusbMtCMIW
oafkzBlVp9vlEWiIfx20lrabBeFxlH9wXOSusAPlY5d9ldDgXgGYG1twpN+cpVBV
n3AdlfBbecniEPDUZPBc0b8YQV2yvh83Oixk9V45aIp25sF624qIQPkdVS2WvqwZ
omhfGtxIGAHKQkUUnC5RldzA5uNBxaSUAcYBtdhrqhUg0jjaNGusaJwv0CZa8DVT
JU5tpWrJB84VilB59guxrcLoCcLj1AWvJWqdahy/6b5mNVuniopDnoPVAcdu8REX
Pgb6caRJwcechuzMIOEdSY40UqMVveY+aQ3x6mFXzEnAnIhgE8ivPuQwi0/BaosE
dLY6otC/Wzl6nMRtW0tdUfI21/ixGChdgYec+CGtfsbPSwlXqkYr+FzYc0EyVWXA
RPRowEFh7XDgAAK1Dlg87aGwErqGJ7MmPo6FIC8DGYfjY/d37rceoL4unjgcJm6E
rOjFyvsqGBX1L9nVtSVC
=8vie
-----END PGP SIGNATURE-----

--bDDjztrZmyyMv72E--
