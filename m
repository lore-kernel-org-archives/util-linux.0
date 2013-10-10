Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:46815 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750Ab3JJOVF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 10 Oct 2013 10:21:05 -0400
Message-ID: <5256B7CF.7010103@ubuntu.com>
Date: Thu, 10 Oct 2013 10:21:03 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Filesystem specific mount options mixed with auto fs type
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I came across an old bug report where the user had set the utf8 mount
option in /etc/fstab on a floppy, presumably to apply to a fat
filesystem, but when a disk formatted with ext2 was used, the mount
failed sine ext2 doesn't support this option.

That got me wondering, how are you supposed to specify mount options
with the auto fs type?  Certainly you don't just have to limit the
options to ones that are universal to all filesystems?  But how to
specify that these options are for fs A, and these for fs B?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBAgAGBQJSVrfPAAoJEJrBOlT6nu75SeEH+KPG9gTtbp7tkrbOtgKNRi7l
W3sGIRMBKh47Ddl9AaX1K3gANVedcAQ5chPtCH6ANGXung2RSOkUDFfeZQsWe59C
gyuhwUwxH6NHq/4k0NR4IS0pUjRtiM1uwLL9VyYiDHr+Nx/edoMPiHRlo4c/M8oA
iYm2EEbHG147tfoZQ0cSUurdF4Hnh+mnVgWMt6/jcaL7AQTcZwY72GIHIrUMq/r5
dkwMiXF46GUxUGa8ToDbZWETbuToFv+wlL0+K8JDZaUvuYjKzdhawuM6Jb73kCtJ
1whHnnCQnzHm08fhB38kTDuCMOSVICU0FqQjtYY8c9nLI6fLL/+r9g2ycN+sqA==
=/BVh
-----END PGP SIGNATURE-----
