Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:60061 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaD0UFq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:05:46 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so5603400wes.15
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:05:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/12] pull: mostly swap command clarifications
Date: Sun, 27 Apr 2014 21:05:26 +0100
Message-Id: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and others,

Seeing the swaplabel bug fix went to stable release I decided to clarify
swap related commands what comes to version.  Other than that these
changes include fix to a last(1) regression that I caused with the
is_phantom() function, commit itself has more info what went wrong
previously.  The rest is pretty random stuff.


The following changes since commit c425353570b3f8b429790ff8bbb959348eead233:

  docs: update TODO (2014-04-23 15:28:09 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk16

for you to fetch changes up to 975da9cf6986fdcdb7207e24403322a265d76ed0:

  lib/pager: use names when referring to standard file descriptors (2014-04-26 18:30:06 +0100)

Sami Kerola (12):
  include/xalloc: ensure arithmetics overflow cannot happen
  dmesg: move get_boot_time() to lib/timeutils
  last: fix is_phantom() detection
  include/c.h: add macro to print definitions as string
  mkswap, swaplabel: move version number to header
  mkswap: remove legacy swap structure
  include/swapheader.h: ensure type sizes
  swapon: swaps with legacy version label are not supported
  swapon, swapheader, mkswap: move swap signature to header
  libsmartcols: remove ununsed assignment
  lib/timeutils: fix memory leak
  lib/pager: use names when referring to standard file descriptors

 disk-utils/mkfs.cramfs.c       |  2 +-
 disk-utils/mkswap.c            | 17 ++++-----
 disk-utils/swaplabel.c         |  4 +-
 include/c.h                    |  9 +++++
 include/swapheader.h           | 26 ++++++-------
 include/timeutils.h            |  1 +
 include/xalloc.h               | 85 +++++++++++++++++++++++++-----------------
 lib/pager.c                    | 18 ++++-----
 lib/timeutils.c                | 30 +++++++++++++++
 libsmartcols/src/table_print.c |  2 +-
 login-utils/last.c             | 15 ++++++--
 login-utils/login.c            |  2 +-
 misc-utils/blkid.c             |  2 +-
 misc-utils/findmnt.c           |  2 +-
 misc-utils/getopt.c            |  4 +-
 misc-utils/logger.c            |  2 +-
 sys-utils/dmesg.c              | 27 --------------
 sys-utils/swapon-common.c      |  4 +-
 sys-utils/swapon.c             | 16 +++-----
 text-utils/col.c               |  9 ++---
 text-utils/column.c            |  7 ++--
 text-utils/more.c              |  4 +-
 text-utils/rev.c               |  2 +-
 text-utils/ul.c                |  2 +-
 24 files changed, 156 insertions(+), 136 deletions(-)

-- 
1.9.2
