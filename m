Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62746 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdKLPWh (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 12 Nov 2017 10:22:37 -0500
Subject: [v2 PATCH 0/5] Pull Request and v2 changes
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Date: Sun, 12 Nov 2017 10:22:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


v2 Changes:
 * Apply Karel's changes for ISO_TIMESTAMP initializations
 * Fix last.c breakage caused by adding ISO timezone colon
 * New PATCH 5/5 to fix various tests broken by ISO timezone colon
 * Fix ISO format flags in timeutils.c main()

A little help please:
 * test lsipc and rfkill (changes to ISO timestamps), I couldn't test them.
 * check the new PATCH 5/5, as I'm not familiar with the tests system
   Note: the tests passed with and without the change in tests/ts/utmp/subsec

The following changes since commit 82524a1379c02bff0d061ffffae7398543218d33:

  nsenter: revert changes committed by accident (2017-11-10 14:02:51 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170925

for you to fetch changes up to 948e8d4349a7f83be1b6b3e94932eb4b8d6946d0:

  tests: adjust for ISO timezone colon use (2017-11-12 09:08:43 -0500)

----------------------------------------------------------------
J William Piggott (5):
      hwclock: add iso-8601 overflow check
      lib/timeutils: ISO_8601_BUFSIZ too small
      lib/timeutils: add get_gmtoff()
      lib/timeutils: add common ISO timestamp masks
      tests: adjust for ISO timezone colon use

 include/timeutils.h                     | 27 ++++++---
 lib/timeutils.c                         | 98 +++++++++++++++++++++++++++------
 login-utils/last.c                      |  6 +-
 login-utils/lslogins.c                  |  5 +-
 login-utils/utmpdump.c                  |  4 +-
 misc-utils/uuidparse.c                  | 12 +---
 sys-utils/dmesg.c                       |  4 +-
 sys-utils/hwclock.c                     | 25 ++++-----
 sys-utils/lsipc.c                       |  2 +-
 sys-utils/rfkill.c                      | 10 +---
 term-utils/script.c                     |  8 +--
 tests/expected/dmesg/indentation        | 10 ++--
 tests/expected/script/options-append    |  8 +--
 tests/expected/script/options-force     |  8 +--
 tests/expected/script/options-quiet     |  8 +--
 tests/expected/script/options-return    | 16 +++---
 tests/expected/utmp/last-nodns          | 30 +++++-----
 tests/expected/utmp/utmpdump-subsecond  |  6 +-
 tests/expected/utmp/utmpdump-totxt      | 20 +++----
 tests/expected/utmp/utmpdump-totxt-ipv6 |  4 +-
 tests/expected/uuid/uuidparse           |  2 +-
 tests/ts/utmp/subsec                    |  6 +-
 tests/ts/utmp/txt-a                     | 38 ++++++-------
 tests/ts/utmp/txt-b                     | 20 +++----
 tests/ts/utmp/txt-ipv6                  |  4 +-
 25 files changed, 214 insertions(+), 167 deletions(-)
