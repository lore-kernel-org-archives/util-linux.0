Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35042 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab2DEHqv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Apr 2012 03:46:51 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7261293182
	for <util-linux@vger.kernel.org>; Thu,  5 Apr 2012 09:46:50 +0200 (CEST)
Date: Thu, 5 Apr 2012 09:46:49 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/20] uuidd: implement --socket-activation option
Message-ID: <20120405074649.GB22664@foxbat.suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-8-git-send-email-petr.uzel@suse.cz>
 <20120403130319.GH1084@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
In-Reply-To: <20120403130319.GH1084@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 03:03:19PM +0200, Karel Zak wrote:
> On Thu, Mar 29, 2012 at 06:45:15PM +0200, Petr Uzel wrote:
> > Implement --socket-activatoin option, which is supposed to be used
> > with systemd (or equivalent init system) socket activation mechanism.
> > With this option, the UUID daemon does not create the socket on its own,
> > but instead expect the connection fd to be provided by the calling
> > process.
> >=20
> > This option is only available if util-linux is configured with
> > --enable-uuidd-socket-activation option. With this configure
> > option, the uuidd is compiled with sd-daemon.c.
> >=20
[...]
> > diff --git a/configure.ac b/configure.ac
> > index 2140bc5..bb56948 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -1101,6 +1101,18 @@ if test "x$enable_login_chown_vcs" =3D xyes; then
> >  fi
> > =20
> > =20
> > +AC_ARG_ENABLE([uuidd-socket-activation],
> > +  AS_HELP_STRING([--enable-uuidd-socket-activation], [build uuidd with=
 support for systemd socket activation]),
> > +  [], enable_uuidd_socket_activation=3Dno
> > +)
>=20
>  What about --enable-socket-activation (without -uuidd-)?
>=20
>  If you have distro with systemd then all your stuff should compatible
>  with the initd (it's detail that currently we have one daemon only).

Good idea.

>=20
> > +AM_CONDITIONAL(UUIDD_SOCKET_ACTIVATION, test "x$enable_uuidd_socket_ac=
tivation" =3D xyes)
>=20
>  USE_SOCKET_ACTIVATION

OK

>=20
> > +if test "x$enable_uuidd_socket_activation" =3D xyes; then
> > +  AC_DEFINE(UUIDD_SOCKET_ACTIVATION, 1, [Should uuidd support socket a=
ctivation?])
>=20
>  USE_SOCKET_ACTIVATION

OK

>=20
>  [...]
>=20
> >  static void server_loop(const char *socket_path, const char *pidfile_p=
ath,
> > -			int debug, int timeout, int quiet, int no_fork)
> > +			int debug, int timeout, int quiet, int no_fork,
> > +			int no_sock)
>=20
>  hmm... pretty long argument lists :-)
>=20
>  Maybe use struct uuidd_cxt with bit array for all the arguments. If
>  yes, then use a separate patch for this change.

OK, I'll change this in v2.

Thanks,

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk99TekACgkQnZxG0T6qDD2x+wCeM/XHCpHyYvxuA+gESGN20ict
2FcAn142hVkOJusB1ql3sYhtOhUDSBqU
=KneF
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
