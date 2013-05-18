Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:37450 "EHLO Ishtar.hs"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752853Ab3ERT3h (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 18 May 2013 15:29:37 -0400
Received: from [192.168.4.12] (Athenae [192.168.4.12])
	by Ishtar.hs (8.14.5/8.14.4/SuSE Linux 0.8) with ESMTP id r4IJTVwd043494
	for <util-linux@vger.kernel.org>; Sat, 18 May 2013 12:29:33 -0700
Message-ID: <5197D69B.2050202@tlinx.org>
Date: Sat, 18 May 2013 12:29:31 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Fwd: mount-no canonical & dev root...
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I reported this bug on 4/22 on this list.

Not been solved... so I started going back versions.

The first version that worked:
-rw-rw-r--  1  1548487 May 18 11:46 util-linux-2.19-3.6.1.x86_64.rpm
-rw-rw-r--  1   226344 May 18 11:46 libblkid1-2.19-3.6.1.x86_64.rpm
-rw-rw-r--  1    15388 May 18 11:46 libblkid-devel-2.19-3.6.1.x86_64.rpm
-rw-rw-r--  1    32084 May 18 11:46 uuidd-2.19-3.6.1.x86_64.rpm
-rw-rw-r--  1    33198 May 18 11:46 libuuid1-2.19-3.6.1.x86_64.rpm
-rw-rw-r--  1    26285 May 18 11:46 libuuid-devel-2.19-3.6.1.x86_64.rpm
-rw-rw-r--  1   168638 May 18 11:46 libmount1-2.19-3.6.1.x86_64.rpm
-rw-rw-r--  1    14625 May 18 11:46 libmount-devel-2.19-3.6.1.x86_64.rpm

(That was included in suse 11.4).  Versions after that show the bug.

Perhaps some functionality in 11.4 wasn't carried forward into newer
versions and could be fixed using that version's working code?






