Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:65484 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbeAWP7b (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jan 2018 10:59:31 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lux3h-1emdlY2mHJ-0104Bv for <util-linux@vger.kernel.org>; Tue, 23 Jan 2018
 16:59:29 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/7] fixes for fsck.cramfs and other things
Date: Tue, 23 Jan 2018 16:59:21 +0100
Message-Id: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Ruediger Meier (6):
  Revert "fsck.cramfs: Fix bus error on broken file system."
  fsck.cramfs: fix crash when superblock size is too small
  tests: rewrite fsck-bad-header
  fsck.cramfs: fix error message
  tests: fix fincore/count KNOWN_FAIL
  rfkill: provide RFKILL_TYPE_FM if undefined

root (1):
  tests: suppress warning for old sync(1)

 disk-utils/fsck.cramfs.c                          | 20 +++---
 sys-utils/rfkill.c                                |  5 ++
 tests/expected/cramfs/fsck-bad-header             |  2 -
 tests/expected/cramfs/fsck-bad-header-nopad-4K-be | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-nopad-4K-le | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-pad-4K-be   | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-pad-4K-le   | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-pad-64K-be  | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-pad-64K-le  | 29 +++++++++
 tests/functions.sh                                |  4 +-
 tests/ts/cramfs/fsck-bad-header                   | 76 +++++++++++++++++++++--
 tests/ts/fincore/count                            |  7 +--
 12 files changed, 266 insertions(+), 22 deletions(-)
 delete mode 100644 tests/expected/cramfs/fsck-bad-header
 create mode 100644 tests/expected/cramfs/fsck-bad-header-nopad-4K-be
 create mode 100644 tests/expected/cramfs/fsck-bad-header-nopad-4K-le
 create mode 100644 tests/expected/cramfs/fsck-bad-header-pad-4K-be
 create mode 100644 tests/expected/cramfs/fsck-bad-header-pad-4K-le
 create mode 100644 tests/expected/cramfs/fsck-bad-header-pad-64K-be
 create mode 100644 tests/expected/cramfs/fsck-bad-header-pad-64K-le

-- 
2.13.6

