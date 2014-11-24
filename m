Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f43.google.com ([209.85.216.43]:54991 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbaKXO7Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Nov 2014 09:59:16 -0500
Received: by mail-qa0-f43.google.com with SMTP id bm13so6387777qab.2
        for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 06:59:16 -0800 (PST)
Message-ID: <547347A1.7080402@ubuntu.com>
Date: Mon, 24 Nov 2014 09:58:41 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org
Subject: Re: Bug#770211: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546E1A16.6050102@ubuntu.com> <5472B7E4.4040601@dasyatidae.net> <547341AD.4020702@ubuntu.com> <547342B2.2060509@dasyatidae.net> <54734522.7010807@dasyatidae.net>
In-Reply-To: <54734522.7010807@dasyatidae.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/24/2014 9:48 AM, Drake Wilson wrote:
> To clarify, that's in the GPT list, not the MBR one.  I see that
> the MBR one names 0x83 "Linux", at least.  Does that mean that
> {0FC63DAF-8483-4772-8E79-3D69D8477DE4} should also be named "Linux"
> rather than "Linux filesystem"?

Oh boy.  I hadn't noticed that util-linux had added so many silly type
codes now that it supports GPT.  This mess really needs cleaned up.
There should just be "Linux" and that's it.  That's the only one we
have in parted and it is quite sufficient.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUc0ehAAoJEI5FoCIzSKrwiGoIAIksu6+umL4VfaE6UWr/5LCP
Td+rMenz/IosGo1cn602SKbTewNyMzZ3T5RJnTY5dVHt7aWMJGtKMtZ4GavHnttL
nV8yZvXcv7JGmvOtZiu0zK1V/WUxrQY0KaUd2wjtYUOkCpuHRaj5wkk7erarGZIt
Z1OgVfXfOEfVjC4jf1rbnOQib53azceVgge6knI8uHAq7qONdzCX588xAypz2Vok
t08LalysnVqckuhwsbFzWvUblMfelnI0qhGp/GwkT2s/cRuLlGf28yAyq73/bbaw
zHDbZg8PbehyHwoBjPiVA1bNAg7sVrXQV4TJSrddo0UosgqpxXHE7B3+sEa3rOg=
=3Gq7
-----END PGP SIGNATURE-----
