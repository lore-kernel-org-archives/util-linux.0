Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:58363 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426310AbcBRNMw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:52 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LngRb-1a2rKH26pz-00hsHE for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:50 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 00/15] portability fixes in the mix (OSX)
Date: Thu, 18 Feb 2016 14:12:40 +0100
Message-Id: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

also see github pull request #282
https://github.com/karelzak/util-linux/pull/282

This is a the first chunk of arbitrary cleanups and build fixes
mainly tested on OSX and FreeBSD.

FYI here I have some OSX build logs (with some more hacks included).
Maybe there are some interesting warnings to fix.
https://travis-ci.org/rudimeier/util-linux/builds/110071732

Ruediger Meier (15):
  travis: minor cleanup
  build-sys: portable usage of find command
  build-sys: check linker support for version scripts
  build-sys: fix [g]libtoolize version for OSX
  tests: fix ts_option helpers
  lib: rename strmode() and setmode()
  include: provide MAP_ANONYMOUS on OSX
  lib: define LOGIN_NAME_MAX fallback
  include: check for sys/sysmacros.h
  include: remove unused mntent.h
  lsns: use xcalloc()
  lib: remove unused variable
  lib: fix ismounted includes for FreeBSD
  libblkid: don't include endian.h
  include: fix sys/sysinfo.h

 .travis-functions.sh                  |  31 +++-----
 .travis.yml                           |   2 +
 autogen.sh                            |   2 +-
 configure.ac                          |   6 ++
 disk-utils/fsck.cramfs.c              |  10 +++
 disk-utils/fsck.minix.c               |   1 -
 disk-utils/mkfs.cramfs.c              |   8 ++
 disk-utils/mkfs.minix.c               |   1 -
 disk-utils/mkswap.c                   |   1 -
 disk-utils/raw.c                      |   2 +
 include/strutils.h                    |   2 +-
 lib/blkdev.c                          |   1 -
 lib/idcache.c                         |   4 +
 lib/ismounted.c                       |  11 ++-
 lib/monotonic.c                       |   2 +
 lib/strutils.c                        |   2 +-
 lib/timer.c                           |   1 -
 libblkid/src/Makemodule.am            |   4 +-
 libblkid/src/superblocks/drbdmanage.c |   2 +-
 libfdisk/src/Makemodule.am            |   4 +-
 libmount/src/Makemodule.am            |   4 +-
 libsmartcols/samples/tree.c           |   2 +-
 libsmartcols/src/Makemodule.am        |   4 +-
 libuuid/src/Makemodule.am             |   4 +-
 login-utils/login.c                   |   2 +
 login-utils/sulogin.c                 |   9 +++
 m4/ax_check_vscript.m4                | 142 ++++++++++++++++++++++++++++++++++
 misc-utils/lsblk.c                    |   2 +-
 misc-utils/namei.c                    |   6 +-
 sys-utils/lsipc.c                     |   6 +-
 sys-utils/lsns.c                      |   4 +-
 tests/functions.sh                    |   6 +-
 tests/run.sh                          |  11 ++-
 tests/ts/build-sys/config             |   2 +-
 tests/ts/cramfs/mkfs                  |   2 +-
 text-utils/ul.c                       |  10 +--
 tools/checkmans.sh                    |   2 +-
 37 files changed, 253 insertions(+), 62 deletions(-)
 create mode 100644 m4/ax_check_vscript.m4

-- 
1.8.4.5

