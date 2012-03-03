Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:37748 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255Ab2CCOpd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 3 Mar 2012 09:45:33 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2177490182
	for <util-linux@vger.kernel.org>; Sat,  3 Mar 2012 15:45:32 +0100 (CET)
Date: Sat, 3 Mar 2012 15:45:25 +0100
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: Re: v2.22 wish list
Message-ID: <20120303144525.GE5683@skipper.site>
References: <20120229154420.GD8471@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
In-Reply-To: <20120229154420.GD8471@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 29, 2012 at 04:44:20PM +0100, Karel Zak wrote:
>  * make uuidd (uuid daemon) compatible with systemd
>    - add --no-fork
>    - add --no-pid (pid file)
>    - add systemd unit file
>    - add #ifdef LIBUUID_EXEC_UUIDD to disable uuidd exec from library

Hi, JFYI (and to avoid duplicate work), I started on this:

https://github.com/knot/util-linux/tree/uuidd

Regards,

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9SLoUACgkQnZxG0T6qDD0kwACgh1ewdxemYp9VUYDjNOPRLNio
PAIAn0dPdYraLjtUQjG46+xgIoYa2SIA
=GPjo
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
