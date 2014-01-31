Return-Path: thomas@archlinux.org
Message-ID: <52EB6B0D.1050500@archlinux.org>
Date: Fri, 31 Jan 2014 10:21:17 +0100
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>,
        =?ISO-8859-15?Q?Thomas_B=E4chler?=
 <thomas@archlinux.org>
CC: Phillip Susi <psusi@ubuntu.com>, util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
References: <52E91888.4080601@ubuntu.com> <20140130081651.GE22884@x2.net.home> <52EA5E6F.6040203@ubuntu.com> <52EA66CC.9070107@archlinux.org> <20140131091759.GA10498@x2.net.home>
In-Reply-To: <20140131091759.GA10498@x2.net.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JeHLO5pQTrGeuh473RnDpJE7rL6jRDhcA"
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JeHLO5pQTrGeuh473RnDpJE7rL6jRDhcA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 31.01.2014 10:17, schrieb Karel Zak:
>(I guess that dracut
> without systemd still uses the original switch_root.)

So does mkinitcpio when used without systemd (which is still the
default). We used to use busybox switch_root, but at some point switched
to util-linux's version.



--JeHLO5pQTrGeuh473RnDpJE7rL6jRDhcA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJS62sPAAoJEChPw0yOSxolVYMP/jyudNouFEdhGzANtYwGh3Ps
Eod7dTukzzGsKFMRE7sWD/EcLsICiFhA7bzGSR5kzR/LD5lixzom0nyEqrdMSdtW
OzUfO+jXOr/1Xdqp8Q86LT6rU4gywRDLrqe7Q/Dkya8nG/wMT7CVo5Ul/cqW083b
AbUXX8gqDtl+B/209afBYBkz42Ar/naMRrZIINRBdeuVWR07NtcRSg6xGoMSy/Dd
GTYFodM9YWeb9NycIQP+VooAROykkIcNn54qgaHV/Ce7sNWc4A/XYA62nWkBaSW3
c0kUxWusdej8S7ZpaAS0ntA+DkFziwce9J/R6wHvxVsyz5nGKWagdMHBYfR5Zymp
eDkSD2Dr/uiY0gKDosjPQrGit6l3liKjfBUIW1zPoUISBpgQlCqlWyB3w6/EtfWg
+toWzpGQ+bsKuZilyQv81kLlCrHrCahnGGuidKY4eYp/4l0H2WNKEoHlputMel1l
qFxH8ThMVe35qvayGjHJCli7iXhFJEw7KV8xxD50/FB1+QyCEL8VhR3CrxBbUBu/
ghZxgZKGawYpfzsquj2mBxxEtqkKNrWjsDQDaVz367zf3lWUaNH2lu+0XChy3uAP
MyI5wAp/0C8jCR0ABETbdRsZ+lSImwYntJ1frRKGPnKCpKR0Ms6PHVIR/7cn8o/s
tKVZFFjkI7eJX2bIemrK
=xR4H
-----END PGP SIGNATURE-----

--JeHLO5pQTrGeuh473RnDpJE7rL6jRDhcA--
