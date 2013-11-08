Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:37125 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab3KHAcT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Nov 2013 19:32:19 -0500
Message-ID: <527C3112.40904@ubuntu.com>
Date: Thu, 07 Nov 2013 19:32:18 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Generating release from git
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

How do you generate the release tarball from the git repo?  I thought
it would be to run make dist, but it seems the real release tarball is
bootstrapped with autogen.sh, but NOT configured, and make dist
generates a tarball that is already configured.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJSfDESAAoJEJrBOlT6nu75wf4IANb9Bi8txCj1XDA10vThctmv
71+d3YRpvJIhItmgXidPGpuRRBJmQEGWhiLKeYan7WRoZBonniG3KdiEtHTGgqvS
rZIOXBLcoxmisL6LQb0X10Zj3kPK7N3qQfh3rm4p51ATVBKxb82E6DhnyHgN2Kbt
3LZaMrfzGdXHzVl7tWH83gFpf6m3jMixisA87hbU48dmd4PC71e8T3fsCzE4uPkx
X5P59qv84PRj7Z7Kx+au3j3cYiidVR61lJRu110MyS1HnpylSjNU2iND+JTmxw/y
VxX5zaaPyEqnDu0D1TUrz5p8SNxfVKp0P0n4jB93+jkZy663yVnsjf1cCD93iZw=
=bU9G
-----END PGP SIGNATURE-----
