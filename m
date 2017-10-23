Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/4] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
Date: Sun, 22 Oct 2017 20:37:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


This patch set address four bugs. Three are related to ISO 8601 formats
and the fourth is a tangentially related bug in hwclock. 

Patch 0002 increases the ISO 8601 buffer macro from 32 to 42 which should
work for the first three, and may be usable in the last four files:
  login-utils/last.c:1039	buffer size 32
  misc-utils/uuidparse.c:231	uses ISO_8601_BUFSIZ + 4
  login-utils/utmpdump.c:94	buffer size 40
  login-utils/lslogins.c:316	buffer size 64
  sys-utils/lsipc.c:1328	buffer size 64
  sys-utils/dmesg.c:887		buffer size 256
  term-utils/script.c:351	uses BUFSIZ (8K on my system)

I haven't tested it on them.

The the final patch adds some common ISO timestamp format masks.

The following changes since commit b41bac08abadbea9bac7a093c995ca53d86c76f1:

  build-sys: move rfkill to /usr/sbin (2017-10-20 14:59:16 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170925

for you to fetch changes up to a9f92c6d1f25f4111f1334bdb2dd96f8b4ccb9ba:

  lib/timeutils: add common ISO timestamp masks (2017-10-21 20:55:01 -0400)

----------------------------------------------------------------
J William Piggott (4):
      hwclock: add iso-8601 overflow check
      lib/timeutils: ISO_8601_BUFSIZ too small
      lib/timeutils: add get_gmtoff()
      lib/timeutils: add common ISO timestamp masks

 include/timeutils.h    | 23 ++++++++++++-----
 lib/timeutils.c        | 70 +++++++++++++++++++++++++++++++++++++++++++++++---
 login-utils/last.c     |  2 +-
 login-utils/lslogins.c |  3 +--
 login-utils/utmpdump.c |  4 +--
 misc-utils/uuidparse.c | 10 ++------
 sys-utils/dmesg.c      |  4 +--
 sys-utils/hwclock.c    | 23 +++++++----------
 sys-utils/lsipc.c      |  2 +-
 sys-utils/rfkill.c     |  8 ++----
 term-utils/script.c    |  8 ++----
 11 files changed, 103 insertions(+), 54 deletions(-)
