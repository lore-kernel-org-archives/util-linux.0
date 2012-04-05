Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35298 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2DEHs5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Apr 2012 03:48:57 -0400
Date: Thu, 5 Apr 2012 09:48:56 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Cc: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 11/20] uuidd: introduce --keep-privs option
Message-ID: <20120405074856.GC22664@foxbat.suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-12-git-send-email-petr.uzel@suse.cz>
 <20120403133226.GI1084@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
In-Reply-To: <20120403133226.GI1084@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 03:32:26PM +0200, Karel Zak wrote:
> On Thu, Mar 29, 2012 at 06:45:19PM +0200, Petr Uzel wrote:
> > This option makes uuidd _not_ to drop its privileges if installed suid
> > and exectued by root.
> >=20
> > Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> > ---
> >  misc-utils/uuidd.8 |    5 +++++
> >  misc-utils/uuidd.c |    7 ++++++-
> >  2 files changed, 11 insertions(+), 1 deletions(-)
>=20
>  Please, drop this patch.
>=20
>  For socket activation we can use the "drop_privs =3D 0" internally, it's
>  unnecessary to export this functionality to command line.

Agreed. Exporting this via cli argument was a stupid idea.

>  Anyway, do we really need to support suid uuidd? What about to drop
>  all this stuff and require that uuidd has to be started by init
>  scripts only? What about to drop exec-from-library at all?
>=20
>  RHEL/Fedora/Suse starts uuidd by init, and for another distros is
>  whole uuidd almost unnecessary thing... It seems that Debian uses
>  suid uuidd, but I think that they can add an init script too.
>=20
>  IMHO the current exec-from-library and suid is not elegant solution.

FWIW, I'm all for dropping spawning uuidd from libuuid.


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk99TmgACgkQnZxG0T6qDD1NqACePsm+0B0v3y/+884JdPAMELA+
ElMAoIKRSaWJSNqDyusMCLOPbDZhK9Y6
=ikcf
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
