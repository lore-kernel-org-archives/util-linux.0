Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:53812 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MexaL-1aFDuk2odl-00OYI3 for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:03 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 00/12] another BSD/OSX related patch-set
Date: Tue,  8 Mar 2016 00:11:50 +0100
Message-Id: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is github pull request #299
https://github.com/karelzak/util-linux/pull/299

Again some arbitrary BSD, OSX and musl related fixes and clean-up
patches. Most of them are nice to have for our major target too, most
notable "tests: don't skip case output undefined".

openBSD build runs fine now like this:
$ ./configure --enable-all-programs \
              --disable-ipcrm --disable-ipcs --disable-uuidd
make check survives most tests.

For OSX one should additionally disable all utmp.h related programs.
Almost no interesting compiler warnings left. Xcode/clang warnings are
a bit over the top anyways.


Ruediger Meier (12):
  wipefs, sfdisk: include libgen.h for basename(3p)
  misc: again fixing many printf format strings
  lib: include sys/stat.h for struct stat
  fdisk: sun, undef HAVE_QSORT_R for non-Linux
  libfdisk: remove ifdef HDIO_GETGEO
  misc: never cast void* from malloc(3) and friends
  libmount: don't include libio.h
  tests: cramfs, fix root group
  tests: don't skip case "output undefined"
  tests: getopt2, add function gnu_getopt_clean()
  tests: improve getopt loop error case
  getopt: fix -n name for BSD

 disk-utils/fdisk.c                           | 25 +++++----
 disk-utils/fsck.minix.c                      |  5 +-
 disk-utils/mkfs.minix.c                      |  5 +-
 disk-utils/mkswap.c                          |  6 +--
 disk-utils/sfdisk.c                          | 18 ++++---
 include/blkdev.h                             |  1 +
 lib/setproctitle.c                           |  2 +-
 lib/strutils.c                               |  2 +-
 libblkid/samples/partitions.c                |  4 +-
 libblkid/src/cache.c                         |  2 +-
 libblkid/src/config.c                        |  2 +-
 libblkid/src/dev.c                           |  2 +-
 libblkid/src/partitions/partitions.c         |  6 +--
 libblkid/src/probe.c                         | 28 +++++-----
 libblkid/src/superblocks/drbdproxy_datalog.c |  2 +-
 libblkid/src/superblocks/ntfs.c              |  8 +--
 libblkid/src/superblocks/vfat.c              |  3 +-
 libblkid/src/tag.c                           |  2 +-
 libfdisk/src/alignment.c                     |  2 +-
 libfdisk/src/ask.c                           |  4 +-
 libfdisk/src/dos.c                           |  2 +-
 libfdisk/src/gpt.c                           | 26 ++++-----
 libfdisk/src/partition.c                     | 31 ++++++-----
 libfdisk/src/script.c                        | 20 +++----
 libfdisk/src/sgi.c                           |  3 +-
 libfdisk/src/sun.c                           |  7 ++-
 libfdisk/src/table.c                         | 12 +++--
 libmount/src/btrfs.c                         |  2 +-
 login-utils/last.c                           |  2 +-
 login-utils/login.c                          |  2 +-
 misc-utils/getopt.c                          | 11 +++-
 misc-utils/test_uuidd.c                      |  4 +-
 misc-utils/wipefs.c                          | 18 ++++---
 sys-utils/swapon-common.c                    |  4 +-
 term-utils/agetty.c                          |  2 +-
 tests/expected/build-sys/config              |  0
 tests/expected/colcrt/functional             |  0
 tests/expected/colcrt/regressions            |  0
 tests/expected/cramfs/mkfs-endianness        | 80 +++++++++++++++++++++++++++-
 tests/expected/eject/umount                  |  0
 tests/expected/libmount/context-utab         |  3 +-
 tests/expected/libmount/context-utab-py      |  3 +-
 tests/expected/libmount/tabdiff              |  0
 tests/expected/logger/errors                 |  0
 tests/expected/logger/formats                |  0
 tests/expected/logger/options                |  0
 tests/expected/losetup/losetup               |  0
 tests/expected/minix/mkfs                    |  0
 tests/expected/misc/getopt2                  | 19 -------
 tests/expected/misc/getopt3                  |  0
 tests/expected/mount/fstab-btrfs             |  1 -
 tests/expected/mount/umount-alltargets       |  1 -
 tests/expected/script/options                |  0
 tests/expected/sfdisk/dos                    |  0
 tests/expected/sfdisk/gpt                    |  0
 tests/expected/sfdisk/resize                 |  0
 tests/functions.sh                           | 48 +++++++----------
 tests/ts/cramfs/mkfs                         | 19 ++++---
 tests/ts/cramfs/mkfs-endianness              |  5 +-
 tests/ts/libmount/context-utab               | 47 ++++++++--------
 tests/ts/libmount/context-utab-py            | 58 ++++++++++----------
 tests/ts/losetup/losetup                     |  1 -
 tests/ts/misc/getopt                         | 13 ++---
 tests/ts/misc/getopt2                        | 55 ++++++++++++-------
 text-utils/col.c                             |  4 +-
 65 files changed, 364 insertions(+), 268 deletions(-)
 delete mode 100644 tests/expected/build-sys/config
 delete mode 100644 tests/expected/colcrt/functional
 delete mode 100644 tests/expected/colcrt/regressions
 delete mode 100644 tests/expected/eject/umount
 delete mode 100644 tests/expected/libmount/tabdiff
 delete mode 100644 tests/expected/logger/errors
 delete mode 100644 tests/expected/logger/formats
 delete mode 100644 tests/expected/logger/options
 delete mode 100644 tests/expected/losetup/losetup
 delete mode 100644 tests/expected/minix/mkfs
 delete mode 100644 tests/expected/misc/getopt2
 delete mode 100644 tests/expected/misc/getopt3
 delete mode 100644 tests/expected/mount/fstab-btrfs
 delete mode 100644 tests/expected/script/options
 delete mode 100644 tests/expected/sfdisk/dos
 delete mode 100644 tests/expected/sfdisk/gpt
 delete mode 100644 tests/expected/sfdisk/resize

-- 
1.9.1

