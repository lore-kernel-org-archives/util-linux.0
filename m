Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36156 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdCEUwi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:38 -0500
Received: by mail-wr0-f175.google.com with SMTP id u108so104169967wrb.3
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:37 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/13] pull: warnings fixes and blkid translations
Date: Sun,  5 Mar 2017 20:52:19 +0000
Message-Id: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Following few changes are various small fixes.  Many of the changes are
about warnings, and not that interesting.  Perhaps the most unexpected
change is blkid translations.  I don't know how that command has slipped
through so long time without being part of translations.  Oh well, now that
is fixed.


----------------------------------------------------------------
The following changes since commit 1765814521bf2aba7b8c03d3ab2e3b784e1ce2c4:
  libsmartcols: allow to add column to already used table (2017-03-03 10:37:37 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2017wk09
for you to fetch changes up to b8711cb7f2e0f739a491b6a95e7fb8dc537d977f:
  lib/colors: assert rathen than overflow (2017-03-05 20:41:41 +0000)
----------------------------------------------------------------

Sami Kerola (13):
  misc: stop mixing declarations and code
  libmount: fix use of preprocessor identifier
  libblkid: avoid overflow when initializing array
  libblkid: ensure uninitialized variable is not used [clang]
  blkid: add curly braces to do-while statement
  blkid: add messages to translations
  blkid: define output names only once
  blkid: improve coding style
  include: fix compiler warning
  libfdisk: dos: fix potential null pointer dereferences
  libfdisk: fix potentially null
  docs: improve boilerplate.c options example
  lib/colors: assert rathen than overflow

 Documentation/boilerplate.c           |  13 +-
 disk-utils/cfdisk.c                   |   4 +-
 disk-utils/sfdisk.c                   |   2 +-
 include/optutils.h                    |   3 +
 include/pt-mbr.h                      |   3 +
 lib/colors.c                          |   4 +-
 libblkid/src/superblocks/drbdmanage.c |   2 +-
 libblkid/src/superblocks/minix.c      |  22 +--
 libfdisk/src/dos.c                    |  61 +++++++-
 libfdisk/src/partition.c              |   4 +
 libmount/src/context_mount.c          |   2 +-
 misc-utils/blkid.c                    | 269 ++++++++++++++++++----------------
 text-utils/hexdump-display.c          |   4 +-
 13 files changed, 241 insertions(+), 152 deletions(-)

-- 
2.12.0

