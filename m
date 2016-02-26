Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62622 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbcBZDDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:36 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0MNuwp-1aaXjq2PW7-007Qzw for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:33 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 00/14] some fixes, cleanup and portability issues
Date: Fri, 26 Feb 2016 04:03:23 +0100
Message-Id: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Some arbitrary mostly trivial issues.

This is github pull request #291
https://github.com/karelzak/util-linux/pull/291

Ruediger Meier (14):
  logger: use SCM_CREDENTIALS on LINUX only
  build-sys: add openat build conditional
  fdisk: fix warning, incompatible pointer types passing 'uint64_t *'
  libsmartcols: fix uninitialized variable
  misc: fix some includes
  newgrp: rename memset_s()
  build-sys: build_init should check for flock
  login-utils: minor utmp cleanup
  build-sys: disable login-utils if shadow.h or utmp.h is missing
  build-sys: add --disable-ipcrm --disable-ipcs
  build-sys: chrt requires a sched_set* function
  lib: provide mkostemp fallback function
  build-sys: remove duplicate cal sources
  lib: include strutils.h for mempcpy()

 configure.ac                       | 50 ++++++++++++++++++++++++++++++++------
 disk-utils/fdisk.c                 |  4 +--
 include/fileutils.h                |  4 +++
 lib/blkdev.c                       |  7 ------
 lib/fileutils.c                    | 27 ++++++++++++++++++++
 lib/mbsalign.c                     |  1 +
 libblkid/src/save.c                |  1 +
 libfdisk/src/gpt.c                 |  3 ++-
 libsmartcols/samples/Makemodule.am |  4 ++-
 libsmartcols/src/table_print.c     |  2 +-
 login-utils/last.c                 |  2 +-
 login-utils/login.c                |  1 -
 login-utils/newgrp.c               |  4 +--
 misc-utils/Makemodule.am           | 10 +-------
 misc-utils/logger.c                |  5 ++++
 misc-utils/test_uuidd.c            |  1 -
 sys-utils/ipcs.c                   |  1 -
 sys-utils/lsipc.c                  |  1 -
 sys-utils/rtcwake.c                |  1 -
 text-utils/pg.c                    |  1 -
 20 files changed, 92 insertions(+), 38 deletions(-)

-- 
1.8.4.5

