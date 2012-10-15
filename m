Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:37842 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab2JOCOa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 22:14:30 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 15/19] libmount, eject: replace index() and rindex() with strrch() or strrchr()
Date: Sun, 14 Oct 2012 22:14:36 -0400
Cc: util-linux@vger.kernel.org
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi> <1350246070-10544-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-16-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6555920.fSvSkjU89N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210142214.36896.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart6555920.fSvSkjU89N
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sunday 14 October 2012 16:21:06 Sami Kerola wrote:
> Both index() and rindex() are legacy functions which may be withdrawn in
> a future.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart6555920.fSvSkjU89N
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQe3GMAAoJEEFjO5/oN/WBatEP/0kJ7EKmdhHbuh16qDk+0ZeF
rXAj8Tw0p7GprmtNJhyaHhX/s8pZopdE7Tf0AoBXPIBrYhEdoO6WZ8gJdgRXE1k3
E+kWq+DRwBZ95aAMJLIlqMw/05UMqeA9Jcd5PY3D6ox47oUC49PbnBIIqaeUOVvV
mWoA390cZhzk81fx1N5OfHGHPk3mqbjVdCmjRkHNsbEVyeTm8OmF2R6SYStdadQw
+KqflTVCJXAZ8xAdx7VtFkV14bWrloMLyQjXATKrkvElaM/8qftLDjqvwvCcEYNx
PVsEosGBV11iC/Nqq59RCe/GcQ/lIzs/IsacmOYv27J8FZuZddSUWpQbrUNv1I8y
M1OeA6itZITCLq1qIb6VfUJeXY1vsBMegsELBB8YAXMiJtCZmtcupovWaoc7tyrQ
+cQMsm0RPGV3cZlH4VXKi+eDXu8fq8TSrV9SNH1fYZ6Y9DoBkZCvaV6l6yE92+3k
ZEAwG50nlVxTnujgi0UJlnvFt1ZWYUNjpzhCYn3rvXrQnmpymt6R2v8v84WRBmN+
41WtMkWNH3muty1Ef/5Udfui11uoqOVDYTsqtouSgjmzshMF+oUC4y48q6dDElv6
HQQcYZJifcMMpENlHd41dwWOhNCGIr+XBI1SQ/5/2GC9oViH8saQN7DCvSCaW9LF
q/WbeS4rAdbjEXRln2/Y
=5p6R
-----END PGP SIGNATURE-----

--nextPart6555920.fSvSkjU89N--
