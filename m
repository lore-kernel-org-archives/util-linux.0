Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56325 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbcCALoS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Mar 2016 06:44:18 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MHMRr-1afRxL0UVv-00E3pJ for
 <util-linux@vger.kernel.org>; Tue, 01 Mar 2016 12:44:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/4] Remove openat fallback functions
Date: Tue,  1 Mar 2016 12:44:10 +0100
Message-Id: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is github pull request #293:
https://github.com/karelzak/util-linux/pull/293

Ruediger Meier (4):
  lib: remove openat fallback functions (include/at.h)
  lib: move fopen_at() to fileutils.h, remove at.h
  fdisk: remove unused include sysfs.h
  build-sys: add and use openat build conditionals

 configure.ac                       |   7 +-
 disk-utils/fdisk.c                 |   1 -
 disk-utils/partx.c                 |   3 +-
 include/Makemodule.am              |   1 -
 include/at.h                       |  32 ---------
 include/fileutils.h                |  12 ++++
 lib/Makemodule.am                  |  21 +++---
 lib/at.c                           | 144 -------------------------------------
 lib/loopdev.c                      |   3 +-
 lib/procutils.c                    |   8 +--
 lib/sysfs.c                        |  15 ++--
 libblkid/src/devname.c             |   3 +-
 libblkid/src/devno.c               |   5 +-
 libmount/src/tab_parse.c           |  11 +--
 libsmartcols/samples/Makemodule.am |   4 +-
 misc-utils/lsblk.c                 |  11 +--
 misc-utils/lslocks.c               |   6 +-
 17 files changed, 60 insertions(+), 227 deletions(-)
 delete mode 100644 include/at.h
 delete mode 100644 lib/at.c

-- 
1.8.4.5

