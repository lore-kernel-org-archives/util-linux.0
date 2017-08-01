Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50186 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751368AbdHANK3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 09:10:29 -0400
Subject: [PATCH 0/8] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Date: Tue, 1 Aug 2017 09:10:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The focus of this  patch set is fixing RTC read logic, which is PATCH 4/8.

The following changes since commit 55b3fe7824c261b6b3d2a8869a8cb509fdd2569f:

  setpriv: document accepted formats for naming caps (2017-08-01 11:52:31 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170724

for you to fetch changes up to fd1fbfc789541957088734df4a30af7b30d36763:

  hwclock: remove busywait tristate return status (2017-08-01 08:41:43 -0400)

----------------------------------------------------------------
J William Piggott (8):
      hwclock: move systz above init clocks read
      hwclock: move rtc permissions test
      hwclock: move drift correction and --predict
      hwclock: fix RTC read logic
      hwclock: correlate hclocktime instead of set_time.
      hwclock: update man page
      hwclock: restore select() timeout warning
      hwclock: remove busywait tristate return status

 sys-utils/hwclock-rtc.c |  16 +++----
 sys-utils/hwclock.8.in  |  26 ++++++++---
 sys-utils/hwclock.c     | 118 ++++++++++++++++++++++++------------------------
 sys-utils/hwclock.h     |   6 ---
 4 files changed, 87 insertions(+), 79 deletions(-)
