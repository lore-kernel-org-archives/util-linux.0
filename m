Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:51356 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbdF1QlF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:05 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MWhRH-1dENPN1laF-00XtND for <util-linux@vger.kernel.org>; Wed, 28 Jun 2017
 18:40:58 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/8] lib/path fixes and warnings
Date: Wed, 28 Jun 2017 18:40:49 +0200
Message-Id: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Also on github #476
https://github.com/karelzak/util-linux/pull/476

Ruediger Meier (8):
  lib/path: fix crash, pathbuf overflow
  lib/path: add error handling to path_vcreate()
  lsmem: fix, using freed memory
  lscpu: make clang analyzer happy
  misc: avoid some dead initialization warnings
  tools: add segfault detection for checkusage.sh
  setpriv: align --help
  hwclock: don't ifdef printf arguments

 include/path.h              | 11 +++++++--
 lib/mbsedit.c               |  3 ++-
 lib/path.c                  | 60 +++++++++++++++++++++++++++++++++------------
 misc-utils/findmnt-verify.c |  3 +--
 sys-utils/hwclock.c         | 10 +++-----
 sys-utils/lscpu.c           | 36 +++++++++++++--------------
 sys-utils/lsmem.c           | 22 +++++++++--------
 sys-utils/setpriv.c         |  2 +-
 tools/checkusage.sh         |  6 +++--
 9 files changed, 96 insertions(+), 57 deletions(-)

-- 
1.8.5.6

