Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62258 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbdGaXgb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jul 2017 19:36:31 -0400
Subject: [PATCH 0/5] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ccb78676-1284-5880-0ca9-ff15d2920de7@gmx.com>
Date: Mon, 31 Jul 2017 19:36:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 8df545592d73b67b0bf119732b52a5e4c0662ec4:

  build: use --runstatedir instead of --localstatedir (2017-07-31 15:24:46 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170722

for you to fetch changes up to b3e8105837505fc9b4637b4e41cca39eecb48ebf:

  hwclock: remove custom errno string (2017-07-31 16:10:47 -0400)

----------------------------------------------------------------
J William Piggott (5):
      hwclock: squash custom errno strings
      hwclock: squash custom errno strings
      hwclock: fix unimplemented ioctl test
      hwclock: remove custom errno string
      hwclock: remove custom errno string

 sys-utils/hwclock-cmos.c |  6 +-----
 sys-utils/hwclock-rtc.c  | 40 ++++++++++++++++------------------------
 sys-utils/hwclock.c      | 32 ++++++--------------------------
 sys-utils/hwclock.h      |  1 -
 4 files changed, 23 insertions(+), 56 deletions(-)
