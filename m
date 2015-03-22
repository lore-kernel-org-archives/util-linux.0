Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37557 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbbCVXFd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Mar 2015 19:05:33 -0400
Received: by wixw10 with SMTP id w10so44945944wix.0
        for <util-linux@vger.kernel.org>; Sun, 22 Mar 2015 16:05:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/5] pull: one dmesg compiler warning fix and bunch of tests
Date: Sun, 22 Mar 2015 23:05:25 +0000
Message-Id: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I noticed a variable shadowing warning, that lead to paying again
attention to dmesg.  While recent logger lessons are still fresh in mind
the obvious thing to do with the dmesg was to add more tests, and that's
what this pull is about.

----------------------------------------------------------------
The following changes since commit bb3df8218b4f8f145e345ab59828a9b3d6d70c4b:
  tests: some more mount error handling (2015-03-19 17:12:15 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git test_dmesg
for you to fetch changes up to 29c7d18d92b393c0f87be09bdfee03c93a09e61b:
  tests: check dmesg message coloring (2015-03-22 22:56:27 +0000)
----------------------------------------------------------------

Sami Kerola (5):
  dmesg: fix shadow declaration
  tests: add dmesg multiline message check
  tests: add test_dmesg that has fixed boot time
  tests: check timestamp formats
  tests: check dmesg message coloring

 sys-utils/Makemodule.am          |   4 ++
 sys-utils/dmesg.c                |  16 +++---
 tests/commands.sh                |   2 +-
 tests/expected/dmesg/colors      | 105 +++++++++++++++++++++++++++++++++++++++
 tests/expected/dmesg/indentation |  35 +++++++++++++
 tests/ts/dmesg/colors            |  25 ++++++++++
 tests/ts/dmesg/console-levels    |   4 +-
 tests/ts/dmesg/decode            |   4 +-
 tests/ts/dmesg/delta             |   4 +-
 tests/ts/dmesg/facilities        |   4 +-
 tests/ts/dmesg/indentation       |  37 ++++++++++++++
 tests/ts/dmesg/newlines          |   5 ++
 12 files changed, 228 insertions(+), 17 deletions(-)
 create mode 100644 tests/expected/dmesg/colors
 create mode 100644 tests/expected/dmesg/indentation
 create mode 100755 tests/ts/dmesg/colors
 create mode 100755 tests/ts/dmesg/indentation
 create mode 100644 tests/ts/dmesg/newlines

-- 
2.3.3

