Return-Path: elseifthen@gmx.com
To: Karel Zak <kzak@redhat.com>
From: J William Piggott <elseifthen@gmx.com>
Subject: [V3 PULL] hwclock: remove date(1)
Cc: util-linux@vger.kernel.org
Message-ID: <a1415b5d-4046-3b34-5836-40ce1a835a41@gmx.com>
Date: Sat, 4 Mar 2017 16:56:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Everyone,
 Here's the latest branch for adding parse-date.

Karel,
I have changed a few things since the last working branch I sent you.  I
moved the API from parse-date.h to timeutils.h. Cleaned up the code some
more and made more style conversion. Added documentation and fixed
hwclock.8.in.

I've tested the parser pretty thoroughly now, including using odd input
listed in bug fixes. It passed for all of them.

Here are examples of the problem related to the latest gnulib
parse_datetime() commit; which was actually caused by changes in
coreutils not gnulib.

BROKEN
TZ="Europe/London" date -d 'TZ="Australia/Perth" 2016-08-15 07:00'
Mon Aug 15 07:00:00 AWST 2016

CORRECT
TZ="Europe/London" date -d 'TZ="Australia/Perth" 2016-08-15 07:00'
Mon Aug 15 00:00:00 BST 2016

HWCLOCK CORRECT
TZ="Europe/London" ./hwclock --predict --noadjfile --utc --date 'TZ="Australia/Perth" 2016-08-15 07:00'
2016-08-15 00:00:00.000000+0100

Not that anyone should ever get up to such a thing with hwclock anyway.

 ---

The following changes since commit 1765814521bf2aba7b8c03d3ab2e3b784e1ce2c4:

  libsmartcols: allow to add column to already used table (2017-03-03 10:37:37 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git hwclock-date7

for you to fetch changes up to b80d6d4be8371b6e8fa4a31a1fc1f7ce57a91be7:

  lib: add parse-date documentation (2017-03-04 15:03:44 -0500)

----------------------------------------------------------------
J William Piggott (3):
      lib: add parse-date.y
      hwclock: use parse_date function
      lib: add parse-date documentation

Karel Zak (1):
      build-sys: add parse-date.y

 .gitignore                   |    1 +
 Documentation/parse-date.txt |  468 ++++++++++++
 autogen.sh                   |   20 +
 configure.ac                 |    2 +-
 include/cctype.h             |  325 +++++++++
 include/timeutils.h          |    2 +
 lib/.gitignore               |    1 +
 lib/Makemodule.am            |    1 +
 lib/parse-date.y             | 1645 ++++++++++++++++++++++++++++++++++++++++++
 sys-utils/hwclock.8.in       |   22 +-
 sys-utils/hwclock.c          |  104 +--
 11 files changed, 2480 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/parse-date.txt
 create mode 100644 include/cctype.h
 create mode 100644 lib/.gitignore
 create mode 100644 lib/parse-date.y
