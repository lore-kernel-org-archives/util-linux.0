Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:38003 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbaBJXZH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Feb 2014 18:25:07 -0500
Message-ID: <52F95FD1.5090305@ubuntu.com>
Date: Mon, 10 Feb 2014 18:25:05 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Can't unmount broken nfs mount
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Forwarding from debian bug #711183:

User reports that a broken nfs mount has its mounted directory in
/proc/mounts renamed from /foo to /foo\040(deleted) when an nfs mount
is broken due to an unreachable server, and this prevents unmounting
it since umount can not find "/foo" in /proc/mounts.  Is this a kernel
bug, or something that umount needs to work around?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJS+V/RAAoJEI5FoCIzSKrwrSYIAIabY0n6tptzm+DenwAv8cf4
fb7bb7+rcjXXpeYEzyD7xIDvmRgNuYoxMOdTfRkMeR04K4E8MDKx98pH0WU8m2CY
SQh0WCVKStxNFYOd8DugeRYP0kaisyhoe43XtKyHGjwvpNXIjDEsPFV30Rw1cLQa
OJD2FrZLNUhciuvzRXl17mmUowWqGa9QqoVA54Hn2dkgmP3Arlkx+11cxwxD3zE1
OXplSvugMfwgDugLawdorDrUl37Efv47+l4yW6ZiLjhb6cu8QxDQDpaTgHLXtFJi
ZBECGDbKDDEBbNWGvjSkY40CaTiZeEXn5DePYQkY1iaq8TfhXHi/YTg21w7Srgg=
=dvV4
-----END PGP SIGNATURE-----
