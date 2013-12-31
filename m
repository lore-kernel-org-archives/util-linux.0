Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:57046 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab3LaCw3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 30 Dec 2013 21:52:29 -0500
Message-ID: <52C2316C.6010705@ubuntu.com>
Date: Mon, 30 Dec 2013 21:52:28 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: nilfs2 backup superblock detection
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Just noticed that the nilfs2 blkid probe code does not check for the
backup superblock, so adding that might be nice.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJSwjFsAAoJEI5FoCIzSKrw190H/RHpiepClffvNmIjnxVUxd2V
wEeEDmzFACVjL8TPH5DFf2y6fDe3BS7lHVk2teAyRpawfIi3/KShTJ2onnXJ7RCj
/QpJau+osdv9MpLlhazc2bAdgWc/06h6vHpBZzjWRdX6UjCVd4SCZ/YP7r+h0boM
ipo8jCVooF361TTg0cUOVPA+N85s8dpsoj6xXChjmr9jOgOFoi8tEgybfUmLM6/y
gTne+aR8YOiE4ldD/Y+7wf56fze0OqkXMZA5kR9cDI5a/gABqmiZYxA1T789rvsn
Im5DXTxeOxPB+9aDURAx7fLFoT3uIJB87cqjwgseAFc9tVWFTZ7lvsPloJHrWH0=
=32Jn
-----END PGP SIGNATURE-----
