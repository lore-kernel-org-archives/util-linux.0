Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33166 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbbFSTlK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Jun 2015 15:41:10 -0400
Received: by lbbvz5 with SMTP id vz5so30042822lbb.0
        for <util-linux@vger.kernel.org>; Fri, 19 Jun 2015 12:41:09 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH 0/3] cppcheck warnings fixes
Date: Sat, 20 Jun 2015 01:40:58 +0600
Message-Id: <1434742861-11704-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Following patches fix some cppcheck (version 1.70 dev) warnings.

Boris Egorov (3):
  sys-utils/disk-utils/lib: fix printf format types [cppcheck]
  libblkid/whereis: simplify some conditions [cppcheck]
  cfdisk: fix condition logic [cppcheck]

 disk-utils/cfdisk.c      |  2 +-
 disk-utils/fsck.cramfs.c |  6 +++---
 disk-utils/mkfs.bfs.c    |  6 +++---
 lib/cpuset.c             |  6 +++---
 libblkid/src/tag.c       |  2 +-
 misc-utils/whereis.c     |  2 +-
 sys-utils/chcpu.c        | 38 +++++++++++++++++++-------------------
 sys-utils/hwclock-rtc.c  |  2 +-
 sys-utils/ipcs.c         |  4 ++--
 sys-utils/readprofile.c  | 12 ++++++------
 10 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
