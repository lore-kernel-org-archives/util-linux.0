Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39859 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaBFUrt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 6 Feb 2014 15:47:49 -0500
Message-ID: <52F3F4F1.5000007@ubuntu.com>
Date: Thu, 06 Feb 2014 15:47:45 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: chrt requires priority argument
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

chrt requires a priority argument, even for classes ( like batch )
that do not support them.  If you specify a non zero value, then the
command fails.  I think the argument should be ignored and forced to
zero for these classes, and the man page updated to indicate that the
priority is ignored for those classes that don't use it.  If the
argument could be made optional so you can omit it that would be nice too.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS8/TxAAoJEI5FoCIzSKrw1FEH/12oM8MaMSQzJSLaHwB23DnT
hFGjIBFMn8nSbIXQinnhO+XmtCpoQUrRZ0rBZ6BjYno8t7NGpV1KZsX4x/cC8ZQD
kJj2jgxu8A8ETagPw1oPfIklZbq3FNQhTE+IczrQWlAr8elr1DB+m0pf/GVpN6b+
PiGvE+PUBnElOnEMic3uDQqvXZWSd+bDEcM99Gs2X9zH2nK1eGblhJav4uP5B3cY
kJqTROeB/hb2Yiiur0tEE7/TJoIYlNJbo7Va3LmhyUCiNYk3YMqep45Jh+2jSZ77
EP1EZ7OXea3NGdEc0dgE3Hb/OumkcEowxeEJLpz8sUN1LZf+I6wcL02O7fV9eHQ=
=TF0C
-----END PGP SIGNATURE-----
