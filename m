Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:47584 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbaHDMBo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Aug 2014 08:01:44 -0400
From: Martin Steigerwald <Martin@lichtvoll.de>
To: util-linux@vger.kernel.org, Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] Fix re-enabling of cursor with slang also after pressing Ctrl-C
Date: Mon, 04 Aug 2014 14:01:42 +0200
Message-ID: <1469621.AbYYNxNq4q@merkaba>
In-Reply-To: <2432624.0NNcbHJWc6@merkaba>
References: <1419379.tzkKhjxti9@merkaba> <2432624.0NNcbHJWc6@merkaba>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1642347.IsdN3o6USM"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart1642347.IsdN3o6USM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Montag, 4. August 2014, 13:53:34 schrieb Martin Steigerwald:
> Am Montag, 4. August 2014, 13:28:11 schrieben Sie:
> > According to curs_set(0) in ui_init() I think curs_set(1) belongs i=
nto
> > ui_end with in die_on_signal() also gets called on SIGINT or SIGTER=
M.
> >=20
> > This should complete the fix made by Andreas in commit 4f4daf8f.
> >=20
> > I could not yet test the fix as building current git fails with:
> >=20
> > /usr/bin/ld: sys-utils/swapoff-swapon-common.o: undefined reference=
 to
> > symbol 'blkid_probe_lookup_value@@BLKID_2.15'
> > //home/martin/Linux/util-linux/util-linux/.libs/libblkid.so.1: erro=
r
> > adding
> > symbols: DSO missing from command line
> >=20
> > Will test as soon as I found out how to fix this build issue. Benno=

> > reported it already on mailing list.
> >=20
> > Addresses-Debian-Bug: #757000
> > BCC=B4d there for reference.
>=20
> Scratch that.
>=20
> Fix doesn=B4t work.
>=20
> Cursor is displayed on regular end, but not on Ctrl-C.
>=20
> Don=B4t get why tough.

Patch may still be correct, but SIGINT handler is broke:

martin@merkaba:~/Linux/util-linux/util-linux> sudo ./cfdisk [quitted]=20=

regularily]        =20
ui_end called!
martin@merkaba:~/Linux/util-linux/util-linux> sudo ./cfdisk [Ctrl-C]
martin@merkaba:~/Linux/util-linux/util-linux#2>

Its supposed to call ui_end(); but doesnt as above example demonstrates=
.


 785 static int ui_init(struct cfdisk *cf __attribute__((__unused__)))
 786 {
 787 =BB=B7=B7=B7=B7=B7=B7=B7struct sigaction sa;
 788=20
 789 =BB=B7=B7=B7=B7=B7=B7=B7DBG(FRONTEND, ul_debug("ui: init"));
 790=20
 791 =BB=B7=B7=B7=B7=B7=B7=B7/* setup SIGCHLD handler */
 792 =BB=B7=B7=B7=B7=B7=B7=B7sigemptyset(&sa.sa_mask);
 793 =BB=B7=B7=B7=B7=B7=B7=B7sa.sa_flags =3D 0;
 794 =BB=B7=B7=B7=B7=B7=B7=B7sa.sa_handler =3D die_on_signal;
 795 =BB=B7=B7=B7=B7=B7=B7=B7sigaction(SIGINT, &sa, NULL);             =
                                                                       =
                        =20
 796 =BB=B7=B7=B7=B7=B7=B7=B7sigaction(SIGTERM, &sa, NULL);


 662 static void die_on_signal(int dummy __attribute__((__unused__)))
 663 {                                                                 =
                                                                       =
        =20
 664 =BB=B7=B7=B7=B7=B7=B7=B7DBG(FRONTEND, ul_debug("die on signal."));=

 665 =BB=B7=B7=B7=B7=B7=B7=B7ui_end();
 666 =BB=B7=B7=B7=B7=B7=B7=B7exit(EXIT_FAILURE);
 667 }


 517 static int ui_end(void)
 518 {
 519 =BB=B7=B7=B7=B7=B7=B7=B7if (!ui_enabled)
 520 =BB=B7=B7=B7=B7=B7=B7=B7=BB=B7=B7=B7=B7=B7=B7=B7return -EINVAL;   =
                                                                       =
                                        =20
 521=20
 522 #if defined(HAVE_SLCURSES_H) || defined(HAVE_SLANG_SLCURSES_H)
 523 =BB=B7=B7=B7=B7=B7=B7=B7SLsmg_gotorc(LINES - 1, 0);
 524 =BB=B7=B7=B7=B7=B7=B7=B7SLsmg_refresh();
 525 #else
 526 =BB=B7=B7=B7=B7=B7=B7=B7mvcur(0, COLS - 1, LINES-1, 0);
 527 #endif
 528 =BB=B7=B7=B7=B7=B7=B7=B7printf("ui_end called!");
 529 =BB=B7=B7=B7=B7=B7=B7=B7curs_set(1);
 530 =BB=B7=B7=B7=B7=B7=B7=B7nl();
 531 =BB=B7=B7=B7=B7=B7=B7=B7endwin();
 532 =BB=B7=B7=B7=B7=B7=B7=B7printf("\n");
 533 =BB=B7=B7=B7=B7=B7=B7=B7ui_enabled =3D 0;
 534 =BB=B7=B7=B7=B7=B7=B7=B7return 0;
 535 }

Thanks,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
--nextPart1642347.IsdN3o6USM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlPfdiYACgkQmRvqrKWZhMfLHQCfaNGmhIX21wj9uMWmEr8nEoSN
8sYAoLybOrrRlMlCeBREC4MGfJ946ujh
=L5Cf
-----END PGP SIGNATURE-----

--nextPart1642347.IsdN3o6USM--

