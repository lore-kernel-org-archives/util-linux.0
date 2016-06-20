Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35017 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbcFTUlH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 Jun 2016 16:41:07 -0400
Received: by mail-lf0-f53.google.com with SMTP id l188so46268043lfe.2
        for <util-linux@vger.kernel.org>; Mon, 20 Jun 2016 13:40:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/6] pull: utmpdump iso-8601 format
Date: Mon, 20 Jun 2016 21:40:31 +0100
Message-Id: <20160620204037.3292-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello.

This pull request is re-implementation of iso-8601 timestamp format in
textual output using timeutils Karel made available as libcommon timeutils
functions.  The earlier submission was based on my version of timeutils,
that were not merged.

----------------------------------------------------------------
The following changes since commit 7f787ced5d401ccd56a82bb2b1202f1ea7164783:
  libblkid: don't check nonnull attributes for NULL [-Wnonnull-compare] (2016-06-14 14:39:16 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git utmpdump
for you to fetch changes up to 9997c0b13fffe7d198e7d056e4279727c2b0b3ad:
  tests: utmpdump add subsecond accuracy test (2016-06-20 21:31:18 +0100)
----------------------------------------------------------------

Sami Kerola (6):
  utmpdump: use always UTC-0 timezone in textual output
  libcommon: add ISO_8601_GMTIME that will print UTC-0 timestamps
  utmpdump: use iso-8601 timestamp format with subsecond accuracy
  tests: fix utmpdump timestamps to be in iso format
  tests: remove utmpdump localization go-around
  tests: utmpdump add subsecond accuracy test

 include/timeutils.h                     |  3 +-
 lib/timeutils.c                         | 14 ++++++--
 login-utils/Makemodule.am               |  1 +
 login-utils/utmpdump.c                  | 63 +++++++++++++++++++--------------
 tests/expected/utmp/utmpdump-subsecond  |  5 +++
 tests/expected/utmp/utmpdump-totxt      | 20 +++++------
 tests/expected/utmp/utmpdump-totxt-ipv6 |  4 +--
 tests/ts/utmp/subsec                    |  3 ++
 tests/ts/utmp/txt-a                     | 38 ++++++++++----------
 tests/ts/utmp/txt-a-old                 | 19 ++++++++++
 tests/ts/utmp/txt-b                     | 20 +++++------
 tests/ts/utmp/txt-b-old                 | 10 ++++++
 tests/ts/utmp/txt-ipv6                  |  4 +--
 tests/ts/utmp/txt-ipv6-old              |  2 ++
 tests/ts/utmp/utmpdump-circle           | 10 ++++--
 tests/ts/utmp/utmpdump-subsecond        | 34 ++++++++++++++++++
 tests/ts/utmp/utmpdump-tobin            |  2 --
 tests/ts/utmp/utmpdump-tobin-ipv6       |  2 --
 tests/ts/utmp/utmpdump-totxt            |  2 --
 tests/ts/utmp/utmpdump-totxt-ipv6       |  2 --
 20 files changed, 175 insertions(+), 83 deletions(-)
 create mode 100644 tests/expected/utmp/utmpdump-subsecond
 create mode 100644 tests/ts/utmp/subsec
 create mode 100644 tests/ts/utmp/txt-a-old
 create mode 100644 tests/ts/utmp/txt-b-old
 create mode 100644 tests/ts/utmp/txt-ipv6-old
 create mode 100755 tests/ts/utmp/utmpdump-subsecond

-- 
2.9.0

