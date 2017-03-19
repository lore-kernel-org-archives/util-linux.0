Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35116 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdCSKSI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Mar 2017 06:18:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id u108so14527457wrb.2
        for <util-linux@vger.kernel.org>; Sun, 19 Mar 2017 03:18:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/5] pull: tests fixes and couple blkid changes
Date: Sun, 19 Mar 2017 10:10:40 +0000
Message-Id: <20170319101045.3018-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Fixes to tests are similar what is done to other code to get rid of various
warnings.  It is safe to say these will not be the last warning fixes ever,
as static analyers will get better in catching new problems, and without
doubt sometimes regressions creep in or completely new code is introduced.

Second subject matter is the last blkid changes I want to propose (for now),
both making the code more similar with rest of the code in this project.

----------------------------------------------------------------
The following changes since commit 999448d86609cef27a481c6e0ed9006b27f19558:
  tests: refresh lscpu tests (2017-03-15 11:49:22 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2017wk11
for you to fetch changes up to 59b94cc0c5125ecb29f32235a168989a5c2b2f82:
  blkid: add control struct (2017-03-17 21:22:26 +0000)
----------------------------------------------------------------

Sami Kerola (5):
  libsmartcols: fix test variable shadowing
  tests: do not use plain 0 as NULL [smatch scan]
  tests: add static keyword where needed [smatch scan]
  blkid: simplify version option handling
  blkid: add control struct

 lib/colors.c                    |  10 +--
 lib/cpuset.c                    |   8 +-
 libfdisk/samples/mkpart.c       |   8 +-
 libmount/src/context.c          |   2 +-
 libmount/src/lock.c             |   2 +-
 libsmartcols/samples/fromfile.c |  34 ++++----
 libsmartcols/samples/title.c    |   6 +-
 libsmartcols/samples/tree.c     |  20 ++---
 misc-utils/blkid.c              | 181 ++++++++++++++++++++--------------------
 misc-utils/test_uuidd.c         |  10 +--
 tests/helpers/test_byteswap.c   |   6 +-
 tests/helpers/test_pathnames.c  |   2 +-
 12 files changed, 144 insertions(+), 145 deletions(-)

-- 
2.12.0

