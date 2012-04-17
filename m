Return-Path: util-linux-owner@vger.kernel.org
Received: from basal.nesselzelle.de ([88.198.40.36]:49446 "EHLO
	basal.nesselzelle.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2DQVCE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Apr 2012 17:02:04 -0400
Received: from localhost ([127.0.0.1]:47192)
	by localhost with [XMail 1.27 ESMTP Server]
	id <S340CE> for <util-linux@vger.kernel.org> from <thomas-forum@orgis.org>;
	Tue, 17 Apr 2012 23:02:01 +0200
Date: Tue, 17 Apr 2012 23:02:07 +0200
From: Thomas Orgis <thomas-forum@orgis.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: losetup -d --force for zombie loop devices?
Message-ID: <20120417230207.352c4ca5@orgis.org>
In-Reply-To: <201204171058.23776.vapier@gentoo.org>
References: <20120417100346.2a0b8301@orgis.org>
	<201204171058.23776.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/YRdXBWHZ2aCaMnkRZiQMs0G"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--Sig_/YRdXBWHZ2aCaMnkRZiQMs0G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 17 Apr 2012 10:58:22 -0400
schrieb Mike Frysinger <vapier@gentoo.org>:=20

> that's LOOP_CLR_FD returning EBUSY.  so there isn't much (afaik) that=20
> userspace can do here.  you'd have to start a thread on lkml first to add=
=20
> support for lazy/force loop device detaching.

Hm, I feared such ... now the question is if folks would support that
move. Well, one will not find out without asking. Perhaps I should try
to reproduce the scheme with another machine first. Not that this
situation is something that "just does not happen", except in my case.


Alrighty then,

Thomas

--Sig_/YRdXBWHZ2aCaMnkRZiQMs0G
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+N2k8ACgkQm0xSvNRG1SQKegCeITr64ENkukICBsr1P2dJmbL8
mQYAnRc5P/VvLyPXVeJKdXfjZlGHvsIS
=cjLC
-----END PGP SIGNATURE-----

--Sig_/YRdXBWHZ2aCaMnkRZiQMs0G--
