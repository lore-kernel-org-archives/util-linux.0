Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:61564 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab2LOBiO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 14 Dec 2012 20:38:14 -0500
Message-ID: <50CBD484.5080102@ubuntu.com>
Date: Fri, 14 Dec 2012 20:38:12 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: cfdisk can't handle out of order partitions
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I came across a very old bug report in deiban and ubuntu ( LP:
#107023, debian bug #464377 ) where cfdisk errors out with partitions
that are out of order. In fact, it seems it can't even correctly
complain that they are out of order, but rather says:

FATAL ERROR: Bad logical partition 6: enlarged logical partitions

I took a look at the code, but it seems it makes quite liberal
assumptions about them being in order, and needs a significant rework
to handle out of order partitions.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQy9SEAAoJEJrBOlT6nu75gJ4H/2gxIgcgyeN/4N9uD+Pmdwik
OEdg2pShEvpRoiJkqKcPRgd58g/SoEWr0ahFYRmOyP7zAqTKdMfMEslw4pBBRSx9
zOsHcaTTxXHdSLW5qGUALQnOUyvpE2shNgknfF9LLoBlNuS5LUf+WhmzqLwscxRx
s05xTe6zrgvg6uS6ew4XE2DVePjHEDCx+UNJ37ykx+SxR/9hb78w0dDxYykV/Cvg
eii9LLTG8a1AAguruo9mp7hVyzBFRr6D1j3pofXf41lHnxwQlUFavPSg5t58q/ba
ybO2F9Dt9fozsA7m3+7qEhVa28O+rDKjs13Zov20U42KBObFjW3yDPR4T3Ipahk=
=Pvmy
-----END PGP SIGNATURE-----
