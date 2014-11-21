Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43265 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbaKUVUp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Nov 2014 16:20:45 -0500
Date: Fri, 21 Nov 2014 16:20:44 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Lutz Vieweg <lvml@5t9.de>
Cc: util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: fstrim on newly created filesystem tries to discard data beyond
 the last sector of a device
Message-ID: <20141121212044.GB32316@vapier.wh0rd.info>
References: <m3qnrg$5gc$1@ger.gmane.org>
 <m4f77a$ivg$1@ger.gmane.org>
 <m4nrjt$ghs$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
In-Reply-To: <m4nrjt$ghs$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21 Nov 2014 18:09, Lutz Vieweg wrote:
> The relevant strace output of the above fstrim command:
> > stat("/mnt/PFexp1", {st_mode=3DS_IFDIR|0755, st_size=3D6, ...}) =3D 0
> > open("/mnt/PFexp1", O_RDONLY)           =3D 3
> > ioctl(3, FITRIM, 0x7fff0733a4c0)        =3D -1 EIO (Input/output error)

that hasn't decoded the ioctl (send a patch for that), but guess is that yo=
u're=20
passing down the default:
	range.start =3D 0;
	range.minlen =3D 0;
	range.len =3D UULONG_MAX;

in which case the expectation is the kernel layers will take care of trimmi=
ng=20
everything and not die when it hits the end of the device.
-mike

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUb6ysAAoJEEFjO5/oN/WBOh8P/1qcmhNrL1o7852I2fkKfjDD
mxNYBbj9dpE4BX+bmFhzhtItFFc1X1AvVcGtGuthnspNCPAY5hBz8y/Aktn7jPE2
IK7j8DW0NXwFr+urksWmxINrfRckrrCGDboeWA4tqkcOCqsFig9aj92yJA5UOyM0
nLhhKklP04f25nPcrSeWcBpsWoDWiKH7h3p9LdGPFG9J/IY1vc6n4UjQUBuRO+d2
e43AY9QpWUiKh6Jf+Efvvck6Kjyb4qGSpSlqyctjCJoC8NCp8kEaHqWmJflfr/Z4
iThud7ARDKjyHndtXWu/ULef2cQWSrbHOlQpUXsFBpQwtQV8ubXagxJBSEbednpp
Q0LXWJ4azP5FJKeJ7+Xt6UjphaoNk3fVYEqtymkG8JURqPL+MKPRoxFFLLFu8k++
mhpPzqM+/aYMdOb0SMNxBMPRIfktfEHAoUBWbePSEL7YufyPmT+N5BqEGzRV6Of3
1TlDuUlS+VSTPiUuF6pj/62/PYTjTAkecsAqBdn2NCe2VaM0YDJVDON9mYs1wlMD
6oQsjCjM6DlEM0Zpybm2H4Wu91z02IEfllEsd2CPfOk1yzUL8e4f/vqqr3ce/dFP
DsM2ga7ZYqKtTZ+mHEqSO9s2gXqmk/XSu7XOHTASbKhgrDRlDQ0RKHCmyCMZ7g+a
mWvWsjIf8XdTJJXE9o4N
=ChPN
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
