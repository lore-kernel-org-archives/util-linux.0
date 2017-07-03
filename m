Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57542 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753007AbdGCLxE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 07:53:04 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LcWSI-1eAefQ3Cty-00jolK for <util-linux@vger.kernel.org>; Mon, 03 Jul 2017
 13:53:02 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/6] lib/path.c and lib/sys.c are friends (patches FOR TESTING ONLY)
Date: Mon,  3 Jul 2017 13:52:55 +0200
Message-Id: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Karel Zak wrote on github:

> BTW, see Documentation/TODO .
> 
> .. lib/path.c and lib/sys.c should be friends and they need our love :-) 
> 
> For lib/path.c should be probably nice to have handler, so we can use *at()
> functions rather than compose paths for each request.

Hi,

I've put this this trivial but non-dangerous solution together.
Using openat(), no cleanup yet, just to see how it looks.

See
 test_sysfs: usage: ./test_sysfs <sysroot> <devname>
                                   ^^^^^

and compare (maybe with stace)

 $ ln -s  /  /tmp/sysroot 
 $ ./test_sysfs /tmp/sysroot /dev/sda
 $ ./test_sysfs / /dev/sda
 $ ./test_sysfs "" /dev/sda

Note if sysroot is empty or not set at all, then the dirfd is ignored in all
openat() functions. Thus in the default case shouldn't be any risk that
the changes in path.c and sysfs.c can break anything. In theory we could
use path_open() and friends system wide instead if open(). For now I've
added some asserts to make sure that we are using path.h with absolute paths
only.

For the fun I've added option --sysroot to zramctl and lsblk. Don't know if it's
useful yet. The strace of lsblk looks like that we should use path_open()
functions at more places within libblkid.

So everybody is invited to create some "sysroot" tests like we have for lsmem and
lsblk already. Lets see whether if we can use this for something good.

cu,
Rudi

Ruediger Meier (6):
  path: use openat()
  path: add some standard functions
  path: never create path with prefix
  sysfs: use path.h
  zramctl: add --sysroot
  lsblk: add --sysroot

 include/path.h      |  15 ++++++
 lib/path.c          | 152 +++++++++++++++++++++++++++++++++++++++++++++-------
 lib/sysfs.c         |  53 +++++++++++-------
 misc-utils/lsblk.c  |  21 ++++++--
 sys-utils/lscpu.c   |   5 +-
 sys-utils/lsmem.c   |  11 ++--
 sys-utils/zramctl.c |  13 ++++-
 7 files changed, 214 insertions(+), 56 deletions(-)

-- 
1.8.5.6

