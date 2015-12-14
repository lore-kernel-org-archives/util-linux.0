Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38118 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbbLNVy7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Dec 2015 16:54:59 -0500
Received: by wmpp66 with SMTP id p66so79821638wmp.1
        for <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:54:57 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/8] pull: bash-completion updates
Date: Mon, 14 Dec 2015 21:54:45 +0000
Message-Id: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This pull request is about bash-completion, and couple fixes I noticed ought
be done while working with the completion stuff.  The pull adds new
function, print_long_opts(), to c.h and it does what one might expect a
function of such name do.

My reasoning to add the function is simple; time after time contributors
forget to update bash-completion files, and since people are unlikely to
change make the code to compensate.  There is also added bonus - option name
and bash completion file mismatches become much harder to create (but not
impossible, the option argument completions can have mismatch).


----------------------------------------------------------------
The following changes since commit 11290b849fc67eab0752dc43e5c6cb8038195a8a:
  wipefs: Allow b to be used as the short option for backup (2015-12-11 11:05:45 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git bash-completion
for you to fetch changes up to 336d02ff6cde565f6e2a443c2ecb2a4a265d27c0:
  bash-completion: lsns: add missing completion file (2015-12-14 21:34:30 +0000)
----------------------------------------------------------------

Sami Kerola (8):
  include/c: add long options printing function
  misc: add --print-long-opts to most of the commands
  bash-completion: fsck.cramfs, isosize: find files an argument
  isosize: stop unmeaningful printing errno message
  setsid: fix argument count bug
  bash-completion: ipcmk: add missing completion file
  bash-completion: lslogins: add missing completion file
  bash-completion: lsns: add missing completion file

 Documentation/boilerplate.c   |  9 +++++++-
 bash-completion/Makemodule.am |  9 ++++++++
 bash-completion/blkdiscard    |  3 +--
 bash-completion/cal           | 17 +-------------
 bash-completion/cfdisk        |  6 +----
 bash-completion/chcpu         | 10 +--------
 bash-completion/chfn          |  3 +--
 bash-completion/chrt          | 17 +-------------
 bash-completion/chsh          |  5 ++---
 bash-completion/col           | 10 +--------
 bash-completion/colcrt        |  6 +----
 bash-completion/colrm         |  3 +--
 bash-completion/column        |  9 +-------
 bash-completion/dmesg         | 26 +---------------------
 bash-completion/eject         | 24 ++------------------
 bash-completion/fallocate     | 10 +--------
 bash-completion/fdformat      |  3 +--
 bash-completion/fdisk         | 15 +------------
 bash-completion/findmnt       | 33 +--------------------------
 bash-completion/flock         | 12 +---------
 bash-completion/fsck.cramfs   | 11 +++++++--
 bash-completion/fsck.minix    |  3 +--
 bash-completion/fsfreeze      |  3 +--
 bash-completion/fstrim        |  9 +-------
 bash-completion/getopt        |  3 +--
 bash-completion/hexdump       | 15 +------------
 bash-completion/hwclock       | 25 +--------------------
 bash-completion/ionice        |  3 +--
 bash-completion/ipcmk         | 27 ++++++++++++++++++++++
 bash-completion/ipcrm         | 12 +---------
 bash-completion/ipcs          | 16 +------------
 bash-completion/isosize       | 11 +++++++--
 bash-completion/last          |  3 +--
 bash-completion/ldattach      | 14 +-----------
 bash-completion/logger        | 24 +-------------------
 bash-completion/look          |  3 +--
 bash-completion/losetup       | 18 +--------------
 bash-completion/lsblk         | 23 +------------------
 bash-completion/lscpu         | 11 +--------
 bash-completion/lsipc         | 22 +-----------------
 bash-completion/lslocks       | 10 +--------
 bash-completion/lslogins      | 52 +++++++++++++++++++++++++++++++++++++++++++
 bash-completion/lsns          | 39 ++++++++++++++++++++++++++++++++
 bash-completion/mcookie       |  3 +--
 bash-completion/mesg          |  3 +--
 bash-completion/mkfs          |  3 +--
 bash-completion/mkfs.bfs      |  3 +--
 bash-completion/mkfs.minix    |  3 +--
 bash-completion/mkswap        |  3 +--
 bash-completion/mount         | 33 +--------------------------
 bash-completion/mountpoint    |  3 +--
 bash-completion/namei         |  3 +--
 bash-completion/newgrp        |  3 +--
 bash-completion/nsenter       | 14 +-----------
 bash-completion/partx         |  3 +--
 bash-completion/prlimit       | 25 +--------------------
 bash-completion/raw           |  4 +---
 bash-completion/readprofile   | 14 +-----------
 bash-completion/rtcwake       | 13 +----------
 bash-completion/script        | 11 +--------
 bash-completion/scriptreplay  |  7 +-----
 bash-completion/setarch       | 17 +-------------
 bash-completion/setpriv       | 20 +----------------
 bash-completion/setsid        |  3 +--
 bash-completion/setterm       | 39 +-------------------------------
 bash-completion/sfdisk        | 32 +-------------------------
 bash-completion/su            | 13 +----------
 bash-completion/swaplabel     |  3 +--
 bash-completion/swapoff       |  8 +------
 bash-completion/swapon        | 15 +------------
 bash-completion/tailf         |  3 +--
 bash-completion/taskset       |  3 +--
 bash-completion/tunelp        | 15 +------------
 bash-completion/ul            |  3 +--
 bash-completion/umount        | 18 +--------------
 bash-completion/unshare       | 10 +--------
 bash-completion/utmpdump      |  3 +--
 bash-completion/uuidd         |  3 +--
 bash-completion/uuidgen       |  3 +--
 bash-completion/wall          |  3 +--
 bash-completion/wdctl         | 14 +-----------
 bash-completion/wipefs        |  3 +--
 bash-completion/zramctl       | 13 +----------
 disk-utils/cfdisk.c           |  8 +++++++
 disk-utils/fdformat.c         |  9 +++++++-
 disk-utils/fdisk.c            |  8 ++++++-
 disk-utils/fsck.cramfs.c      |  9 +++++++-
 disk-utils/fsck.minix.c       |  8 +++++++
 disk-utils/isosize.c          | 11 +++++++--
 disk-utils/mkfs.bfs.c         | 13 +++++++----
 disk-utils/mkfs.c             | 11 +++++++--
 disk-utils/mkfs.minix.c       |  8 +++++++
 disk-utils/mkswap.c           |  9 +++++++-
 disk-utils/partx.c            |  9 +++++++-
 disk-utils/raw.c              |  9 +++++++-
 disk-utils/sfdisk.c           |  8 ++++++-
 disk-utils/swaplabel.c        |  9 +++++++-
 include/c.h                   | 21 +++++++++++++++++
 login-utils/chfn.c            |  8 +++++++
 login-utils/chsh.c            |  8 +++++++
 login-utils/last.c            |  8 ++++++-
 login-utils/lslogins.c        |  8 ++++++-
 login-utils/newgrp.c          | 10 ++++++++-
 login-utils/su-common.c       | 10 ++++++++-
 login-utils/utmpdump.c        |  9 +++++++-
 misc-utils/cal.c              |  8 ++++++-
 misc-utils/findmnt.c          |  9 +++++++-
 misc-utils/getopt.c           |  8 +++++++
 misc-utils/logger.c           |  8 ++++++-
 misc-utils/look.c             |  9 +++++++-
 misc-utils/lsblk.c            |  9 +++++++-
 misc-utils/lslocks.c          |  8 +++++++
 misc-utils/mcookie.c          |  9 +++++++-
 misc-utils/namei.c            |  9 +++++++-
 misc-utils/uuidd.c            |  9 +++++++-
 misc-utils/uuidgen.c          |  8 ++++++-
 misc-utils/wipefs.c           | 10 +++++++--
 schedutils/chrt.c             |  8 +++++++
 schedutils/ionice.c           |  9 +++++++-
 schedutils/taskset.c          |  8 ++++++-
 sys-utils/blkdiscard.c        |  8 +++++++
 sys-utils/chcpu.c             |  9 +++++++-
 sys-utils/dmesg.c             |  8 ++++++-
 sys-utils/eject.c             |  8 +++++++
 sys-utils/fallocate.c         |  9 +++++++-
 sys-utils/flock.c             |  8 ++++++-
 sys-utils/fsfreeze.c          |  9 +++++++-
 sys-utils/fstrim.c            |  9 +++++++-
 sys-utils/hwclock.c           |  7 +++++-
 sys-utils/ipcmk.c             |  8 +++++++
 sys-utils/ipcrm.c             |  9 +++++++-
 sys-utils/ipcs.c              |  8 ++++++-
 sys-utils/ldattach.c          |  9 +++++++-
 sys-utils/losetup.c           |  8 ++++++-
 sys-utils/lscpu.c             |  9 +++++++-
 sys-utils/lsipc.c             |  8 ++++++-
 sys-utils/lsns.c              |  8 +++++++
 sys-utils/mount.c             |  9 +++++++-
 sys-utils/mountpoint.c        |  9 +++++++-
 sys-utils/nsenter.c           |  8 ++++++-
 sys-utils/prlimit.c           |  8 +++++--
 sys-utils/readprofile.c       |  9 +++++++-
 sys-utils/rtcwake.c           |  8 ++++++-
 sys-utils/setarch.c           |  8 ++++++-
 sys-utils/setpriv.c           |  8 ++++++-
 sys-utils/setsid.c            | 12 +++++++---
 sys-utils/swapoff.c           |  9 +++++++-
 sys-utils/swapon.c            |  8 ++++++-
 sys-utils/tunelp.c            |  8 +++++++
 sys-utils/umount.c            | 11 +++++++--
 sys-utils/unshare.c           |  8 ++++++-
 sys-utils/wdctl.c             | 10 +++++++--
 sys-utils/zramctl.c           | 10 ++++++++-
 term-utils/mesg.c             |  9 +++++++-
 term-utils/script.c           |  9 +++++++-
 term-utils/scriptreplay.c     | 10 +++++++--
 term-utils/setterm.c          |  7 +++++-
 term-utils/wall.c             |  9 +++++++-
 text-utils/col.c              |  7 ++++++
 text-utils/colcrt.c           | 11 +++++++--
 text-utils/colrm.c            |  8 +++++++
 text-utils/column.c           |  8 +++++++
 text-utils/hexdump.c          | 10 +++++++--
 text-utils/tailf.c            | 11 +++++++--
 text-utils/ul.c               |  9 +++++++-
 165 files changed, 884 insertions(+), 831 deletions(-)
 create mode 100644 bash-completion/ipcmk
 create mode 100644 bash-completion/lslogins
 create mode 100644 bash-completion/lsns

-- 
2.6.4

