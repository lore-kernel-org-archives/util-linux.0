Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38407 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdGaTzQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id y206so72000wmd.5
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/9] pull: various removals and few fixes
Date: Mon, 31 Jul 2017 20:54:59 +0100
Message-Id: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here's again rather random bunch of changes.  First I thought total lines
deleted would exceed lines added, but the agetty --compile-time addition
pushed the balance otherway around.  Oh well, that was a good try.

Perhaps the nicest change in this series is look(1) bash-completion update
that pushes tab completion to make the usability of the command on next
level.  Assuming you have system word lists installed this is pretty easy to
try, '.  bash-completion/look ; look zo<tab tab>' and you get list of
possibilities from Zoe to zorching.  The next level of look(1) improvements
should make optional [file] to be consumed from an environment variable, so
that bash-completion would play together with user preferred word list.  But
that's something for next time.

Rest of the changes I assume to be pretty straightforward to review, so
hopefully no need for lengthy text about them.

----------------------------------------------------------------
The following changes since commit 8df545592d73b67b0bf119732b52a5e4c0662ec4:
  build: use --runstatedir instead of --localstatedir (2017-07-31 15:24:46 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2017wk30
for you to fetch changes up to 7677b5b502afd0c9436ce684bc38a8339a64e916:
  agetty: fix invalid usage crash (2017-07-31 20:23:29 +0100)
----------------------------------------------------------------

Sami Kerola (9):
  chfn, chsh: merge auth.h, islocal.h and libuser.h to ch-common.h
  include: move pamfail.h to auth.c
  vipw: use explicit_bzero() to clear buffer after copy
  uuidparse: nil uuid have all bits set to zero
  libuuid: use access(2) when checking /dev/random availability
  bash-completion: look for look completions
  agetty: remove dead DO_DEVFS_FIDDLING code segment
  agetty: add --compile-time option
  agetty: fix invalid usage crash

 bash-completion/look          |  13 +-
 include/Makemodule.am         |   1 -
 include/pamfail.h             |  26 ----
 libuuid/src/gen_uuid.c        |   5 +-
 login-utils/Makemodule.am     |   7 +-
 login-utils/auth.c            |  21 ++-
 login-utils/auth.h            |  13 --
 login-utils/ch-common.h       |  17 +++
 login-utils/chfn.c            |   4 -
 login-utils/chsh.c            |   4 -
 login-utils/islocal.c         |   2 +-
 login-utils/islocal.h         |   1 -
 login-utils/libuser.c         |   3 +-
 login-utils/libuser.h         |  14 --
 login-utils/vipw.c            |   3 +
 misc-utils/uuidparse.c        |   5 +-
 term-utils/agetty.8           |   3 +
 term-utils/agetty.c           | 296 ++++++++++++++++++++++++++++++++++++------
 tests/expected/uuid/uuidparse |   6 +-
 19 files changed, 320 insertions(+), 124 deletions(-)
 delete mode 100644 include/pamfail.h
 delete mode 100644 login-utils/auth.h
 delete mode 100644 login-utils/islocal.h
 delete mode 100644 login-utils/libuser.h

-- 
2.13.3

