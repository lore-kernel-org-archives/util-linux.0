Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/2] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
Date: Sun, 24 Dec 2017 15:36:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 43afa84581de8984aa00ef2e9208198929f72ddf:

  lib/mbsalign: encode \x to \xecx (2017-12-20 13:01:43 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 171213

for you to fetch changes up to e3fac9e420c55ae804199da6be2eb08ba9788795:

  hwclock: add --ul-debug implementing debug.h (2017-12-24 14:19:26 -0500)

----------------------------------------------------------------
J William Piggott (2):
      hwclock: rename --debug option to --verbose
      hwclock: add --ul-debug implementing debug.h

 Documentation/deprecated.txt |  12 +++++
 sys-utils/hwclock-rtc.c      |  10 ++---
 sys-utils/hwclock.8.in       |  15 ++++---
 sys-utils/hwclock.c          | 105 ++++++++++++++++++++++++-------------------
 sys-utils/hwclock.h          |  14 ++++--
 5 files changed, 96 insertions(+), 60 deletions(-)
