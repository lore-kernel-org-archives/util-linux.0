Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36396 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHTwU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id e23so4713191wre.3
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/11] pull: various small changes
Date: Thu,  8 Jun 2017 20:52:04 +0100
Message-Id: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here's few changes that I have been holding back while the project was
having release freeze.  Most of the changes are related to various warnings
noticed before release, but that I did not think are important enough to be
sent while seeking for stability.  Functional improvements include rename(1)
shortcut to exit, and uuidgen(1) date parsing option.  Even if everything
else is rejected I really hope these two are accepted.
 
----------------------------------------------------------------
The following changes since commit f8416301c195d50a21cb54d9ea9abeccc40f9ee7:
  libmount: use mount table filter on --no-canonicalize (2017-06-07 11:35:26 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2017wk23
for you to fetch changes up to 53949f09430181beee4fb9f546d9a31313f4fd68:
  lib: remove _RLD_ from forbid environment variable list (2017-06-08 20:42:20 +0100)
----------------------------------------------------------------

Sami Kerola (11):
  misc: fallthrough fixes
  line: do not print new line if nothing else was printed
  rename: notice when expression and replacement are the same string
  uuidgen: slice up the usage text
  uuidgen: add --date option to display time when uuid was generated
  isosize: avoid reading more data than what is needed
  misc: fix reassigned values before old ones has been used [cppcheck]
  losetup: add missing initializer [clang]
  misc: remove stray semicolons
  lib: simplify cpuset if clauses that return
  lib: remove _RLD_ from forbid environment variable list

 bash-completion/uuidgen                 |  5 ++-
 disk-utils/cfdisk.c                     | 10 +++---
 disk-utils/fdisk-menu.c                 |  2 +-
 disk-utils/isosize.c                    | 57 ++++++---------------------------
 disk-utils/mkfs.cramfs.c                |  2 +-
 disk-utils/mkfs.minix.c                 |  2 +-
 disk-utils/sfdisk.c                     |  6 ++--
 include/c.h                             | 18 +++++++++++
 lib/cpuset.c                            | 12 +++----
 lib/env.c                               |  1 -
 lib/mbsalign.c                          |  2 +-
 libblkid/src/devno.c                    |  2 +-
 libblkid/src/probe.c                    |  2 +-
 libblkid/src/superblocks/adaptec_raid.c |  2 +-
 libblkid/src/topology/md.c              |  4 +--
 libfdisk/src/gpt.c                      |  2 +-
 libfdisk/src/script.c                   |  2 +-
 libmount/src/btrfs.c                    |  6 ++--
 libmount/src/cache.c                    |  6 ++--
 libmount/src/context.c                  |  2 +-
 libmount/src/context_mount.c            |  2 +-
 libmount/src/context_umount.c           |  4 +--
 libmount/src/optstr.c                   |  2 +-
 libmount/src/tab_diff.c                 |  4 +--
 libmount/src/tab_update.c               |  2 +-
 libsmartcols/src/column.c               |  4 +--
 libsmartcols/src/table_print.c          |  2 +-
 login-utils/last.c                      |  2 +-
 login-utils/lslogins.c                  |  4 +--
 login-utils/su-common.c                 |  1 +
 login-utils/sulogin.c                   |  7 ++--
 misc-utils/Makemodule.am                |  2 +-
 misc-utils/cal.c                        |  8 ++---
 misc-utils/findmnt-verify.c             |  2 +-
 misc-utils/findmnt.c                    | 10 +++---
 misc-utils/lsblk.c                      |  2 +-
 misc-utils/rename.c                     |  6 ++--
 misc-utils/test_uuidd.c                 |  2 +-
 misc-utils/uuidgen.1                    |  8 +++++
 misc-utils/uuidgen.c                    | 47 ++++++++++++++++++++++++---
 sys-utils/flock.c                       |  2 +-
 sys-utils/hwclock.c                     |  3 +-
 sys-utils/ipcrm.c                       |  3 ++
 sys-utils/losetup.c                     |  4 +--
 sys-utils/lsipc.c                       |  2 +-
 sys-utils/nsenter.c                     |  2 +-
 sys-utils/setarch.c                     |  2 +-
 sys-utils/swapon.c                      |  2 +-
 sys-utils/unshare.c                     |  4 +--
 term-utils/agetty.c                     |  4 +--
 term-utils/script.c                     |  4 +--
 term-utils/wall.c                       |  2 +-
 tests/expected/uuid/uuidgen             |  6 ++++
 tests/ts/uuid/uuidgen                   | 10 ++++++
 text-utils/column.c                     |  2 +-
 text-utils/hexdump-parse.c              |  2 +-
 text-utils/line.c                       |  6 ++--
 text-utils/more.c                       |  5 +--
 text-utils/pg.c                         |  4 +--
 text-utils/ul.c                         |  4 +--
 60 files changed, 195 insertions(+), 144 deletions(-)

-- 
2.13.1

