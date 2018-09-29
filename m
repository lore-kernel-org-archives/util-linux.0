Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39784 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeI2PIS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 29 Sep 2018 11:08:18 -0400
Date: Sat, 29 Sep 2018 10:40:38 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>
Subject: Future of dosfstools project (FAT)
Message-ID: <20180929084038.an6pfhnsd6tblejl@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bhtqwubaqu7r5vc7"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--bhtqwubaqu7r5vc7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Last year I did some research how Windows and Linux tools handle FAT
labels (boot sector vs root directory) and proposed some unification.
More in thread: https://www.spinics.net/lists/kernel/msg2640891.html

My proposed change for manipulating with FAT labels is now implemented
in util-linux v2.33, prepared new mtools version, and also in dosfstools
git (unreleased) https://www.spinics.net/lists/kernel/msg2645732.html

Project dosfstools contains de-facto standard Linux userspace tools for
FAT filesystems (mkfs.fat, fsck.fat, fatlabel) and so it is quite
important because of high usage of FAT.

But there was no new release of dosfstools since Jan 2017 and for more
then month I'm unsuccessfully try to contact maintainer of dosfstools
project (Andreas) about future of project itself.

I do not know what happened, if either Andreas do not have time or
something else...

So does somebody know what is state of dosfstools project?

Also there are lot of proposed changes (with patches) for this project
https://github.com/dosfstools/dosfstools/pulls and also more reported
bugs https://github.com/dosfstools/dosfstools/issues

If Andreas does not have time, can somebody else at least look at pull
requests and do some code review?

I have some other unpublished/unfinished changes for dosfstools, but I
do not know now if it make sense to invest more time in this project
when maintainer does not respond... if this project is active or going
to be dead...

If dosfstools is going to be inactive/dead, there is still mtools
project with provides FAT tools too and maintainer of it is now
preparing new bugfix version. So at least some alternative exists.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--bhtqwubaqu7r5vc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW686gAAKCRCL8Mk9A+RD
UvXVAKCr6iGBqFh8fo/05TIjyc5wayLyFACeNWmBCWH1icwfZ6yK20IaPZpNI+k=
=c8Sj
-----END PGP SIGNATURE-----

--bhtqwubaqu7r5vc7--
