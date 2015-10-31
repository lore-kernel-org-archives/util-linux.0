Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34617 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbbJaTVa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:30 -0400
Received: by wikq8 with SMTP id q8so29535639wik.1
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/12] pull: race fixes
Date: Sat, 31 Oct 2015 19:21:12 +0000
Message-Id: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I had a look of all chmod(3), chown(3), and stat(3) calls in executables if
there are file operation, preceeded by open(3) in unsafe manner.  The
changes in this pull request attempsts to correct these TACTOU cases.

The pull request has also few improvements, such as checking block device
correct way when ever opening them to write in them and replacements stat(3)
with access(3) when applicable.


----------------------------------------------------------------
The following changes since commit 4419ffb9eff5801fdbd385a4a6199b3877f802ad:
  lib/sysfs: make sysfs_get_devname()/blkid_devno_to_wholedisk() more robust (2015-10-30 11:08:32 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git races
for you to fetch changes up to 09acbb45083e37f112f3d0558f4875f94db457d4:
  fdformat: fix block device open race (2015-10-31 19:00:09 +0000)
----------------------------------------------------------------

Sami Kerola (12):
  login: fix stat(2) race
  swapon: fix stat(3) and open(3) race
  fsck: retire stat(3) when access(3) does better job
  agetty: fix chown(3), chmod(3) and open(3) race
  script, hwclock: check file exist with access(3) rather than stat(3)
  lib/fileutils: add is_same_inode() check
  include/blkdev: add open_blkdev_or_file() function
  mkfs.bfs: fix block device open race
  mkfs.minix: fix block device open race
  mkswap: fix block device open race
  mesg: fix multiple races
  fdformat: fix block device open race

 disk-utils/fdformat.c   | 11 ++++-------
 disk-utils/fsck.c       |  3 +--
 disk-utils/mkfs.bfs.c   |  2 +-
 disk-utils/mkfs.minix.c |  9 +++------
 disk-utils/mkswap.c     | 25 ++++++++-----------------
 include/blkdev.h        |  3 +++
 include/fileutils.h     | 14 ++++++++++++++
 lib/blkdev.c            | 27 +++++++++++++++++++++++++++
 login-utils/login.c     |  6 ++----
 sys-utils/hwclock.c     |  5 +----
 sys-utils/swapon.c      | 14 +++++++-------
 term-utils/agetty.c     | 10 +++++-----
 term-utils/mesg.c       | 25 +++++++++++++++++--------
 term-utils/script.c     |  3 +--
 14 files changed, 94 insertions(+), 63 deletions(-)

-- 
2.6.2

