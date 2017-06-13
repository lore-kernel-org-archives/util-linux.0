Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbdFMPcx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 11:32:53 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRB8F-1dGEjD1NXT-00Udlh for
 <util-linux@vger.kernel.org>; Tue, 13 Jun 2017 17:32:36 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/5] Fix even more random compiler warnings
Date: Tue, 13 Jun 2017 17:32:30 +0200
Message-Id: <20170613153235.11164-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Two patches regarding "taking address of packed member". The first
one (sun) makes things more nice, the second one (gpt) is more ugly.
Don't know how serious the problem is, see
https://stackoverflow.com/questions/8568432/is-gccs-attribute-packed-pragma-pack-unsafe

The wall/OSX patch is maybe too ugly and probably does not fix
a real issue. Maybe skip it.

Ruediger Meier (5):
  libfdisk: cleanup sun label checksum usuage
  libfdisk: fix guid usage of packed structure gpt_entry
  libsmartcols: fix warning "unused parameter"
  wall: fix OSX getgrouplist, gid_t* vs int*
  tests: add more tests for line(1)

 include/pt-sun.h               |  2 +-
 libfdisk/src/gpt.c             | 37 +++++++++++++++++++++++++++----------
 libfdisk/src/sun.c             | 33 +++++++--------------------------
 libsmartcols/src/table_print.c |  9 +++++++--
 term-utils/wall.c              | 13 ++++++++++---
 tests/expected/misc/line       | 18 ++++++++++++++++++
 tests/ts/misc/line             | 28 ++++++++++++++++++++++++----
 7 files changed, 94 insertions(+), 46 deletions(-)

-- 
2.12.3

