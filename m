Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35337 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2DEHtj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Apr 2012 03:49:39 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DBF01935A1
	for <util-linux@vger.kernel.org>; Thu,  5 Apr 2012 09:49:38 +0200 (CEST)
Date: Thu, 5 Apr 2012 09:49:38 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/20] uuidd: --socket-activation implies --keep-privs
Message-ID: <20120405074938.GD22664@foxbat.suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-13-git-send-email-petr.uzel@suse.cz>
 <20120403133828.GJ1084@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
In-Reply-To: <20120403133828.GJ1084@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 03:38:28PM +0200, Karel Zak wrote:
> On Thu, Mar 29, 2012 at 06:45:20PM +0200, Petr Uzel wrote:
> > +process.  Implies --no-fork, --no-pid and --keep-privs.  As of this wr=
iting,
> > +this option is supposed to be used only with systemd. It needs to enab=
led with
> > +configure option --enable--uuid-socket-activation.
>=20
>  It would be better to add a NOTES section to the man page and add there
>  a note about socket activation.

Yes, that'd be better. I'll do in v2.

Thanks,

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk99TpIACgkQnZxG0T6qDD2ijQCgh/cmka6YO7Q07TiNeEkK3wwR
n6oAn3BJFjTlmmS8YyT1xFDQZvzkbMEj
=aVP8
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
