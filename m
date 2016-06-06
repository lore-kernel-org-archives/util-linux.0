Return-Path: util-linux-owner@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:34197 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcFFIny (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2016 04:43:54 -0400
Received: from probook ([2001:a62:12d4:3eff:9c5e:5d74:155f:bf5a])
	by smtp.strato.de (RZmta 38.2 AUTH)
	with ESMTPSA id 0006abs568hnFVR
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <util-linux@vger.kernel.org>;
	Mon, 6 Jun 2016 10:43:49 +0200 (CEST)
Date: Mon, 6 Jun 2016 10:43:48 +0200
From: Olaf Hering <olaf@aepfle.de>
To: util-linux@vger.kernel.org
Subject: udf LABEL= handling broken
Message-ID: <20160606084348.GA26722@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

(Assuming util-linux is used to create broken /dev/disk/by-label/*)

It seems Win7 handles only up to 11 chars as volume name for a disk
partition. According to this diff of xxd -a output it puts the length
after the actual string block. blkid ignores the lenght and uses
whatever is in the string block as LABEL=. For some reason the string is
stored twice in the metadata.  The first attempt was volume name 'abcd',
the second uses the full 11 chars.

Olaf

--- /dev/shm/1	2016-06-06 10:15:16.298404371 +0200
+++ /dev/shm/4	2016-06-06 10:15:16.934405173 +0200
@@ -50,17 +50,17 @@
 000204d0: 5300 0000 0000 0000 0000 0000 0405 0000  S...............
 000204e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 *
-00020600: 0600 0300 d800 0100 64b7 ae01 0301 0000  ........d.......
+00020600: 0600 0300 0500 0100 88c0 ae01 0301 0000  ................
 00020610: 0200 0000 004f 5354 4120 436f 6d70 7265  .....OSTA Compre
 00020620: 7373 6564 2055 6e69 636f 6465 0000 0000  ssed Unicode....
 00020630: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 00020640: 0000 0000 0000 0000 0000 0000 0000 0000  ................
-00020650: 0000 0000 1000 6100 6200 6300 6400 3200  ......a.b.c.d.2.
+00020650: 0000 0000 1000 7300 7300 6400 3100 3200  ......s.s.d.1.2.
 00020660: 3000 5f00 6400 6f00 6300 7300 6d00 6500  0._.d.o.c.s.m.e.
 00020670: 6e00 7400 0000 0000 0000 0000 0000 0000  n.t.............
 00020680: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 *
-000206d0: 0000 0009 0002 0000 002a 4f53 5441 2055  .........*OSTA U
+000206d0: 0000 0017 0002 0000 002a 4f53 5441 2055  .........*OSTA U
 000206e0: 4446 2043 6f6d 706c 6961 6e74 0000 0000  DF Compliant....
 000206f0: 0102 0000 0000 0000 0002 0000 0154 0000  .............T..
 00020700: 0000 0000 0000 0000 0600 0000 0100 0000  ................
@@ -667343,18 +667343,18 @@
 00aa24d0: ffff ffff ffff 0000 0000 0000 0000 0000  ................
 00aa24e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 *
-00aa2600: 0001 0300 6000 0100 f421 f001 0154 0000  ....`....!...T..
+00aa2600: 0001 0300 3e00 0100 6291 f001 0154 0000  ....>...b....T..
 00aa2610: 7810 e007 0512 0a0e 2528 1d45 0200 0300  x.......%(.E....
 00aa2620: 0100 0000 0100 0000 0000 0000 0000 0000  ................
 00aa2630: 004f 5354 4120 436f 6d70 7265 7373 6564  .OSTA Compressed
 00aa2640: 2055 6e69 636f 6465 0000 0000 0000 0000   Unicode........
 00aa2650: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 00aa2660: 0000 0000 0000 0000 0000 0000 0000 0000  ................
-00aa2670: 1000 6100 6200 6300 6400 3200 3000 5f00  ..a.b.c.d.2.0._.
+00aa2670: 1000 7300 7300 6400 3100 3200 3000 5f00  ..s.s.d.1.2.0._.
 00aa2680: 6400 6f00 6300 7300 6d00 6500 6e00 7400  d.o.c.s.m.e.n.t.
 00aa2690: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 *
-00aa26e0: 0000 0000 0000 0000 0000 0000 0000 0009  ................
+00aa26e0: 0000 0000 0000 0000 0000 0000 0000 0017  ................
 00aa26f0: 004f 5354 4120 436f 6d70 7265 7373 6564  .OSTA Compressed
 00aa2700: 2055 6e69 636f 6465 0000 0000 0000 0000   Unicode........
 00aa2710: 0000 0000 0000 0000 0000 0000 0000 0000  ................
