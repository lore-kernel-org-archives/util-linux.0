Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55260 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbcCCBLI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 20:11:08 -0500
Received: from tenfore.ga-group.nl ([77.12.144.244]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0MRjd7-1aUVN51UOf-00T0MX for
 <util-linux@vger.kernel.org>; Thu, 03 Mar 2016 02:11:06 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/7] fix minix, big endian
Date: Thu,  3 Mar 2016 02:10:58 +0100
Message-Id: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Motivation for this patch-set was to fix the minix tests for big endian
systems. Of course this discovered some issues in the test suite and in
our minix progs.

This is github pull request #294
https://github.com/karelzak/util-linux/pull/294

Ruediger Meier (7):
  tests: scsi_debug sleep
  tests: minix, use hexdump instead of md5sum
  tests: minix, some corrections and cleanup
  fsck.minix: fix v3 version offset
  mkfs.minix: fix v2/v3 .badblocks inode number for big endian
  tests: fix minix tests for big endian
  tests: minix, add a useful non-root check

 disk-utils/fsck.minix.c                          |   5 +-
 disk-utils/mkfs.minix.c                          |   5 +-
 tests/expected/minix/fsck                        | 366 ++++++++++++++++++++++-
 tests/expected/minix/fsck-images-auto-fix        |  30 +-
 tests/expected/minix/fsck-images-badblocks       |  35 +++
 tests/expected/minix/fsck-images-badblocks.BE    |  35 +++
 tests/expected/minix/fsck-images-broken-root     |   2 +-
 tests/expected/minix/fsck-images-bug.773892      |   2 +-
 tests/expected/minix/fsck-images-check-blocks    |  22 +-
 tests/expected/minix/fsck-images-check-blocks.BE |  29 ++
 tests/expected/minix/fsck-images-v1c14           |  21 +-
 tests/expected/minix/fsck-images-v1c14.BE        |  28 ++
 tests/expected/minix/fsck-images-v1c30           |  22 +-
 tests/expected/minix/fsck-images-v1c30.BE        |  29 ++
 tests/expected/minix/fsck-images-v2c14           |  22 +-
 tests/expected/minix/fsck-images-v2c14.BE        |  29 ++
 tests/expected/minix/fsck-images-v2c30           |  23 +-
 tests/expected/minix/fsck-images-v2c30.BE        |  30 ++
 tests/expected/minix/fsck-images-v3c60           |  24 +-
 tests/expected/minix/fsck-images-v3c60.BE        |  31 ++
 tests/functions.sh                               |   1 +
 tests/ts/minix/fsck                              |  45 ++-
 tests/ts/minix/fsck-images                       |  44 ++-
 tests/ts/minix/mkfs                              |   2 +-
 24 files changed, 837 insertions(+), 45 deletions(-)
 create mode 100644 tests/expected/minix/fsck-images-badblocks
 create mode 100644 tests/expected/minix/fsck-images-badblocks.BE
 create mode 100644 tests/expected/minix/fsck-images-check-blocks.BE
 create mode 100644 tests/expected/minix/fsck-images-v1c14.BE
 create mode 100644 tests/expected/minix/fsck-images-v1c30.BE
 create mode 100644 tests/expected/minix/fsck-images-v2c14.BE
 create mode 100644 tests/expected/minix/fsck-images-v2c30.BE
 create mode 100644 tests/expected/minix/fsck-images-v3c60.BE

-- 
1.8.4.5

