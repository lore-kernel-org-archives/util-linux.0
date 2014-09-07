Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:62969 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaIGMnL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:11 -0400
Received: by mail-wg0-f41.google.com with SMTP id l18so13541453wgh.0
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/17] pull: miscellaneous changes
Date: Sun,  7 Sep 2014 13:42:48 +0100
Message-Id: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This patch set is full of random small changes all around the util-linux
code base.  I am pretty sure all changes are good, but it would be really
good if someone could double check the last one of the changes, setarch:
remove unreachable code, is correct.

While doing eject changes I noticed eject(1) executing umount(8).  That
works, but shouldn't the code be changed to use libmount?  Or is that a
pointless complication?



The following changes since commit 3c2e64b0ca73b90b80365842e95abb2858217e60:

  lsblk: add notes about udev to the man page (2014-09-05 10:02:45 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git misc

for you to fetch changes up to 04ea258e5dcdf71cdb1137266151e06ce348ed80:

  setarch: remove unreachable code (2014-09-07 13:30:14 +0100)


Sami Kerola (17):
  libuuid: add extern qualifiers to uuid/uuid.h system header
  include: simplify fputc_careful() in carefulputc.h
  lib: avoid use of obsolete getpass() function
  lib: add function to remove string from memory
  newgrp: use xgetpass() and memset_s() to group password validation
  last: make is_phantom() when kernel config does not include audit
    support
  last: improve code readability by renaming variable names
  zramctl: fix two format string warnings
  mountpoint: add struct mountpoint_control
  mkfs.minix: fix couple compiler warnings
  mountpoint: simplify if statement
  eject: add struct eject_control to remove global variables
  eject: make open_device() and select_speed() to use struct
    eject_control
  hwclock: remove referal to deprecated keyboard interface
  setarch: reindent code
  setarch: use personality() system call when it is available
  setarch: remove unreachable code

 disk-utils/mkfs.minix.c |  16 +-
 include/carefulputc.h   |  16 +-
 include/xgetpass.h      |   3 +-
 lib/xgetpass.c          |  68 ++++---
 libuuid/src/uuid.h      |  30 +--
 login-utils/last.c      |  53 +++--
 login-utils/newgrp.c    |   3 +-
 sys-utils/Makemodule.am |   3 +-
 sys-utils/eject.c       | 422 ++++++++++++++++++++--------------------
 sys-utils/hwclock-kd.c  | 180 -----------------
 sys-utils/hwclock.c     |   3 -
 sys-utils/hwclock.h     |   1 -
 sys-utils/mountpoint.c  |  93 ++++-----
 sys-utils/setarch.c     | 506 +++++++++++++++++++++++-------------------------
 sys-utils/zramctl.c     |   4 +-
 15 files changed, 609 insertions(+), 792 deletions(-)
 delete mode 100644 sys-utils/hwclock-kd.c

-- 
2.1.0

