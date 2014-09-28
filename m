Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:43604 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbaI1TwB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:01 -0400
Received: by mail-we0-f176.google.com with SMTP id p10so405685wes.21
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:51:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/23] pull: mostly textual and compiler warning fix changes
Date: Sun, 28 Sep 2014 20:51:33 +0100
Message-Id: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This should not be breath taking patch set for anyone.  The textual
changes are pretty straight forward, and warning fixes are intented to
make '-Wall -pedantic' compilations less noisy so that real issues are
easier to spot.

The change worth to mention separately are 0003 hexdump and 0023 tests
fix.  I suppose it's OK by now to remove the 'GNU coreutils od' warning
from hexdump.  The test fix is Adam Sampson's change, that Ruediger Meier
further improved[1], and I've mostly been primarily guilty to make a mess
with the ipcs/limits2 test.  Well, hopefully the test is now OK until big
integer support is sorted out.

[1] http://www.spinics.net/lists/util-linux-ng/msg10141.html


The following changes since commit 286f1e229bee68c2f2720407752bcb5ec95c9abc:

  Merge branch 'misc' of git://github.com/kerolasa/lelux-utiliteetit (2014-09-22 14:55:37 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk38

for you to fetch changes up to a642dd57eaf7ec1e106eebc0018eddc907a0fe79:

  tests: fix the ipcs test for shmall being too big to show (2014-09-28 19:22:50 +0100)

----------------------------------------------------------------

Adam Sampson (1):
  tests: fix the ipcs test for shmall being too big to show

Sami Kerola (22):
  swapon: align available columns section in usage()
  docs: update deprecation banners
  hexdump: remove deprecation message
  textual: fix couple typos in comments
  flock: add error message to translations
  textual: use version printing macro everywhere
  textual: use manual tail usage() macro
  textual: use usage() text element macros
  libuuid: remove _SVID_SOURCE pre-processor definition
  include: fix compiler warnings
  lsblk: fix compiler warning
  libblkid: use pre-processor to optimize out code
  libblkid: fix implicit constant conversion warning
  include/debug: remove duplicate 'const' declaration warning
  cfdisk: add missing initializers to struct main_menuitems
  findmnt: add missing initializers to struct colinfo
  lsblk: add missing initializers to struct colinfo
  hwclock: use fabs() instead abs() when argument is double
  lscpu: add missing initializers to struct lscpu_coldesc
  libsmartcols: add explicit column flags default
  lslogins: add missing initializers to struct lslogins_coldesc
  lslogins: use more narrow layout when initializing struct members

 disk-utils/cfdisk.c                |  21 ++--
 disk-utils/mkfs.bfs.c              |   1 +
 disk-utils/mkfs.c                  |  16 ++-
 disk-utils/mkfs.minix.c            |   2 +-
 include/c.h                        |  10 +-
 include/debug.h                    |   2 +-
 include/list.h                     |   2 +-
 libblkid/src/superblocks/bcache.c  |   2 +-
 libblkid/src/superblocks/zfs.c     |   6 +-
 libfdisk/src/context.c             |   2 +-
 libfdisk/src/script.c              |   2 +-
 libsmartcols/src/libsmartcols.h.in |   1 +
 libsmartcols/src/table_print.c     |   2 +-
 libuuid/src/gen_uuid.c             |   6 --
 login-utils/chfn.c                 |   4 +-
 login-utils/lslogins.c             | 212 ++++++++++++++++++++++++++++++-------
 login-utils/newgrp.c               |   9 --
 login-utils/vipw.c                 |   9 --
 misc-utils/findmnt.c               |  50 ++++-----
 misc-utils/getopt.c                |  13 ++-
 misc-utils/look.c                  |   6 +-
 misc-utils/lsblk.c                 |  66 ++++++------
 misc-utils/namei.c                 |   7 +-
 misc-utils/uuidd.c                 |   4 +-
 misc-utils/uuidgen.c               |   5 +-
 misc-utils/wipefs.c                |   7 +-
 schedutils/chrt.c                  |   4 +-
 schedutils/taskset.c               |   5 +-
 sys-utils/chcpu.c                  |   3 +-
 sys-utils/dmesg.c                  |   3 +-
 sys-utils/flock.c                  |   2 +-
 sys-utils/hwclock.c                |  11 +-
 sys-utils/lscpu.c                  |  27 +++--
 sys-utils/rtcwake.c                |   3 +-
 sys-utils/swapon.c                 |   2 +-
 sys-utils/tunelp.c                 |  12 ++-
 term-utils/agetty.c                |   3 +-
 term-utils/script.c                |   8 +-
 term-utils/scriptreplay.c          |   8 +-
 term-utils/write.c                 |  13 ++-
 tests/ts/ipcs/limits2              |   2 +-
 text-utils/col.c                   |  13 ++-
 text-utils/colcrt.c                |   5 +-
 text-utils/colrm.c                 |  14 +--
 text-utils/column.c                |   5 +-
 text-utils/hexdump.c               |   7 +-
 text-utils/pg.c                    |   9 ++
 text-utils/rev.c                   |  13 +--
 text-utils/tailf.c                 |   4 +-
 text-utils/ul.c                    |   3 +-
 50 files changed, 383 insertions(+), 263 deletions(-)

-- 
2.1.1

