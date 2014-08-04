Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:53463 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbaHDL2T (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Aug 2014 07:28:19 -0400
From: Martin Steigerwald <Martin@lichtvoll.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix re-enabling of cursor with slang also after pressing Ctrl-C
Date: Mon, 04 Aug 2014 13:28:11 +0200
Message-ID: <1419379.tzkKhjxti9@merkaba>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6067617.Ml5GFPCtI9"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart6067617.Ml5GFPCtI9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

According to curs_set(0) in ui_init() I think curs_set(1) belongs into
ui_end with in die_on_signal() also gets called on SIGINT or SIGTERM.

This should complete the fix made by Andreas in commit 4f4daf8f.

I could not yet test the fix as building current git fails with:

/usr/bin/ld: sys-utils/swapoff-swapon-common.o: undefined reference to =
symbol 'blkid_probe_lookup_value@@BLKID_2.15'
//home/martin/Linux/util-linux/util-linux/.libs/libblkid.so.1: error ad=
ding symbols: DSO missing from command line

Will test as soon as I found out how to fix this build issue. Benno
reported it already on mailing list.

Addresses-Debian-Bug: #757000
BCC=B4d there for reference.
=2D--
 disk-utils/cfdisk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index dfdaaf0..536132a 100644
=2D-- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -525,6 +525,7 @@ static int ui_end(void)
 #else
        mvcur(0, COLS - 1, LINES-1, 0);
 #endif
+       curs_set(1);
        nl();
        endwin();
        printf("\n");
@@ -1966,7 +1967,6 @@ static int ui_run(struct cfdisk *cf)
=20
        menu_pop(cf);
=20
=2D       curs_set(1);
        DBG(FRONTEND, ul_debug("ui: end"));
=20
        return 0;
=2D-=20
2.0.1


Thanks,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
--nextPart6067617.Ml5GFPCtI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlPfbk8ACgkQmRvqrKWZhMdzvgCcD9FWVycvSDl77BQZtlyypc+q
CeQAnj9J0VFqGBi1AEz38XycKUGYH9wD
=EZkP
-----END PGP SIGNATURE-----

--nextPart6067617.Ml5GFPCtI9--

