Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52433 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbaE3DbE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 May 2014 23:31:04 -0400
Received: from brln-4db8647f.pool.mediaways.net ([77.184.100.127]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MK0Np-1WoqUC0x8f-001OSe
 for <util-linux@vger.kernel.org>; Fri, 30 May 2014 05:31:01 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: BUG: fdisk, gpt broken on 32bit big endian systems
Date: Fri, 30 May 2014 05:31:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201405300531.00403.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This ...

$ rm -f xxx; truncate -s 10M xxx
$ echo -ne "g\nx\ni\n26841E90-46E0-4205-B012-4B8AEC35C088\nr\nw\nq\n" | fdisk xxx

... creates a broken gpt image on 32bit big endian systems.

"hexdiff" xxx-broken xxx-good:
 00000260  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 009ffe00  45 46 49 20 50 41 52 54  00 00 01 00 00 02 00 00  |EFI PART........|
-009ffe10  68 a5 49 d1 00 00 00 00  ff ff ff ff ff ff ff ff  |h.I.............|
+009ffe10  15 b9 f3 7e 00 00 00 00  ff 4f 00 00 00 00 00 00  |...~.....O......|
 009ffe20  01 00 00 00 00 00 00 00  00 08 00 00 00 00 00 00  |................|
 009ffe30  de 4f 00 00 00 00 00 00  90 1e 84 26 e0 46 05 42  |.O.........&.F.B|
 009ffe40  b0 12 4b 8a ec 35 c0 88  df 4f 00 00 00 00 00 00  |..K..5...O......|


Looks like the backup header is broken.

Notes:
  - I only used fixed uuid to have better diff.
  - 64bit big endian systems are not broken

cu,
Rudi
