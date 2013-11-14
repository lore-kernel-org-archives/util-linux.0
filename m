Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:34439 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001Ab3KNSQb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Nov 2013 13:16:31 -0500
Message-ID: <5285137E.60900@ubuntu.com>
Date: Thu, 14 Nov 2013 13:16:30 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: SGI disk labels show wrong device
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Parted lists the device name using the wrong partition number:

Disk /dev/sde: 8 MiB, 8388608 bytes, 16384 sectors
Geometry: 8 heads, 32 sectors/track, 64 cylinders
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 32768 bytes
Disklabel type: sgi

Pt# Device    Info Start       End Sectors Id System
 9: /dev/sde1          0      4095    4096  0 SGI volhdr
11: /dev/sde2          0     16383   16384  6 SGI volume
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJShRN9AAoJEJrBOlT6nu75Q80H/0/cu1cCm4l6RDfsMgFkDyG9
SxX3f4sUWJYsmOxA6EvzQpCkltWqYopqOpFjT4GLAhzij6cxTS55RE9x6sjcJOei
B7JJTqSc7+4ah5endSFGblD0OMR3SG8iBpTIcvOKChMT9j/a59i6gcokfdUOOxXQ
NE3Vk2aC3k3eUhGKKly12DCdubKsRGMxhw2PFktyKjmQjECGtHUH12GsorFugzpq
iMIjxGGKenFXw46wLUey9BHCjwvc+7TspcDzkcnGTwCPrCWX1uICa8KZ6I5jeki4
HlbP3jm+imLSPDVIhjzNm8yCMscdcnAwHCvFQxp4KR3NJmL3wnjuJnbFHfwT93Y=
=q6v4
-----END PGP SIGNATURE-----
