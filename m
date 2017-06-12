Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:61474 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbdFLIuB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 04:50:01 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdnN3-1dUQjy0FwL-00Pahj for
 <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 10:49:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/6] fix various minor issues and warnings
Date: Mon, 12 Jun 2017 10:49:52 +0200
Message-Id: <20170612084958.22054-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Ruediger Meier (6):
  tests: fix fincore, don't use variable COLUMNS
  libmount: btrfs, remove unused setter functions
  hwclock: fix warning [-Winvalid-noreturn]
  misc: fix gcc-7 sprintf warnings -Wformat-overflow
  misc: fix gcc-7 snprintf warnings -Wformat-truncation
  libblkid: fix gcc-7 warning -Wint-in-bool-context

 lib/loopdev.c                    |  2 +-
 lib/sysfs.c                      |  4 ++--
 libblkid/src/devname.c           |  2 +-
 libblkid/src/superblocks/exfat.c |  4 ++--
 libmount/src/btrfs.c             |  4 ----
 login-utils/last.c               |  2 +-
 sys-utils/hwclock.c              |  2 +-
 sys-utils/hwclock.h              |  3 ++-
 tests/ts/fincore/count           | 12 ++++++------
 9 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.12.3

