Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/6] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Date: Fri, 18 Aug 2017 20:16:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 6047c6db9c261c8048c54279ba1206ad0ca5d61e:

  lslogins: be more explicit with -g in man page (2017-08-18 10:29:54 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170803

for you to fetch changes up to 6524846ce501f7cfb9cc9a5ba369f37ef47d5ea2:

  hwclock: for debugging print startup system time (2017-08-18 16:07:28 -0400)

----------------------------------------------------------------
J William Piggott (6):
      hwclock: move systz into hctosys
      hwclock: remove set_system_clock_timezone()
      hwclock: update set_system_clock debugging
      hwclock: update set_system_clock comments
      hwclock: rename/refactor set_system_clock()
      hwclock: for debugging print startup system time

 sys-utils/hwclock.c | 187 ++++++++++++++++++----------------------------------
 1 file changed, 63 insertions(+), 124 deletions(-)
