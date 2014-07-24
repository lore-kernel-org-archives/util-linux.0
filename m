Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43547 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750824AbaGXLHW convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jul 2014 07:07:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway1.nyi.internal (Postfix) with ESMTP id D15C52132D
	for <util-linux@vger.kernel.org>; Thu, 24 Jul 2014 07:07:21 -0400 (EDT)
Message-Id: <1406200041.6182.145163581.650F0C1A@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: undefined reference to symbol 'blkid_probe_lookup_value@@BLKID_2.15'
Date: Thu, 24 Jul 2014 13:07:21 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Compiling current git, I get this:

[...]
  CC       sys-utils/swapoff-swapoff.o
  CC       sys-utils/swapoff-swapon-common.o
  CCLD     swapoff
/usr/bin/ld: sys-utils/swapoff-swapon-common.o: undefined reference to symbol 'blkid_probe_lookup_value@@BLKID_2.15'
/home/ben/ULIX/.libs/libblkid.so.1: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
make[2]: *** [swapoff] Fout 1
make[2]: Map '/home/ben/ULIX' wordt verlaten
make[1]: *** [all-recursive] Fout 1
make[1]: Map '/home/ben/ULIX' wordt verlaten
make: *** [all] Fout 2

Do I have stale stuff again somewhere?

Using 'make -k', a bit later it says this:

  CC       disk-utils/swaplabel-swaplabel.o
disk-utils/swaplabel.c: In function ‘main’:
disk-utils/swaplabel.c:175:2: warning: implicit declaration of function ‘get_swap_prober’ [-Wimplicit-function-declaration]
  pr = get_swap_prober(devname);
  ^
disk-utils/swaplabel.c:175:2: warning: nested extern declaration of ‘get_swap_prober’ [-Wnested-externs]
disk-utils/swaplabel.c:175:5: warning: assignment makes pointer from integer without a cast [enabled by default]
  pr = get_swap_prober(devname);
     ^

Benno

-- 
http://www.fastmail.fm - Accessible with your email software
                          or over the web

