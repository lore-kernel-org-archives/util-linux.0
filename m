Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:40307 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab3KAVCD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 1 Nov 2013 17:02:03 -0400
Message-ID: <527416C9.9020702@ubuntu.com>
Date: Fri, 01 Nov 2013 17:02:01 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: blkid: reports swap version + 1
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

blkid adds one to the version number it reports when probing swap,
saying version 2 for swap version 1, and saying version 1 for the old
and no longer supported v0.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSdBbJAAoJEJrBOlT6nu75xhIIAMR4wlDO1vil5CQ4vzd3tDpP
CayY4eP/+zrtzlyiBeITzg3pCw58kr1m2rOvtMOHE+c6EBjqA5LjNz6SwZN+P7pa
6Aj0roZfg4uzQWX/QmoSXaYnW7tzoZSvpWqLLkmagAzncxFTx/A3dzX94tSbk4/7
f5IcPFZVV+8fg22VDII04WrVk1ilX7Nf7ct9TNj0VpVtunIgYPndE3LgE2+SvDJe
TTZBK7AZrn+U0yMcYDagzIzYFEZAquYhmg0Q8zT731IeSTdet6gAUpBuqKDf7v0n
PmAXOsL2Zkk1PcJ3nHJwjSs+3TbuvU4HUwem98LIYjyE/ifXWFzg4lV4Eag/QAs=
=PNbL
-----END PGP SIGNATURE-----
