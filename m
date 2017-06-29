Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbdF2CJL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 22:09:11 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyVcA-1dluKZ2FWA-015qxh for
 <util-linux@vger.kernel.org>; Thu, 29 Jun 2017 04:09:09 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/3] officially drop Linux < 2.6
Date: Thu, 29 Jun 2017 04:09:05 +0200
Message-Id: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

A few weeks ago I'd tried to make things incompatible
to justify ul version 3.0 ... not soo successful but
maybe these patches are useful anyways.

There are still some reference to older Kernels left
but I was too bored to find better words for these
cases.

Ruediger Meier (3):
  docs: remove some old history from manpages
  lib/blkdev: remove support for Linux < 2.6
  docs: correct line(1) deprecation comment

 Documentation/deprecated.txt |  2 +-
 disk-utils/mkfs.cramfs.8     |  2 +-
 disk-utils/mkfs.cramfs.c     |  5 +--
 include/pt-mbr-partnames.h   |  2 +-
 include/pt-mbr.h             |  2 +-
 lib/blkdev.c                 | 13 +------
 sys-utils/eject.1            |  6 +--
 sys-utils/mount.8            | 88 ++++++++------------------------------------
 sys-utils/readprofile.8      |  6 +--
 sys-utils/swapon.8           |  2 +-
 sys-utils/umount.8           |  5 +--
 11 files changed, 33 insertions(+), 100 deletions(-)

-- 
1.8.5.6

