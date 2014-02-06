Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:63221 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbaBFUxx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 6 Feb 2014 15:53:53 -0500
Message-ID: <52F3F660.8060600@ubuntu.com>
Date: Thu, 06 Feb 2014 15:53:52 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: setarch treats all x86 variants as i686?
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

setarch i486
uname -m
i686

Is this a bug?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS8/ZgAAoJEI5FoCIzSKrwfT4IAJKywIsfNUQfT4Yf7tR3+Ej9
Wkyipwm6UYqx3xrv+0ndVTPUXINBBFVTqPdpmkvdNhz92aqdHQy7xEWX5/c9oV63
jw9GL/UU0GygdXsHYJEtLUE2FZMSNej9czmi04h3K8eKO/dYpzw4JSiqGUlGmRtS
VrL5vFZZuYBYxf4LRk4NP6+WZhsjY8vQnryctFBrOlj358D0twohPhMCP5WxBJYs
0LFCQK3BuLcJqX8wW483Oi80PEwbAryvJlt1UcI0Buj7iOpq6t3vuf6Ak93elRh0
ml+9zlqmbxfmtC6eVf6W1znJGQ9/F+M7HL3vdzEKeXynHSN5LpSiU3xx4LXLI4w=
=v7iW
-----END PGP SIGNATURE-----
