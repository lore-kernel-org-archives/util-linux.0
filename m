Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f45.google.com ([209.85.216.45]:42590 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbaLQPZD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Dec 2014 10:25:03 -0500
Received: by mail-qa0-f45.google.com with SMTP id i13so3516065qae.4
        for <util-linux@vger.kernel.org>; Wed, 17 Dec 2014 07:25:02 -0800 (PST)
Received: from [10.1.1.236] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id s32sm4122484qge.23.2014.12.17.07.25.01
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Dec 2014 07:25:02 -0800 (PST)
Message-ID: <5491A048.3070103@ubuntu.com>
Date: Wed, 17 Dec 2014 10:24:56 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Remount failure without fstab or mtab
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a bug report in debian about "mount -o remount,rw /" failing
because /etc/fstab does not contain an entry for the root fs, and
/proc is not mounted ( booting with init=/bin/bash for recovery ).
I'm not sure whether this is really a bug or not so I thought I'd ask.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUkaBIAAoJENRVrw2cjl5RrtcIAJZs/d8l/ijxBusuebPU1+NF
EkCvlZMjbWLcQjI8nwidLQN9lZGEdj0Hhlm7kQjashiF5ti/YcJPFyCkEEruW+S+
WtC1l0DRlwCz7bjeO9WWPtInLen1hzAc2o3vmXq13AxoLcmi8/nwoodIT1z+FQOR
JXugedrmarA17vakPddPzj3FOeJjgaZESiB4zj4uxXcxUWu6tfMaFSV00LlE58HI
K9W1aBmYqcw5jVvpHaT5n5IUL4xGCmN3v7galnjErG5iTV1pd3N1B2hkakcv+Sjj
Gza5U/Qpdj2zJ143m6WyVU0q1hL7qucuGMwnhtq8buYIjD+I/V/0/n7Zw+Norq0=
=Qd1S
-----END PGP SIGNATURE-----
