Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:12255 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751531AbbFVCA5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Jun 2015 22:00:57 -0400
Message-ID: <55876C53.7030505@ubuntu.com>
Date: Sun, 21 Jun 2015 22:00:51 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: mount existing tmpfs mounts a new tmpfs
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Forwarding this from debian bug #772419: Run mount /run, and it mounts
a new tmpfs over top of the existing one in /run ( even if /run isn't
listed in /etc/fstab ), hiding the existing files.  It should say that
it is already mounted.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJVh2xSAAoJENRVrw2cjl5RnisH/1wvRqqlgckjp1sRdo/zGfHX
Wpw5vIYxefXvKrQsyI64DMLV6MNNnFdGNIj8QxnBJwMpzFq0+p08u0AWmThNg35Q
H1as8PA8+RkM7e7vzPXFId7QMjL+Lx09TE4Tg0y6HERF834FnL3QDwYna5AcJbVg
wvADB7CTEAK3SHv1F1HHVOcKb6DFw0ur/JIM93+P6rohu7jhUOWq+SVcDNZgA/JQ
dzEzBgFv1+yJPHYP4J8lKTddq+TOGzhamlusfz/6feSKzyvFKSxaPWDrLTNk5hu3
dj3bHoiWlGB7meo3NCDqKLH6nLeOUhlXgaGh0vm72fwM7Ip4DkO0Ovy4dloxokA=
=Umj1
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
