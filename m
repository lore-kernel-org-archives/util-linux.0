Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f52.google.com ([74.125.83.52]:36479 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab3GGTy4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:54:56 -0400
Received: by mail-ee0-f52.google.com with SMTP id c50so2444102eek.11
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:54:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/34] pull: make printing quicker, and clang analysis
Date: Sun,  7 Jul 2013 20:54:15 +0100
Message-Id: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello all,

I quess the theme in this pull request is performance.  More than half of
the patches will make commands to do stuff quicker, either by printing
with better functions or stopping to do things that are unnecessary.  If
I did not misread my rather unscientific speed up measurements impact to
hexdump(1) and more(1) was greatest.


The following changes since commit 81499ab24e15532a8252c1e527d3301d9309c31e:

  findmnt: avoid unused parameter warning (2013-07-03 12:42:06 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk26

for you to fetch changes up to 7933fd2a938d148f08dfff6652834493f1e9f087:

  more: use variable lenght printf field width to print blanks (2013-07-06 02:25:18 +0100)

----------------------------------------------------------------
Sami Kerola (34):
      sfdisk: make unhiding as complete as possible
      docs: add missing options to sfdisk manual
      include: copy unlocked-io.h from gnulib
      hexdump: use unlocked io, and avoid use of printf()
      text-utils: use unlocked io
      misc-utils: use unlocked io
      scriptreplay: use unlocked io
      dmesg: use unlocked io, and avoid use of printf()
      utmpdump: use unlocked io, and avoid use of printf()
      dmesg: inform user --show-delta and iso8601 time format does not mix
      lib/loopdev: assigned value is never read [clang-analyzer]
      lib/mbsalign: initializations values are never read [clang-analyzer]
      libmount: fix memory leak [clang-analyzer]
      ipcs: assigned values are never read [clang-analyzer]
      lscpu: fix memory leak [clang-analyzer]
      more: assigned value is never read [clang-analyzer]
      utmpdump: assigned values are never read [clang-analyzer]
      mkfs.cramfs: argument to free() is a constant address [clang-analyzer]
      eject: assigned value is never read [clang-analyzer]
      chfn: assigned value is never read [clang-analyzer]
      mesg: assigned value is never read [clang-analyzer]
      rev: assigned value is never read [clang-analyzer]
      column: assigned value is never read [clang-analyzer]
      hwclock: assigned value is never read [clang-analyzer]
      dmesg: assigned value is never read [clang-analyzer]
      login: assigned value is never read [clang-analyzer]
      sfdisk: assigned value is never read [clang-analyzer]
      sulogin: fix memory leak [clang-analyzer]
      agetty: fix memory leak [clang-analyzer]
      dmesg: add missing initializer [clang-analyzer]
      ul: use correct types
      ul: use string printing function
      column: dereference of null pointer [clang-analyzer]
      more: use variable lenght printf field width to print blanks

 configure.ac                   |  13 ++++
 disk-utils/mkfs.cramfs.c       |   1 -
 fdisks/sfdisk.8                |  26 ++++++--
 fdisks/sfdisk.c                |   5 +-
 include/Makemodule.am          |   1 +
 include/unlocked-io.h          | 136 +++++++++++++++++++++++++++++++++++++++++
 lib/loopdev.c                  |   1 -
 lib/mbsalign.c                 |   4 +-
 libmount/src/utils.c           |   1 +
 login-utils/chfn.c             |   1 -
 login-utils/login.c            |   1 -
 login-utils/sulogin-consoles.c |   8 ++-
 login-utils/utmpdump.c         |  13 ++--
 misc-utils/cal.c               |   1 +
 misc-utils/findfs.c            |   1 +
 misc-utils/findmnt.c           |   1 +
 misc-utils/getopt.c            |   1 +
 misc-utils/look.c              |   1 +
 misc-utils/lsblk.c             |   1 +
 misc-utils/lslocks.c           |   1 +
 misc-utils/mcookie.c           |   1 +
 misc-utils/namei.c             |   1 +
 misc-utils/uuidd.c             |   2 +-
 misc-utils/uuidgen.c           |   1 +
 misc-utils/whereis.c           |   1 +
 sys-utils/dmesg.c              |  16 +++--
 sys-utils/eject.c              |   2 +-
 sys-utils/hwclock.c            |   1 -
 sys-utils/ipcs.c               |   3 -
 sys-utils/lscpu-dmi.c          |   4 +-
 term-utils/agetty.c            |   4 +-
 term-utils/mesg.c              |   1 -
 term-utils/scriptreplay.c      |   3 +-
 text-utils/col.c               |   1 +
 text-utils/colcrt.c            |   1 +
 text-utils/colrm.c             |   1 +
 text-utils/column.c            |   4 +-
 text-utils/display.c           |  11 ++--
 text-utils/hexsyntax.c         |   1 +
 text-utils/more.c              |   6 +-
 text-utils/pg.c                |   1 +
 text-utils/rev.c               |   3 +-
 text-utils/tailf.c             |   1 +
 text-utils/ul.c                |  13 ++--
 44 files changed, 251 insertions(+), 50 deletions(-)
 create mode 100644 include/unlocked-io.h


