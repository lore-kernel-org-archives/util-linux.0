Return-Path: thomas@archlinux.org
Message-ID: <5343D600.7000507@archlinux.org>
Date: Tue, 08 Apr 2014 12:57:04 +0200
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>
CC: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <20140407104304.GJ22126@x2.net.home> <201404081225.21563.sweet_f_a@gmx.de>
In-Reply-To: <201404081225.21563.sweet_f_a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MRD6Al6rHrj3QCLdgktqnVitmW2vCRILM"
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MRD6Al6rHrj3QCLdgktqnVitmW2vCRILM
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 08.04.2014 12:25, schrieb Ruediger Meier:
> Hm, isn't this a bit over the top? Adding a script just to=20
> call "fstrim -a" automatically?

It's a common task. I was getting tired of having to add this on every
single machine that I set up.

> Should we also add scripts for "mount -a" or "fsck -a" or "swapon -a"?

And what purpose would that serve? Did you just take random commands and
add '-a' to prove a point?

> And wouldn't we also need to add "example crontab" lines for non-system=
d=20
> systems! Sounds a bit ridiculous, right?

You can add them if you feel like it. But this is not an "example" file,
it is ready to be used.

> I think it's the distro's or admin's job to write and add the scripts=20
> for filesystems maintenance etc.

That's ridiculous. We finally, for the first time ever, have a unified
way of creating service definitions that can be used unchanged in all
relevant distributions (except Gentoo and Slackware, of course). The
main advantage of this unification is that they can be shipped and
maintained by upstream projects - after all, the upstream projects know
what services make sense and how to start them properly.

> BTW fstrim.timer is missing in "make dist" tar ball.

Sorry, you are right. I'm a bit lost in this build system, Karel
probably knows how to fix this.



--MRD6Al6rHrj3QCLdgktqnVitmW2vCRILM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTQ9YAAAoJEChPw0yOSxoltOEQAMOYiy2QRZauakzZgjFmC9eh
9Cww4ABzF5Vs4qDu5gXv/m+mHZHJwNkH0tYNRqERtcD67lWKE9RaTFILzs8pQCab
dvs6x9VxDlwDgEbMpimIg4wjCsAFrbGlUGE1X7I2ZxE9iNflL8gRdaKO4kIgP4Ro
8MxbqOr3UlYvhy2mDEHiCLzRTjVMbPGq+vspBNbShMh0ERs3RrvP+RmOp3qS3+Ht
pnf1JN2UQTjTQO2PU1VWfp/uv2YEY5WoN2elXW8+cK+t93bttd/lSPokyLz+P2An
wB8WsKHyDHOFNq1+egg4NRgbUiC3Qv8GbsnhNnADloptKFGYbhM+rQ01vesjMTSO
OdlJe2i1LE+eCnNcxcwaWdk1cLhreb3kgrz2VhUnSX6OhFJdfaHqCYu+clV8YU6M
BXPIwi+rgQv/JUb32d+NjLykD22FO4iTBiLWNeKxkhI5qCH8f/ao9UPHPHGRphHT
eRhhnen6M9x8aOiiLrd7EOOBeuL5nqt0VvvMsgTf2tYoKj/nMQB2fOulyShwZCbO
vTBEXHqv5sIbXjQwTnt4ad8Q8rEBdm9PTzTCMHGzhpJOopLM3bndgPbr6SCQrk9u
NEZLq6QZxJFWqatv8QmjfckjdE/VlI6R0QmEpy8mkh+IJm2mQ6smw/m2vvqEmBkR
XJANqcNJkgVhC2auCLz8
=OkuH
-----END PGP SIGNATURE-----

--MRD6Al6rHrj3QCLdgktqnVitmW2vCRILM--
