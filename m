Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:38772 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab3FBRvb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:51:31 -0400
Received: by mail-we0-f170.google.com with SMTP id w57so1057773wes.1
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:51:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/19] pull: various clean ups and couple bug fixes
Date: Sun,  2 Jun 2013 18:51:06 +0100
Message-Id: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This weeks patch series is bag of random clean ups, fixes, and features. 
The commits, and corresponding messages, are hopefully good enough so
that individual patches does not need much explaining.

If there is only one patch to get comments I hope it is the dmesg boot
time detection fix (0018).  Either that change is wrong, or there is not
a better way (at last at the moment) to determine system start time.


The following changes since commit 8225bb78a631d032121f9d7eed19481220933c88:

  libmount: more robust options string parsing (2013-05-30 13:29:34 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk21

for you to fetch changes up to fdcb3a36c4d9a6154473b393481bea8595a22104:

  cal: fix few type mismatches (2013-06-02 17:10:22 +0100)

----------------------------------------------------------------
Sami Kerola (19):
      lib: remove unused code
      lscpu: add max MHz value to make cpu governor effects more visible
      docs: add lscpu max mhz to manual and bash completion
      sfdisk: use libc error printing function, and symbolic exit values
      sfdisk: clean up usage() functions
      sfdisk: use program_invocation_short_name to determine program name
      docs: correct sfdisk --activate instructions
      sfdisk: remove --unhide and related functions
      sfdisk: replace my_warn() with warnx()
      rev: stop adding new line at the end when input does not have it
      rev: simplify new line detection and impossible test
      rev: reduce stream checking when closing read-only file descriptor
      dmesg: make time format parsing to use enum bit field
      dmesg: add --time-format option
      dmesg: add iso-8601 time format
      docs: add --time-format option and ISO-8601 format to manual
      dmesg: make usage() a little bit shorter
      dmesg: more deterministic boot time detection
      cal: fix few type mismatches

 bash-completion/lscpu   |   3 +-
 fdisks/sfdisk.8         |  33 +++-
 fdisks/sfdisk.c         | 406 ++++++++++++++++++------------------------------
 include/pathnames.h     |   3 +-
 lib/pager.c             |  10 --
 misc-utils/cal.c        |  12 +-
 sys-utils/dmesg.1       |  22 +++
 sys-utils/dmesg.c       | 148 ++++++++++++------
 sys-utils/lscpu.1       |   5 +
 sys-utils/lscpu.c       |  26 +++-
 tests/expected/misc/rev |   4 +-
 tests/ts/misc/rev       |   2 +
 text-utils/rev.c        |  17 +-
 13 files changed, 358 insertions(+), 333 deletions(-)


