Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:52886 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbbKQU6w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Nov 2015 15:58:52 -0500
Date: Tue, 17 Nov 2015 15:58:51 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: user namespaces: user mapping
Message-ID: <20151117205851.GL31395@vapier.lan>
References: <n2besp$j56$1@ger.gmane.org>
 <20151116041931.GC5949@vapier.lan>
 <n2ctjg$1d0$1@ger.gmane.org>
 <n2dpk4$p47$1@ger.gmane.org>
 <20151117043229.GH31395@vapier.lan>
 <n2edon$mfu$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
In-Reply-To: <n2edon$mfu$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

this really isn't the place for logical fallacies.  it is impossible to prove
any code is entirely bug free (let's ignore the theoretical proof based systems
as they're entirely irrelevant to this discussion).  if you have any actual bugs
to report, then do so.  otherwise, you're wasting everyone's time.

i think we've all been pretty clear that making unshare, as-is, setuid is
completely wrong and, frankly, stupid.  it's trivial to leverage privilege
escalation after that point.

as for enhancing unshare to be aware that it's setuid and thus drop root back
once it's done making the unshare calls, i don't see the point.  user namespaces
work already and don't require setuid and are widely available.  if you don't
like userns, that's your choice, but not our problem.
-mike

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWS5ULAAoJEEFjO5/oN/WBgh0P/RAEGxWDvD9YlMAK9gfuZlJD
v/zung4MmLPGwfLLH0r1EmzTVUpsNrtOw/o+0l4quH6KcBgrXgs18dOEU3ew4ZXm
/erkOnPQ5DxKI3R/p9b1qQMkvz9SeG7Z8T/l2EGne0e9i3tHKWBL/HSswwDz1q3m
2mnK8fkCXTRoOoM4M7XVNC4JzGIa0zavzQ28Eb35KpDFEsSIpFz82uMSQ1NfKTH0
OVGp5NHVTu1PCm54vqwYokZnDD38xX6aLmpzGj8r5zPGYxZfjh4gRTCn8XR70a7c
M3hhmUXW5qopWfwgCWvUCJSQxFGNYS34rGcUHIEUGqQJ5DMzoqw+yjjO2Oji8qa/
BWbugtd+RUFWeOqUYEsPLgNLyfq4sZcBxVOoCR49Xhr44wz5Ir77B0/ybeyX5cJG
7kifKu6HWw6vwLw/7SNo/3nZnFheEixo8+6A0pq3KjnL+99UztfoZNa0BA0NIZDS
RZYvtzZTQ/uEjruYWEG4HJhVeWJDhHj2E/UeLnk2XCUjtSDtiT9+7axopfo7A+/6
G6gfIkCML4Ro0Xrwts/tAay/ZSSHV0h1PEj+VuW3/WtLC3z/toE7EUqQkG5Mz7HX
WEkBrURblG2G4qsl/exAmhJnVRZal/ZLaHbLpbDLvnCn4kVnM8o3YGJz38wuFK4x
/m9Td3ec+BsphmqS+mfz
=kAcq
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
