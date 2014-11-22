Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38830 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbaKVHeh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 22 Nov 2014 02:34:37 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so6408191pab.32
        for <util-linux@vger.kernel.org>; Fri, 21 Nov 2014 23:34:36 -0800 (PST)
Received: from [192.168.1.123] (CPE-58-160-108-172.tyqh1.win.bigpond.net.au. [58.160.108.172])
        by mx.google.com with ESMTPSA id bv3sm6639140pdb.32.2014.11.21.23.34.33
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Nov 2014 23:34:35 -0800 (PST)
Message-ID: <54703C81.7000902@gmail.com>
Date: Sat, 22 Nov 2014 18:34:25 +1100
From: Joshua Rogers <megamansec@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: off-by-one issues in login-utils
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vUG6MhCSm5AHJUJ5pwwkxOHsEXJFuiBtg"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vUG6MhCSm5AHJUJ5pwwkxOHsEXJFuiBtg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've noticed a few off-by-one issues in login-utils..

login.c:963: strncpy(ut.ut_user, username, sizeof(ut.ut_user));
It should be sizeof(ut.ut_user) - 1.
Or, something like
ut.ut_user[sizeof(ut.ut_user) -1] =3D '\0';


And on line 275:

        memset(&ut, 0, sizeof(ut));

        strncpy(ut.ut_user, username ? username : "(unknown)",
                sizeof(ut.ut_user));


I can't see anywhere that adds the final NUL-byte to ut.ut_user.
If I've missed something though, feel free to ignore this.


Thanks,
--=20
-- Joshua Rogers <https://internot.info/>


--vUG6MhCSm5AHJUJ5pwwkxOHsEXJFuiBtg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJUcDyBAAoJEJCcj5QpbmADRmAP/RKE5s1xSpcE15zoJs43nsm+
en4iP2GCHT7Cwl6ERaXub1V3c/+ig/4d2C3GGFYTRQDG4UpgjiPjGp6DX8ZGYWmg
d92Svmr75+/dD5xIF81hcnPp9vrIl+J5mc+4GqbHj/nwCnuy7FX4+rhx3v4uwl+5
N/qi6BIJI4CvQZbcEHO+j5IDigQ6GLpDP97htiiV/KVE8SPCKmE5EhFYX+8z/Tzz
QfHHP1gv+FK/wedtaSAjd3ElEbM7ckk12sKToDyEkCnCrIBjeyrVMdCbTSQkcUP4
O7YV2ukAS7AD8o310Ti17lkLeFjVIwqL/lwNtcpeV9tn2TS8Q3jtsltcnteaBy6e
BkG14xDKkpCtPrxEUMiD+r59fvIofnk3J+5g/FCS4BuOIR3WNQ2koFm37JUYKbl9
HKlWoaMD7iT0zWltPY8Ny4z8PoCp1VpvKIUOSnhG2mDGwSjDsd7X/23GKsp26qkd
IkZdjbTx6WEwTYgCbhwCEaNO1SlxjNangWo76XT6Z3ZMSuw59fnjtEi/nVNB+pFv
CAdKcSvq6416UnI7VuYzHyisvpoBUSYrwIIyo9dTx0yhTkFGpTPXpZfkDhKpe+24
xcvCD29q7uYvAC5aPx2w9fEbiyOqujrkPWWlgROnfIVwiRBW2pyZFoM0eD8zhaqy
EukbVC1eFdoGqqvzl8as
=eF81
-----END PGP SIGNATURE-----

--vUG6MhCSm5AHJUJ5pwwkxOHsEXJFuiBtg--
