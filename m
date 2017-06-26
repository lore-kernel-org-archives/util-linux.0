Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61278 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdFZS3z (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 14:29:55 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOTRh-1dLyPE1SVh-005oJv for
 <util-linux@vger.kernel.org>; Mon, 26 Jun 2017 20:29:53 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/6] consolidate help/version option descriptions
Date: Mon, 26 Jun 2017 20:29:46 +0200
Message-Id: <20170626182952.15988-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Hope you will like it.

The final description strings (last patch) are just a
proposal. ALso maybe better macro names!?

This pull request is also on github:
https://github.com/karelzak/util-linux/pull/474

Ruediger Meier (6):
  misc: revert to the old USAGE_HELP strings
  misc: introduce PRINT_USAGE_HELP()
  misc: consolidate all --help option descriptions
  blockdev: improve --help and man page
  login: add --help text
  misc: update --help content again

 Documentation/boilerplate.c |  3 +--
 disk-utils/addpart.c        |  3 +--
 disk-utils/blockdev.8       |  9 +++++++--
 disk-utils/blockdev.c       | 34 +++++++++++++++++++++++-----------
 disk-utils/cfdisk.c         |  3 +--
 disk-utils/delpart.c        |  3 +--
 disk-utils/fdformat.c       |  3 +--
 disk-utils/fdisk.c          |  3 +--
 disk-utils/fsck.c           |  4 ++--
 disk-utils/fsck.cramfs.c    |  5 ++---
 disk-utils/fsck.minix.c     |  3 +--
 disk-utils/isosize.c        |  3 +--
 disk-utils/mkfs.bfs.c       |  5 ++---
 disk-utils/mkfs.c           |  5 +----
 disk-utils/mkfs.cramfs.c    |  3 +--
 disk-utils/mkfs.minix.c     |  3 +--
 disk-utils/mkswap.c         |  5 +++--
 disk-utils/partx.c          |  3 +--
 disk-utils/raw.c            |  3 +--
 disk-utils/resizepart.c     |  3 +--
 disk-utils/sfdisk.c         |  4 ++--
 disk-utils/swaplabel.c      |  3 +--
 include/c.h                 | 14 ++++++++++++--
 login-utils/chfn.c          |  4 ++--
 login-utils/chsh.c          |  4 ++--
 login-utils/last.c          |  3 +--
 login-utils/login.c         |  8 ++++++++
 login-utils/lslogins.c      |  3 +--
 login-utils/newgrp.c        |  3 +--
 login-utils/nologin.c       |  3 +--
 login-utils/su-common.c     |  3 +--
 login-utils/sulogin.c       |  3 +--
 login-utils/utmpdump.c      |  3 +--
 login-utils/vipw.c          |  3 +--
 misc-utils/blkid.c          |  3 +--
 misc-utils/cal.c            |  3 +--
 misc-utils/fincore.c        |  3 +--
 misc-utils/findfs.c         |  3 +--
 misc-utils/findmnt.c        |  4 +---
 misc-utils/getopt.c         |  3 +--
 misc-utils/kill.c           |  3 +--
 misc-utils/logger.c         |  3 +--
 misc-utils/look.c           |  3 +--
 misc-utils/lsblk.c          |  3 +--
 misc-utils/lslocks.c        |  3 +--
 misc-utils/mcookie.c        |  3 +--
 misc-utils/namei.c          |  4 ++--
 misc-utils/rename.c         |  3 +--
 misc-utils/uuidd.c          |  3 +--
 misc-utils/uuidgen.c        |  3 +--
 misc-utils/uuidparse.c      |  3 +--
 misc-utils/whereis.c        |  3 +--
 misc-utils/wipefs.c         |  5 ++---
 schedutils/chrt.c           |  3 +--
 schedutils/ionice.c         |  3 +--
 schedutils/taskset.c        |  6 +++---
 sys-utils/blkdiscard.c      |  3 +--
 sys-utils/blkzone.c         |  3 +--
 sys-utils/chcpu.c           | 22 ++++++++++++----------
 sys-utils/chmem.c           |  3 +--
 sys-utils/ctrlaltdel.c      |  3 +--
 sys-utils/dmesg.c           |  5 ++---
 sys-utils/eject.c           |  3 +--
 sys-utils/fallocate.c       |  3 +--
 sys-utils/flock.c           |  3 +--
 sys-utils/fsfreeze.c        |  3 +--
 sys-utils/fstrim.c          |  3 +--
 sys-utils/hwclock.c         |  3 +--
 sys-utils/ipcmk.c           |  3 +--
 sys-utils/ipcrm.c           |  3 +--
 sys-utils/ipcs.c            |  3 +--
 sys-utils/ldattach.c        |  3 +--
 sys-utils/losetup.c         |  3 +--
 sys-utils/lscpu.c           |  3 +--
 sys-utils/lsipc.c           |  3 +--
 sys-utils/lsmem.c           |  3 +--
 sys-utils/lsns.c            |  3 +--
 sys-utils/mount.c           |  3 +--
 sys-utils/mountpoint.c      |  3 +--
 sys-utils/nsenter.c         |  3 +--
 sys-utils/pivot_root.c      |  3 +--
 sys-utils/prlimit.c         |  4 ++--
 sys-utils/readprofile.c     |  3 +--
 sys-utils/renice.c          |  3 +--
 sys-utils/rtcwake.c         |  3 +--
 sys-utils/setarch.c         |  3 +--
 sys-utils/setpriv.c         |  3 +--
 sys-utils/setsid.c          |  3 +--
 sys-utils/swapoff.c         |  3 +--
 sys-utils/swapon.c          |  3 +--
 sys-utils/switch_root.c     |  3 +--
 sys-utils/tunelp.c          |  3 +--
 sys-utils/umount.c          |  3 +--
 sys-utils/unshare.c         |  3 +--
 sys-utils/wdctl.c           |  3 +--
 sys-utils/zramctl.c         |  3 +--
 term-utils/agetty.c         |  4 ++--
 term-utils/mesg.c           |  3 +--
 term-utils/script.c         |  4 ++--
 term-utils/scriptreplay.c   |  4 ++--
 term-utils/setterm.c        |  5 +++--
 term-utils/wall.c           |  3 +--
 term-utils/write.c          |  3 +--
 text-utils/col.c            |  6 ++++--
 text-utils/colcrt.c         |  3 +--
 text-utils/colrm.c          |  3 +--
 text-utils/column.c         |  3 +--
 text-utils/hexdump.c        |  3 +--
 text-utils/line.c           |  3 +--
 text-utils/more.c           |  4 ++--
 text-utils/pg.c             |  3 +--
 text-utils/rev.c            |  3 +--
 text-utils/ul.c             |  3 +--
 113 files changed, 193 insertions(+), 249 deletions(-)

-- 
2.12.3

