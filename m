Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:55580 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab3JaOVL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Oct 2013 10:21:11 -0400
Message-ID: <52726756.8060205@ubuntu.com>
Date: Thu, 31 Oct 2013 10:21:10 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: script input redirection / eof handling
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I came across an old bug filed in debian about script being redirected
from a file misbehaving.  It seems that when the master ( input )
process hits eof, it exits immediately, orphaning the child ( output )
and user processes.

I believe the correct thing to do is signal the eof to the user
process and wait for the children to exit, but I'm not sure how to
make a pty signal eof.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJScmdWAAoJEJrBOlT6nu75JIQH/1Eqt6gsG+vKGc8xpybIE6F7
UGgo8sLyn++PE3U6MZQcsWj2nHZ6p76uHOp4Kn1sk8xrb2zetueQTF1idtgJO7nS
PKhwbfInD3ocSuEQB1HygMmKTKuXT9qYCBj18AT9ZQp7eQ5ocz+nvNnGHQuR4KPR
/CsI0D0/BnTO32ayh6qgE1HtxD0sUY4K1Qw3MyyChINwFAU9q8p3Y9Lz5RqQTTZk
2j3kc6jDdNaGy1b6w1exhEMrhs7zC1LRvz5GhqM+ODVAN/YiMh4eKYH9a4OrYXru
l8Df0gDWNRrQhqrJxvOMKph/DZO1sZEZP3ZG/kOXak/cpbHVy0MkGepP0qId91g=
=ZaJO
-----END PGP SIGNATURE-----
