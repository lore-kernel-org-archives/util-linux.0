Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/3] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
Date: Tue, 29 Aug 2017 12:30:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


The following changes since commit e406be01b450dd7ed5e694bc15a39719d6f86967:

  hwclock: for debugging print startup system time (2017-08-24 18:49:11 -0400)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170825

for you to fetch changes up to 0396d0c2bc33a34d132b0d4f9f5f055668732989:

  hwclock: close hwaudit_fd unconditionally (2017-08-28 21:19:55 -0400)

----------------------------------------------------------------
J William Piggott (3):
      hwclock: remove sysexits.h
      hwclock: remove audit from control struct
      hwclock: close hwaudit_fd unconditionally

 sys-utils/hwclock-rtc.c |   5 +--
 sys-utils/hwclock.8.in  |   8 ++++
 sys-utils/hwclock.c     | 104 +++++++++++++++++++-----------------------------
 sys-utils/hwclock.h     |   3 +-
 4 files changed, 52 insertions(+), 68 deletions(-)
