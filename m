Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:45267 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3KANhA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 1 Nov 2013 09:37:00 -0400
Message-ID: <5273AE7A.9000004@ubuntu.com>
Date: Fri, 01 Nov 2013 09:36:58 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: fdisk shows sun end sectors with +1 error
References: <52728FCE.2050003@ubuntu.com> <20131101112340.GA23604@x2.net.home>
In-Reply-To: <20131101112340.GA23604@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/1/2013 7:23 AM, Karel Zak wrote:
> Oh, excellent catch -- it seems like pretty old bug (I see it in
> v2.9, year 1999) ;-)

Yep, I'm slowly working my way through the massive pile of debian bug
reports and found this one from 2006.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSc656AAoJEJrBOlT6nu75ciUIAIiX70XbdMAbyUKXJeFNyXo1
G7wGltOuBeo2TJfKzQG7jX2e1t1xkxnB4BntqldehQsfPcn/chIQgFpRzOMUUNDt
oPOnCHhGJ+mdEMDQAY98erLRZ8oqsoefFFScEdTZ+UVH/g+k4+2qYV3RH9i8iPYz
kJxMB7xoAq7Lvffltx2tI9glmPGiOIKHWySEgE9piMlrdYA3MtGLub0c/3HnGdzS
CNtS4Bsql/805zJhmZL6TjugYNQHBe/5iSe6UAkwxNaoYmQ1iNY3GfZrb25R3RLX
aWNatMRkoLlvFL8xfqP5bdnYjBbxepnyQZzOuVPN+EeMlJGPWEIyoa3aKRN9FDg=
=ctnu
-----END PGP SIGNATURE-----
