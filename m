Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34663 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbcEORbC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so13474446wmn.1
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/11] pull: add timestamp printing to libcommon
Date: Sun, 15 May 2016 18:30:46 +0100
Message-Id: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This is reponse to earlier thread 'hwclock --show format':

http://www.spinics.net/lists/util-linux-ng/index.html#12326

At the time when hwclock discussion happen release of v2.28 was about to
happen, and major changes were not welcome - so the timestamp stuff was
added to TODO that this pull request attempts to sort out.

The hwclock(8) and logger(1) are left alone in this pull.  They are rather
special.  Most of the changes should be reasonable, and hopefully easy to
review.  Placed at the very end of the changes there are updates to
utmpdump(1) that are a little bit more intrusive than the other changes by
what I mean the utmpdump text output format will change.

As usual feedback and comments are welcome from all.

----------------------------------------------------------------
The following changes since commit 40c9c3a6b7e6c4cda627d76edb14e92e823451c3:
  libfdisk: add API for work with labelitems (2016-05-12 14:37:29 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git timestamp
for you to fetch changes up to bdd2dd1730c7bd83d0eb3ed29247d04731be312e:
  tests: utmpdump add subsecond accuracy test (2016-05-15 11:00:28 +0100)
----------------------------------------------------------------

Sami Kerola (11):
  lib: add timestamp helpers to libcommon.la
  last: use timestamp helpers
  lslogins: use timestamp helpers
  lsipc: use timestamp helpers
  dmesg: use timestamp helpers
  docs: remove timestamp TODO item
  utmpdump: use always UTC-0 timezone in textual output
  utmpdump: use iso-8601 timestamp format with subsecond accuracy
  tests: fix utmpdump timestamps to be in iso format
  tests: remove utmpdump localization go-arounds
  tests: utmpdump add subsecond accuracy test

 Documentation/TODO                      |   2 -
 include/Makemodule.am                   |   1 +
 include/timestamps.h                    |  20 +++++
 lib/Makemodule.am                       |   1 +
 lib/timestamps.c                        | 125 ++++++++++++++++++++++++++++++++
 login-utils/Makemodule.am               |   1 +
 login-utils/last.c                      |  42 +++++------
 login-utils/lslogins.c                  |  43 +++--------
 login-utils/utmpdump.c                  |  61 ++++++++++------
 sys-utils/dmesg.c                       |  62 +++++-----------
 sys-utils/lsipc.c                       |  39 +++-------
 tests/expected/utmp/utmpdump-subsecond  |   5 ++
 tests/expected/utmp/utmpdump-totxt      |  20 ++---
 tests/expected/utmp/utmpdump-totxt-ipv6 |   4 +-
 tests/ts/utmp/subsec                    |   3 +
 tests/ts/utmp/txt-a                     |  38 +++++-----
 tests/ts/utmp/txt-a-old                 |  19 +++++
 tests/ts/utmp/txt-b                     |  20 ++---
 tests/ts/utmp/txt-b-old                 |  10 +++
 tests/ts/utmp/txt-ipv6                  |   4 +-
 tests/ts/utmp/txt-ipv6-old              |   2 +
 tests/ts/utmp/utmpdump-circle           |  10 ++-
 tests/ts/utmp/utmpdump-subsecond        |  34 +++++++++
 tests/ts/utmp/utmpdump-tobin            |   2 -
 tests/ts/utmp/utmpdump-tobin-ipv6       |   2 -
 tests/ts/utmp/utmpdump-totxt            |   2 -
 tests/ts/utmp/utmpdump-totxt-ipv6       |   2 -
 27 files changed, 371 insertions(+), 203 deletions(-)
 create mode 100644 include/timestamps.h
 create mode 100644 lib/timestamps.c
 create mode 100644 tests/expected/utmp/utmpdump-subsecond
 create mode 100644 tests/ts/utmp/subsec
 create mode 100644 tests/ts/utmp/txt-a-old
 create mode 100644 tests/ts/utmp/txt-b-old
 create mode 100644 tests/ts/utmp/txt-ipv6-old
 create mode 100755 tests/ts/utmp/utmpdump-subsecond

-- 
2.8.2

