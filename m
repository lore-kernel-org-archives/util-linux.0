Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34565 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607Ab2DEHgg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Apr 2012 03:36:36 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 48D539290E
	for <util-linux@vger.kernel.org>; Thu,  5 Apr 2012 09:36:35 +0200 (CEST)
Date: Thu, 5 Apr 2012 09:36:34 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/20] uuidd: implement --no-pid option
Message-ID: <20120405073634.GA22664@foxbat.suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-5-git-send-email-petr.uzel@suse.cz>
 <20120403125146.GG1084@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
In-Reply-To: <20120403125146.GG1084@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 02:51:46PM +0200, Karel Zak wrote:
> On Thu, Mar 29, 2012 at 06:45:12PM +0200, Petr Uzel wrote:
> > +	if (pidfile_path) {
> > +		sprintf(reply_buf, "%8d\n", getpid());
> > +		if (ftruncate(fd_pidfile, 0)) {
> > +			/* Silence warn_unused_result */
> > +		}
>=20
>  #include "c.h"
>=20
>  ignore_result( ftruncate(fd_pidfile, 0) );

I'll change this in v2. Thanks

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk99S4IACgkQnZxG0T6qDD0fxgCeIa3ck/l4bM1FlzwyFy5v0R//
kJUAnR/so5izxBT7wpiu7RI2YCVcZIb8
=O57p
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
