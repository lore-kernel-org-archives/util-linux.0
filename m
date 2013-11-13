Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:54290 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136Ab3KMQG0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Nov 2013 11:06:26 -0500
Message-ID: <5283A380.6020909@ubuntu.com>
Date: Wed, 13 Nov 2013 11:06:24 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: fdisk expert print lists wrong start sector for logical partitions
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The expert print function shows all logical partitions as having the
same start sector as the extended partition that contains them.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSg6OAAAoJEJrBOlT6nu75Xm8H/1gJG62oJVo1+LsACZpOQJz8
D2/TwwZgAtrxCS6rOE0zq+tA+g2+4SZ611XiNBO3YNZrYRNxp6RpPehbSUFVGLI6
uuFFKobZ5x+xIZVSH6ZV4lO//lEpRM1YN2lhAMRS2svfpoYeYmmLBpa683WNgwvX
Ry86GEBrYCA8bRzqwovhtASgPLH/C3U+iEYbASPdUJpUxQL6CjPmAL6KsL7/EZJg
O8W96cl4B3mubeyIUsAfiIZaYaQwM3A9kdGL9pmMztw4Pl/RwjzCgzNI3ZJ7b7z3
mktjDX3DISvVfyu5+dQQfRj0V0aDR3xFTTOGyb+1i9WJTRa4s/qnH96vo13zGWU=
=zRsJ
-----END PGP SIGNATURE-----
