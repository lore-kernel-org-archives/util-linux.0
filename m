Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:38866 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab3LKOiO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 Dec 2013 09:38:14 -0500
Message-ID: <52A878C5.6050505@ubuntu.com>
Date: Wed, 11 Dec 2013 09:37:57 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: read only bind mount ignores ready only
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Forwarding report from
https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/712892

It seems that the kernel has a bug where it silently ignores the
MS_RDONLY flag when creating a bind mount.  mount issues a warning
that the mount point appears to be read-write even though you
requested read only.  The reporter suggests a patch to automatically
attempt to remount with MS_RDONLY before issuing this warning to work
around the kernel bug.  What do you think?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSqHjFAAoJEI5FoCIzSKrwP5wH/3vfHcUVra8Zh2GUcTEMU7ex
BEed+jb4KYeuuISO8wxrkGb7eRAw/mHQTTPmVPjouWbG0s7AMXb/k1JQw3VEwtPA
7Mm8Y6jZoMJTiHvegWAKCWiaKcZ2ututJa23OP7RAgWJeGoZVdRtpRCyC6XOT3ES
anUdwKpoZgDILKMdi+ssgfDVjPgDpaOluHkXLvhPlYyYiHb7WeAjEWGryTCt/vXq
74CjnD0l07Ryvg0ZNehxLQG6YJqQyNK69MUlDfNo3Tr66oeZNfbvso2Npkhvi6/E
Ut+6dJr0Z9fasfHb88UmhmLUcSCKM6HRGy29fSKQ3UJDpD77o7smPr/p51YaX0M=
=x0mB
-----END PGP SIGNATURE-----
