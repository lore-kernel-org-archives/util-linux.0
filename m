Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:60449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdFVUnq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jun 2017 16:43:46 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOCSm-1dRSLM2sYG-005XNE for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 22:43:44 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/5] Fix some exit codes (strutils.h and friends)
Date: Thu, 22 Jun 2017 22:43:39 +0200
Message-Id: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

As discussed on the mailing list, most importantly
we remove the -nonworking define STRTOXX_EXIT_CODE.

This is pull request #470 on github
https://github.com/karelzak/util-linux/pull/470

Ruediger Meier (5):
  misc: fix some broken exit codes
  lib: fix strutils.h, remove STRTOXX_EXIT_CODE
  misc: fix more strutils related exit codes
  misc: fix xalloc.h related exit codes
  misc: fix optutils.h related exit codes

 disk-utils/fsck.c        |  3 +--
 disk-utils/fsck.cramfs.c |  4 +++-
 disk-utils/fsck.minix.c  |  2 ++
 disk-utils/mkfs.cramfs.c |  4 +++-
 disk-utils/mkfs.minix.c  |  4 ++++
 include/strutils.h       |  7 ++-----
 lib/strutils.c           |  6 ++++++
 misc-utils/blkid.c       |  5 ++++-
 misc-utils/findfs.c      |  4 ++--
 sys-utils/flock.c        |  2 ++
 sys-utils/hwclock.c      |  3 +++
 sys-utils/mount.c        |  6 +++++-
 sys-utils/tunelp.c       | 10 +++++++---
 sys-utils/umount.c       |  6 +++++-
 14 files changed, 49 insertions(+), 17 deletions(-)

-- 
1.8.5.6

