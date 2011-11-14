Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:58492 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab1KNGXi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 01:23:38 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Petr Uzel <petr.uzel@suse.cz>
Subject: flock in 2.20.1 can no longer lock the file it will execute
Date: Mon, 14 Nov 2011 01:23:38 -0500
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2757790.O9vR7ahjq3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201111140123.39789.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2757790.O9vR7ahjq3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

i've been using a trick with flock to add locking to all of my shell script=
s. =20
basically, i take a lock on the shell script itself:
	flock -eon ./test.sh ./test.sh

with <=3Dutil-linux-2.20, this has worked fine.  but starting with 2.20.1, =
i now=20
get -ETXTBSY (on ext4, but i doubt that matters):
	$ echo '#!/bin/sh' > test.sh
	$ chmod a+rx test.sh=20
	$ ./flock -eon ./test.sh ./test.sh=20
	./flock: ./test.sh: Text file busy

the only commit made to flock.c between 2.20 and 2.20.1 is this:
	commit 75aaee08f06b92d119ed827c53d1af5474eb16ff
	flock: make flock(1) work on NFSv4

and indeed, reverting that made my life happy again.  reading the small pat=
ch=20
shows the obvious flaw: you can't open a file for O_RDWR and attempt to exe=
cute=20
it at the same time.
=2Dmike

--nextPart2757790.O9vR7ahjq3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOwLPrAAoJEEFjO5/oN/WB8k4P/i5/iT/ldKJKAQjrVja9fFoz
3qREgGhjMTSJnaY3nmTtFWCTslmJrS+wWHu4+RKUUNBZqDBKI1VPKK5QqNYS2hQJ
haPszVY8ynnH/qyalfQjWv8bpDEkbpbyx6xytX9DqP/qHU0A8tTZxdPSpYQRiFgZ
BibnoH59Xy9MQ03UJt9Pj8/Up4XO25YWIndPVmCzRfoeN/KJblAkW1mGoy2xmtv7
zn+e912px9WVV8SnoP5buHOzhRJ8+j/HWH/ldWBbI0GfB90Qzgc0Tr8aB3opvi89
RGpYZvB5NISBr7AhYG1dgQaV+Fnr43hDgK8q/YladPX9bs9e1R7BZMYnTITYcnqu
4Sc1NscezdzRPwLfE9imTBdMvN2Y/3VY5k4CarCepEjQMa2A4yu/fRBG3dqwewj2
6ga3+ZdhDOMG5FQTUurDvVPOFYqzjkRCBytb/4ulgtFpDZZXuv6z33StIutZoFwH
cwvAU18kKgKx0Eq1yzyCwSM/yjjc+sxvzC/om4IS2lrusNCk2dw7QGA4MmKoTCeQ
+7Igm1KYE7tIVI9VO05sK3bFIU85jWHWGeEarosE9nZRyCuT6ZYNXpuXVAEBf3OI
76JGhu9ihZ77W7GH3g5SOmCGGJItUkO3d99Y7VZRUycHIkwI9UeLH6WBWbyMgAfy
EXKYtP07McFfgvpRdG1G
=x/Xl
-----END PGP SIGNATURE-----

--nextPart2757790.O9vR7ahjq3--
