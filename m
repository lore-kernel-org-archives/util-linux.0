Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:49745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdGPRrK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 16 Jul 2017 13:47:10 -0400
Subject: [PATCH 0/4] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Date: Sun, 16 Jul 2017 13:46:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 8ffa3b651d7e74acba8f1d831b7f68fdb3c66aae:

  libfdisk: make fdisk compliant to UEFI/GPT specification on PMBR (2017-07-14 12:48:18 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170711

for you to fetch changes up to c26ddc568f3fb26b45a22cbf89d3294113e70377:

  hwclock: improve RTC epoch messages (2017-07-16 08:41:54 -0400)

----------------------------------------------------------------
J William Piggott (4):
      hwclock: --epoch presence test fails
      hwclock: remove dead ioctl check
      hwclock: improve RTC epoch messages
      hwclock: improve RTC epoch messages

 sys-utils/hwclock-rtc.c | 56 +++++++++++++++++++------------------------------
 sys-utils/hwclock.8.in  |  3 +++
 sys-utils/hwclock.c     | 24 +++++++--------------
 sys-utils/hwclock.h     |  2 +-
 4 files changed, 32 insertions(+), 53 deletions(-)

