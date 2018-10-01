Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41324 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBCj6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 1 Oct 2018 22:39:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so10011193pfi.8
        for <util-linux@vger.kernel.org>; Mon, 01 Oct 2018 13:00:32 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <404F3F76-402D-4E29-9957-429CB7D7ECFC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4596DF16-CEEF-4C6F-8E92-96CFCF730F45";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Future of dosfstools project (FAT)
Date: Mon, 1 Oct 2018 14:00:28 -0600
In-Reply-To: <20180929084038.an6pfhnsd6tblejl@pali>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
References: <20180929084038.an6pfhnsd6tblejl@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Apple-Mail=_4596DF16-CEEF-4C6F-8E92-96CFCF730F45
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Sep 29, 2018, at 2:40 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
>=20
> Hi!
>=20
> Last year I did some research how Windows and Linux tools handle FAT
> labels (boot sector vs root directory) and proposed some unification.
> More in thread: https://www.spinics.net/lists/kernel/msg2640891.html
>=20
> My proposed change for manipulating with FAT labels is now implemented
> in util-linux v2.33, prepared new mtools version, and also in =
dosfstools
> git (unreleased) https://www.spinics.net/lists/kernel/msg2645732.html
>=20
> Project dosfstools contains de-facto standard Linux userspace tools =
for
> FAT filesystems (mkfs.fat, fsck.fat, fatlabel) and so it is quite
> important because of high usage of FAT.
>=20
> But there was no new release of dosfstools since Jan 2017 and for more
> then month I'm unsuccessfully try to contact maintainer of dosfstools
> project (Andreas) about future of project itself.
>=20
> I do not know what happened, if either Andreas do not have time or
> something else...
>=20
> So does somebody know what is state of dosfstools project?
>=20
> Also there are lot of proposed changes (with patches) for this project
> https://github.com/dosfstools/dosfstools/pulls and also more reported
> bugs https://github.com/dosfstools/dosfstools/issues
>=20
> If Andreas does not have time, can somebody else at least look at pull
> requests and do some code review?
>=20
> I have some other unpublished/unfinished changes for dosfstools, but I
> do not know now if it make sense to invest more time in this project
> when maintainer does not respond... if this project is active or going
> to be dead...
>=20
> If dosfstools is going to be inactive/dead, there is still mtools
> project with provides FAT tools too and maintainer of it is now
> preparing new bugfix version. So at least some alternative exists.

If the current dosfstools maintainer is non-responsive, you could always
fork the project in GitHub, land the critical patches into your branch,
 and make a release on your own.  If the maintainer surfaces again, then
they can pull in your patches.  If not, then you are the new maintainer.

Cheers, Andreas






--Apple-Mail=_4596DF16-CEEF-4C6F-8E92-96CFCF730F45
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAluyfNwACgkQcqXauRfM
H+Cc7A/+P5AaNxOVq2Nf9I/rkxajuSt1LmUb0kc/o/bVRLzeHXHvKup2svrtDCoq
kcahTf4iAQRc6A0FIMen9USo3TihLpiS2OJ7oE25WUrhE66nlCAMhIpTzWuzX190
7CETWuGlyt93kOQI7DV5esrhxNwzVwh0uAMsNRjtcsjfg/eWn96sFZ3ywxro/0WC
/b+TwBWqFfkUdBBOPgFXK/c4HHV5Y3xjHPHhr98bWFRbSZgibkhokNjXTbBpJHGe
+Srmm+fgfMmZU12+IedlgQyFewcM+3G/kb5ahXvn+6PDEeUAPD2QBqDppuQSBfq8
E04mqOiIMIV5tuX0lmN5fgdAT3PILjBzzLM32a7Y6B9cTH+9s3d88db4kQaUfa16
V66Ad0G+1C8N2Isbf8XQgzhzJX5kxNqEqr53GVoiAiy5Et9odcH9BjS7YuWfSyE+
1Q5SZDOH59dW+y/g4Q35GFLVrxOlBxjwy+X3R2NzdlohLbvS0Xh0OM/IT7M73vad
w/G6ix2T95fRJeM8Onl2X/6bvGJwzSHz8TFrwuevmN4bY+p4y7ShLJey9AxAH5Pi
7q0CtHrjoZvX587VYJxgeTz9tQgXZnNhEbm+Y05NzNUrlJ6r77Gz8+MRLxfdLCT8
QmU2SIiwber7/h1/QxZgMmKx9EYzP2aVviiFhJITC3pQWRJEXso=
=En8f
-----END PGP SIGNATURE-----

--Apple-Mail=_4596DF16-CEEF-4C6F-8E92-96CFCF730F45--
