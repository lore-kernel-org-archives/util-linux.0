Return-Path: util-linux-owner@vger.kernel.org
Received: from master.debian.org ([82.195.75.110]:34702 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbbEUIjb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 May 2015 04:39:31 -0400
Message-ID: <1432196678.28686.58.camel@debian.org>
Subject: when would blkid success but not filesystem type?
From: Paul Wise <pabs@debian.org>
Reply-To: 784709@bugs.debian.org, util-linux@vger.kernel.org
To: 784709@bugs.debian.org, util-linux@vger.kernel.org
Date: Thu, 21 May 2015 16:24:38 +0800
References: <20150520145904.3e4645dd@patagonia>
In-Reply-To: <20150520145904.3e4645dd@patagonia>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+SWuL+3UdU2Pb6LUpbqQ"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-+SWuL+3UdU2Pb6LUpbqQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In https://bugs.debian.org/784709 J=C3=A9r=C3=B4me Kieffer wrote:

> Here is the answer for the 3.16 kernel:
>=20
> jerome@patagonia:~$ sudo blkid -o value -s TYPE /dev/sdb4
> jerome@patagonia:~$ echo $?
> 0
...
>=20
> The output is the same on 3.2, as you can see on attached images.

Anyone know when blkid would return success but not the filesystem type?
This is util-linux 2.25.2-6 with Linux 3.16/3.2 and an extended partition.

--=20
bye,
pabs

https://wiki.debian.org/PaulWise


--=-+SWuL+3UdU2Pb6LUpbqQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVXZZLAAoJEDEWul6f+mmjEeoQALLECyHTml5PW7dN/SI2adB5
k2HDDyx92TwEGLczVpZBZhyuAS2m6hA6Drx/WlVaQyiTur9rPjxp1bH1zR1EKHMD
sIniAsutRS5yRge/hnSGIs6WutVWygtyEHHJQqYqfk2wjdD454H0FUa4vNRgdmUC
+g+W4QtVbK1oUnrTM90MuLnrAipbQgr+TWjx+kUrmUKvW9cHVBPoKuCQKWx5UFsK
kHPRX6EmM4bLNGCvAMlSnO0VjosEo99eNN0pd1Wzvsfl7k3uZyx5qkZ4OB/fsXva
9s7HYKvHFlo64dYVd4pBlRj+yL4uM8Z96kK468UuOhqiFb2yh7Cg8vlVoXMX/tqM
2O6k+WmOjSCZ0cx1mQ/NHFcURxHaFwp8iVeGRTXdaLH9V8g00m8P2aHQOI9cKlhI
bbrtyGCTcMt5BbpKOQv7/cG7xlJWCCPeQsqZkXRy67HxgMBGpwNGcqK8es07fgDy
4PtsUXCEZ4gyPcfOyecpa6eSzdCKqZALMlVpC9YebVlfOHzjD4NJ+8iNcRWDto8e
enpv9NB2ESAthzuAaOnWA69e/XfafQUSBX6UHy7ZulD/Tqm0tjBx+dXSL/Xw5hYh
yWQW99IBSz7Qm4e6SaeMCdYR9W6q1hIiqwXVemeMNDycsmO4tzJ2T9cmCksV4nJ0
49aH1SvHYiz/mqTE2T6m
=Nadu
-----END PGP SIGNATURE-----

--=-+SWuL+3UdU2Pb6LUpbqQ--

