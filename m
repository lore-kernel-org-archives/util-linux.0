Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:57557 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652AbcCPMSX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 08:18:23 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0LreCz-1ZfHmr0Ttd-013RBT for
 <util-linux@vger.kernel.org>; Wed, 16 Mar 2016 13:18:20 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 0/3] lscpu: Fix model and model name on Power Systems
Date: Wed, 16 Mar 2016 13:18:16 +0100
Message-Id: <1458130699-25464-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

As discussed the new logic moved to the print sections. Plus fix for a
memory leak.

Ruediger Meier (3):
  Revert "lscpu: keep lscpu usable on snapshots"
  lscpu: use cpu and revision tag if available
  lscpu: fix memleak because of ambiguous tags

 sys-utils/lscpu.c                             | 35 +++++++++------------------
 tests/expected/lscpu/lscpu-ppc-qemu           |  3 ++-
 tests/expected/lscpu/lscpu-ppc64-POWER7       |  3 ++-
 tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu |  3 ++-
 tests/expected/lscpu/lscpu-sparc64            |  1 +
 tests/expected/lscpu/lscpu-x86_64-64cpu       |  2 +-
 tests/expected/lscpu/lscpu-x86_64-dell_e4310  |  2 +-
 7 files changed, 21 insertions(+), 28 deletions(-)

-- 
1.8.4.5

