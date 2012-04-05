Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35666 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab2DEHwl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Apr 2012 03:52:41 -0400
Date: Thu, 5 Apr 2012 09:52:40 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: teg@jklm.no
Subject: Re: [PATCH 13/20] uuidd: add systemd unit files
Message-ID: <20120405075240.GE22664@foxbat.suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-14-git-send-email-petr.uzel@suse.cz>
 <20120403140140.GK1084@x2.net.home>
 <CAG-2HqUudB4k4xGq7b7iwYGRCa-7eam0TmQGd9B35MhC3sBfKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
In-Reply-To: <CAG-2HqUudB4k4xGq7b7iwYGRCa-7eam0TmQGd9B35MhC3sBfKg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 04:47:00PM +0200, Tom Gundersen wrote:
> On Tue, Apr 3, 2012 at 4:01 PM, Karel Zak <kzak@redhat.com> wrote:
> > On Thu, Mar 29, 2012 at 06:45:21PM +0200, Petr Uzel wrote:
> >> +AC_ARG_WITH([systemdsystemunitdir],
> >> + =A0AS_HELP_STRING([--with-systemdsystemunitdir=3DDIR], [directory fo=
r systemd service files]),
> >
> > =A0systemdsystemunitdir ???
>=20
> This is the variable name most other projcts use for this purpos. The
> reason being that it is suggested here:
> <http://0pointer.de/public/systemd-man/daemon.html>.

I'd prefer to stick with what systemd doc recommends (^^) and what
other projects use, even if it might be unnecessarily long. Karel, OK
with you to keep this?

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk99T0gACgkQnZxG0T6qDD0EdACfbZSwhk3ApwtzddDreGnvhQMz
Ah8AoIZU30gs6FLQbCcA/t+Cy54nIuZ+
=2QCT
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
