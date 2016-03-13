Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58813 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbcCMWbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:25 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LcVOE-1ZwW7g22Vi-00jqN1 for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:22 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 00/12] travis: add trusty and osx
Date: Sun, 13 Mar 2016 23:31:08 +0100
Message-Id: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This patch-set fixes some tests and build issues and adds OSX
and Ubuntu Trusty to our travis build matrix.

You may watch the new build logs:
https://travis-ci.org/rudimeier/util-linux/builds/115726134

This is github pull request #304
https://github.com/karelzak/util-linux/pull/304

Ruediger Meier (12):
  misc: fix printf i386 compiler warnings
  misc: fix icc/clang compiler warnings
  tests: skip old socat silently
  tests: remove invalid argument in libmount/debug
  tests: improve skipping of old btrfs-tools
  tests: don't use system's mount commands
  build-sys: fix again UL_SCANF_TYPE_MODIFIER
  build-sys: add missing "not found" strings
  build-sys: use AC_PROG_MKDIR_P and remove a few gnuisms
  build-sys: improve uuidd and script build conditions
  travis: switch to Ubuntu 14.04 Trusty
  travis: add OSX build

 .travis-functions.sh                    | 69 +++++++++++++++++++++++++++-----
 .travis.yml                             | 14 +++++++
 Makefile.am                             |  2 +-
 configure.ac                            | 21 +++++-----
 disk-utils/fdisk-menu.c                 |  4 +-
 libblkid/src/Makemodule.am              |  2 +-
 libfdisk/src/Makemodule.am              |  2 +-
 libfdisk/src/alignment.c                |  2 +-
 libmount/src/Makemodule.am              |  2 +-
 libmount/src/monitor.c                  |  2 +-
 libmount/src/tab.c                      |  5 +--
 libsmartcols/src/Makemodule.am          |  2 +-
 libsmartcols/src/table_print.c          |  3 +-
 libuuid/src/Makemodule.am               |  2 +-
 login-utils/vipw.c                      |  2 +-
 sys-utils/Makemodule.am                 |  2 +-
 sys-utils/lsns.c                        |  7 ++--
 tests/expected/libmount/context-utab    |  1 -
 tests/expected/libmount/context-utab-py |  1 -
 tests/functions.sh                      | 17 ++++----
 tests/ts/eject/umount                   | 11 +++---
 tests/ts/libmount/context               |  2 +-
 tests/ts/libmount/context-py            |  2 +-
 tests/ts/libmount/context-utab          | 69 ++++++++++++++++----------------
 tests/ts/libmount/context-utab-py       | 70 +++++++++++++++++----------------
 tests/ts/libmount/debug                 |  4 +-
 tests/ts/mount/fstab-btrfs              |  8 ++--
 27 files changed, 202 insertions(+), 126 deletions(-)

-- 
1.8.4.5

