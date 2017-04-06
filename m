Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:61359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756734AbdDFH4M (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 03:56:12 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 0/5] some fincore fixes
Date: Thu,  6 Apr 2017 09:56:00 +0200
Message-Id: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This patch-set tries to make the fincore tests more reliable on non-x86
systems and some non-default file systems. It discoverd one bug in
fincore itself.

Ruediger Meier (5):
  tests: remove fincore SMALLER_THAN_PAGESIZE tests
  tests: fix fincore/count for PAGE_SIZE != 4096
  fincore: fix multiplication overflow
  tests: handle dd errors in fincore/count
  tests: fincore/count, skip unsupported FS

 misc-utils/fincore.c                |  2 +-
 tests/expected/fincore/count        | 61 --------------------------------
 tests/expected/fincore/count.4096   | 55 +++++++++++++++++++++++++++++
 tests/expected/fincore/count.65536  | 55 +++++++++++++++++++++++++++++
 tests/expected/fincore/count.nosize | 55 +++++++++++++++++++++++++++++
 tests/ts/fincore/count              | 70 ++++++++++++++++++++++++++-----------
 6 files changed, 215 insertions(+), 83 deletions(-)
 delete mode 100644 tests/expected/fincore/count
 create mode 100644 tests/expected/fincore/count.4096
 create mode 100644 tests/expected/fincore/count.65536
 create mode 100644 tests/expected/fincore/count.nosize

-- 
1.8.5.6

