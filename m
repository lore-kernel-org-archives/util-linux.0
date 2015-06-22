Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:7366 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751540AbbFVBpx (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Jun 2015 21:45:53 -0400
Message-ID: <558768CB.8090209@ubuntu.com>
Date: Sun, 21 Jun 2015 21:45:47 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: Manual sections vs. /bin or /sbin location
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I came across a bug report in Debian noting that findmnt is in /bin,
not /sbin, but its manual page is in section 8.  Should one or the
other be moved so they line up?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJVh2jLAAoJENRVrw2cjl5RpNoH/0LbBCNB2JX3duiRzW7giKl/
PEwsI9qqnkSa6YLQTt3+mkhZEceDYmk6+cteOEWTi0iywL/OP4OaDwvbZCENQJ2P
jWUk024XbWry8TCB5sDq5ntF83ikFWVrvbdQFbRJG+gC0zktJ7RM98rLULO7AUHc
9CarDMWKZx6BSL7g0SI9PCVVLROVk7rqcfsJj4BpRJi4TC1iONdxz6BExE2eF0/B
p6sg6y7NB6FO0NnpqUmCil5XodJZ6kZxs2+ZB0ilk2Z2G31aPjlAtNo8X435XFNB
z2ZSi4H0+AEXTFiMeTtLuusiue68jWrWoGzbF5xSwKROZZ039MAv2OCID9vgvkA=
=vNLd
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
