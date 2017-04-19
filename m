Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/5] hwclock: epoch functions
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Date: Tue, 18 Apr 2017 22:55:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


This patch set centers on moving epoch functions to alpha only, see the
commit message for patch 0002 for an explanation. The rest are related
to making that change work correctly and bug fixes.

The following changes since commit d9f90f697c41a7040e5ff5e11a42c41adab173f6:

  tests: update script(1) tests (2017-04-18 12:42:58 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170415

for you to fetch changes up to 9bf13750cb55d747314a472c306e66b02a2abda9:

  optutils.h: don't print non-graph characters (2017-04-18 22:39:05 -0400)

----------------------------------------------------------------
J William Piggott (5):
      hwclock: improve default function handling
      hwclock: make epoch functions alpha only
      hwclock: --set and --predict segmentation fault
      hwclock: improve audit control
      optutils.h: don't print non-graph characters

 include/optutils.h  |  7 +++--
 sys-utils/hwclock.c | 88 +++++++++++++++++++++++------------------------------
 sys-utils/hwclock.h | 10 +++---
 3 files changed, 48 insertions(+), 57 deletions(-)
