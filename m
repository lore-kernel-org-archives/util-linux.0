Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:57699 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757683AbbLCB5J (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Dec 2015 20:57:09 -0500
Received: from tenfore.lan ([95.114.250.73]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MXIov-1Zpmuv0GsX-00WHdK for
 <util-linux@vger.kernel.org>; Thu, 03 Dec 2015 02:57:08 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "util-linux" <util-linux@vger.kernel.org>
Subject: libblkid: blkid_bufinfo() fails on 32bit
Date: Thu, 3 Dec 2015 02:57:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201512030257.06753.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Looks like this commit breaks 32bit/i386 systems:

----
commit a674a0ab03660b1df777e69436b2dc832b6f8681
Author: Karel Zak <kzak@redhat.com>
Date:   Tue Sep 22 15:37:26 2015 +0200

    libblkid: use mmap() rather than read()
----

 libblkid/src/probe.c:638: mmap_buffer: Assertion `map_off + map_len >= real_off + len' failed.


I can avoid that assert if I change the type of map_len in blkid_bufinfo().

-   size_t map_len;
+   blkid_loff_t map_len;

but it still looks broken, see this debug output


libblkid: LOWPROBE: --> starting probing loop [SUBLKS idx=-1]
libblkid: LOWPROBE: [0] linux_raid_member:
libblkid: LOWPROBE:     call probefunc()
libblkid:   BUFFER:     mapping end of the device
libblkid:   BUFFER:     mmap  0xf7321000: off=4112515072, len=25771900928 (6291968 pages)
                                                      ^^^^^^^
   shouldn't we only mmap about 2M?

libblkid:   BUFFER:     reuse 0xf7321000: off=4112515072 len=25771900928 (for off=29884407808 len=256)
libblkid:   BUFFER:     mapping begin of the device
libblkid:   BUFFER:     mmap  0xf7121000: off=0, len=2097152 (512 pages)
libblkid:   BUFFER:     reuse 0xf7121000: off=0 len=2097152 (for off=4096 len=256)

cu,
Rudi
