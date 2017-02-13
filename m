Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33542 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdBMWGp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Feb 2017 17:06:45 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so561358wmv.0
        for <util-linux@vger.kernel.org>; Mon, 13 Feb 2017 14:06:45 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/7] pull: make smatch scan output easy to digest
Date: Mon, 13 Feb 2017 22:06:34 +0000
Message-Id: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I have had habit running smatch agains the project occasionally, and output
has always been noisy to the point not seeing the forest for the trees. 
This pull attempts to fix some genuine issues found with smatch, and trivial
warnings so that there is a lot less to digest when doing static analysis.

Changes 0002, 0003, and 0004 fall into later category -- and that is the
only justification they stand for.  Admittedly changing 0's to NULL has no
technical difference, but I do hope having this change encourages more
regular smatching of the code.

p.s.  I chose to refer patches 0002 and 0003 to avoid sending 150kb emails
to everyone on list.  Please see them from my remote repository instead, the
patch mails has direct link to github or you can add my remote branch using
details below.

----------------------------------------------------------------
The following changes since commit b192dd6943e5bb5d2a3773b2c9b06cbd4eb28258:
  lib/randutils: glibc 2.25 has getrandom(2) declaration (2017-02-13 14:14:28 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git smatch-fixes
for you to fetch changes up to ffd1a3c942bfe4dbf59584954a4eb0bf09c6b89b:
  findmnt: fix couple memory leaks [cppcheck] (2017-02-13 21:19:52 +0000)
----------------------------------------------------------------

Sami Kerola (7):
  cfdisk: avoid use of VLA in combination with sizeof() [smatch scan]
  misc: do not use plain 0 as NULL [smatch scan]
  misc: add static keyword to where needed [smatch scan]
  misc: unify function declarations [smatch scan]
  lib/idcache: add void to function declaration [smatch scan]
  libblkid: declare across file variables in blkidP.h [smatch scan]
  findmnt: fix couple memory leaks [cppcheck]

 Documentation/boilerplate.c           |  18 +++---
 disk-utils/addpart.c                  |   6 +-
 disk-utils/cfdisk.c                   |  15 +++--
 disk-utils/delpart.c                  |   6 +-
 disk-utils/fdformat.c                 |   2 +-
 disk-utils/fdisk-menu.c               |  16 ++---
 disk-utils/fsck.c                     |  26 ++++----
 disk-utils/fsck.cramfs.c              |  22 +++----
 disk-utils/isosize.c                  |  10 +--
 disk-utils/mkfs.cramfs.c              |   6 +-
 disk-utils/mkswap.c                   |  18 +++---
 disk-utils/partx.c                    |   4 +-
 disk-utils/raw.c                      |  18 +++---
 disk-utils/resizepart.c               |   6 +-
 disk-utils/sfdisk.c                   |   4 +-
 disk-utils/swaplabel.c                |  10 +--
 include/pt-mbr-partnames.h            |   2 +-
 lib/colors.c                          |   2 +-
 lib/exec_shell.c                      |   2 +-
 lib/idcache.c                         |   2 +-
 lib/loopdev.c                         |   2 +-
 lib/randutils.c                       |   4 +-
 lib/timer.c                           |   2 +-
 libblkid/src/blkidP.h                 |   5 ++
 libblkid/src/dev.c                    |   6 +-
 libblkid/src/devname.c                |  12 ++--
 libblkid/src/probe.c                  |   5 --
 libblkid/src/read.c                   |   6 +-
 libblkid/src/resolve.c                |   2 +-
 libblkid/src/superblocks/drbdmanage.c |   2 +-
 libblkid/src/superblocks/vfat.c       |   2 +-
 libblkid/src/tag.c                    |  12 ++--
 libblkid/src/topology/evms.c          |   2 +-
 libblkid/src/verify.c                 |   4 +-
 libfdisk/src/bsd.c                    |   2 +-
 libfdisk/src/context.c                |   4 +-
 libfdisk/src/sun.c                    |   2 +-
 libmount/python/context.c             |  46 +++++++-------
 libmount/python/fs.c                  |  46 +++++++-------
 libmount/python/pylibmount.c          |   2 +-
 libmount/python/tab.c                 |  46 +++++++-------
 libuuid/src/gen_uuid.c                |  10 +--
 login-utils/chfn.c                    |  14 ++---
 login-utils/chsh.c                    |  12 ++--
 login-utils/nologin.c                 |   6 +-
 login-utils/su-common.c               |   9 ++-
 login-utils/sulogin.c                 |  22 +++----
 login-utils/utmpdump.c                |  12 ++--
 login-utils/vipw.c                    |  11 ++--
 misc-utils/blkid.c                    |   2 +-
 misc-utils/cal.c                      |   4 +-
 misc-utils/findmnt-verify.c           |  10 +--
 misc-utils/findmnt.c                  |  78 +++++++++++------------
 misc-utils/getopt.c                   |   4 +-
 misc-utils/kill.c                     |   2 +-
 misc-utils/look.c                     |  18 +++---
 misc-utils/lsblk.c                    |  64 +++++++++----------
 misc-utils/namei.c                    |  18 +++---
 misc-utils/whereis.c                  |   2 +-
 misc-utils/wipefs.c                   |  22 +++----
 schedutils/ionice.c                   |   2 +-
 sys-utils/blkdiscard.c                |  18 +++---
 sys-utils/chcpu.c                     |  18 +++---
 sys-utils/eject.c                     |   4 +-
 sys-utils/fallocate.c                 |  26 ++++----
 sys-utils/flock.c                     |   2 +-
 sys-utils/fsfreeze.c                  |  10 +--
 sys-utils/fstrim.c                    |  16 ++---
 sys-utils/hwclock-cmos.c              |  26 ++++----
 sys-utils/hwclock.c                   |  71 +++++++++++----------
 sys-utils/hwclock.h                   |   7 ++-
 sys-utils/ipcs.c                      |   2 +-
 sys-utils/losetup.c                   |  44 ++++++-------
 sys-utils/lscpu.c                     |  36 +++++------
 sys-utils/lsipc.c                     |  42 ++++++-------
 sys-utils/lsns.c                      |   4 +-
 sys-utils/mount.c                     |  68 ++++++++++----------
 sys-utils/mountpoint.c                |  14 ++---
 sys-utils/prlimit.c                   |   2 +-
 sys-utils/readprofile.c               |   6 +-
 sys-utils/renice.c                    |   2 +-
 sys-utils/rtcwake.c                   |  32 +++++-----
 sys-utils/setpriv.c                   |  44 ++++++-------
 sys-utils/swapoff.c                   |  10 +--
 sys-utils/swapon.c                    |  34 +++++-----
 sys-utils/tunelp.c                    |  22 +++----
 sys-utils/umount.c                    |  34 +++++-----
 sys-utils/unshare.c                   |  34 +++++-----
 term-utils/agetty.c                   |  86 ++++++++++++-------------
 term-utils/mesg.c                     |   8 +--
 term-utils/script.c                   |   2 +-
 term-utils/setterm.c                  |   2 +-
 term-utils/wall.c                     |  12 ++--
 text-utils/col.c                      |  34 +++++-----
 text-utils/colcrt.c                   |   2 +-
 text-utils/colrm.c                    |   6 +-
 text-utils/column.c                   |  22 +++----
 text-utils/more.c                     | 115 +++++++++++++++++-----------------
 text-utils/pg.c                       |  64 +++++++++----------
 text-utils/rev.c                      |   8 +--
 text-utils/tailf.c                    |  10 +--
 text-utils/ul.c                       |  55 ++++++++--------
 102 files changed, 895 insertions(+), 890 deletions(-)

-- 
2.11.1

