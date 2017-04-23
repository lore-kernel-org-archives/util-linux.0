Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36484 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046000AbdDWU6i (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so10010876wrc.3
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/10] pull: various change, some options related
Date: Sun, 23 Apr 2017 21:58:11 +0100
Message-Id: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Sometime ago bash completions got updates.  In this pull request lspci,
blkid, and partx changes were directly inspired by the earlier changes.  For
example I were pretty upset to notice partx had years solaris_x86 in --type
argument hints, so I am proposing to derive valid strings from libblkid with
full understanding this is probably over engineering.

While working with options updates and doing some raw(8) reseach I started
to think we really should slap note to manual page these devices are no
longer recommended.  There was discussion about 10 years ago about attempt
to get rid of /dev/raw but that did not work out.

su(1) and logger(1) changes were something that -Wignored-qualifiers flagged
when I tried my experimental 'try enabling all warnings' build.  Will these
changes make practical difference is a good question.  The ternary operators
change is very similar.

After adding getops_long to findfs(8) there are not many commands left
without libc options parsing that are blockdev(8), fsck(8), kill(1),
more(1), pg(1), renice(1), switch_root(8), vipw(8), and whereis(1).  Some in
the list are ok as is (blockdev), other are or should be deprecated (pg,
whereis), and some do are quite difficult to make work with standard getopts
(kill, renice).  Maybe the few commands that could be aligned should receive
that treatment.

The chfn and chsh is about usability provided by readline().  I did not add
#ifdev HAVE_LIBREADLINE and make none libreadline compilation to work
because it looks like sfdisk is doing the same.  Let me know if fallback
should be made to work.

----------------------------------------------------------------
The following changes since commit be685b98c03b43c34d0f6e0447361f7d2dcdae9a:
  lsblk: don't duplicate columns (2017-04-19 14:28:16 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2017wk16
for you to fetch changes up to 5d24971f0c5ada2e1a69d37e69c97c70aee03657:
  chfn, chsh: use readline(3) to receive user input (2017-04-23 18:52:58 +0100)
----------------------------------------------------------------

Sami Kerola (10):
  lsipc: fix options parsing and sync with man page
  blkid: add long options
  docs: raw devices are deprecated
  libblkid: add blkid_return_known_pttypes()
  partx: add --list-types option
  misc: clarify ternary operators with parentheses
  sulogin: reduce vulnerability surface
  logger: make month names, login name, and tag read-only objects
  findfs: use getopt_long() to parse options
  chfn, chsh: use readline(3) to receive user input

 bash-completion/blkid                |  70 ++++++++++++++-----
 bash-completion/partx                |   4 +-
 disk-utils/blockdev.c                |   2 +-
 disk-utils/partx.8                   |  18 ++---
 disk-utils/partx.c                   |  22 +++++-
 disk-utils/raw.8                     |   7 ++
 lib/loopdev.c                        |   4 +-
 lib/strutils.c                       |  30 ++++-----
 libblkid/docs/libblkid-sections.txt  |   1 +
 libblkid/src/blkid.h.in              |   1 +
 libblkid/src/libblkid.sym            |   1 +
 libblkid/src/partitions/partitions.c |  24 +++++++
 libfdisk/src/bsd.c                   |  10 +--
 libfdisk/src/label.c                 |   2 +-
 libfdisk/src/sun.c                   |   4 +-
 libmount/src/context.c               |  38 +++++------
 libmount/src/context_mount.c         |   2 +-
 libsmartcols/src/column.c            |  14 ++--
 libsmartcols/src/table_print.c       |   6 +-
 login-utils/Makemodule.am            |   2 +-
 login-utils/chfn.c                   |  22 +++---
 login-utils/chsh.c                   |   8 +--
 login-utils/su-common.c              |  53 ++++++++-------
 login-utils/sulogin-consoles.c       |  20 +++---
 login-utils/sulogin.c                |  39 +++++------
 misc-utils/blkid.8                   | 127 +++++++++++++++++------------------
 misc-utils/blkid.c                   |  83 ++++++++++++++---------
 misc-utils/findfs.c                  |  26 ++++---
 misc-utils/findmnt.c                 |   2 +-
 misc-utils/logger.c                  |  12 ++--
 misc-utils/whereis.c                 |   6 +-
 sys-utils/ipcs.c                     |   4 +-
 sys-utils/lsipc.1                    |   7 +-
 sys-utils/lsipc.c                    |   3 +-
 sys-utils/wdctl.c                    |   8 +--
 term-utils/script.c                  |  12 ++--
 36 files changed, 399 insertions(+), 295 deletions(-)

-- 
2.12.2

