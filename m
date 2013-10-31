Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:57674 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab3JaRNw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Oct 2013 13:13:52 -0400
Message-ID: <52728FCE.2050003@ubuntu.com>
Date: Thu, 31 Oct 2013 13:13:50 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: fdisk shows sun end sectors with +1 error
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Command (m for help): p
Disk /dev/loop0: 9.6 GiB, 10245537792 bytes, 20010816 sectors
Geometry: 255 heads, 63 sectors/track, 1245 cylinders
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: sun

Device       Flag     Start       End   Blocks  Id System
/dev/loop0p1              0  19904535  9952267+ 83 Linux native
/dev/loop0p2   u   19904535  20000925    48195  82 Linux swap
/dev/loop0p3              0  20000925 10000462+  5 Whole disk

(parted) print
Model: Loopback device (loop)
Disk /dev/loop0: 20010816s
Sector size (logical/physical): 512B/512B
Partition Table: sun

Number  Start      End        Size       File system  Flags
 1      0s         19904534s  19904535s
 2      19904535s  20000924s  96390s

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSco/OAAoJEJrBOlT6nu75SDcIAJ9T0YpHFzMT72TPOOcVZPtm
8ZIofOcwaXolffGL56TUgbCna79aJHuIfk0Vl2wL2m1PAb0npAbXyqNH457FlpwT
c/YEVheSldcrXQSJpMUGvFhkCgZOp1NAoXMGRIZ5GMmDybI3mKn/mlgJznV9RR27
3KOVN1QTR2lSZ6Fx71oCcgGOnBlrI3gREVMSRR8QvYnWp0/MNU2leVn+4ixvS03d
CxcLVC1grTvKqPnUTxiDqbyeUeJnVG5EBWkTswbQGRDR2jnuSgPXgJC5Kc1zQuFi
68Z4MUFln9/WaJz8+p7yjbv/zPRMEDJOuIg84PCgQ5qsvHnz09UuMvd/9JbvKzE=
=DdKd
-----END PGP SIGNATURE-----
