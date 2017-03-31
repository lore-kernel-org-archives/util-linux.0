Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/6] remove alpha cmos
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Date: Fri, 31 Mar 2017 10:40:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


    Remove alpha direct I/O access, use RTC instead:
    http://marc.info/?l=util-linux-ng&m=141682406902804
    
    Resolves the alpha 2020 issue for util-linux:
    http://marc.info/?l=util-linux-ng&m=148387021519787
    
    Now it is only the kernel's RTC problem.

The following changes since commit eff2c9a42621b4cba81a81bc78f431b00e8a2968:

  tests: add --mountpoint to findmnt calls (2017-03-31 14:00:24 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git hwclock-date7-3

for you to fetch changes up to af68bd014ab4f0eef8ef34f69365905385fd3b21:

  hwclock: remove unused 'silent' arg (2017-03-31 10:04:53 -0400)

----------------------------------------------------------------
J William Piggott (6):
      hwclock: remove alpha cmos
      hwclock: remove unused cmos ctl structs
      hwclock: remove unused atomic arg in cmos
      hwclock: improve cmos message strings
      hwclock: remove dead cmos code
      hwclock: remove unused 'silent' arg

 sys-utils/hwclock-cmos.c | 417 +++++++++--------------------------------------
 sys-utils/hwclock-rtc.c  |  20 +--
 sys-utils/hwclock.8.in   | 110 ++++---------
 sys-utils/hwclock.c      |  34 +---
 sys-utils/hwclock.h      |  11 +-
 5 files changed, 120 insertions(+), 472 deletions(-)
