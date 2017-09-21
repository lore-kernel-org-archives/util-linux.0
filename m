Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751697AbdIUUI5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 21 Sep 2017 16:08:57 -0400
Subject: [PATCH 0/2] pull request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a996a4b2-89f5-eb63-a0cb-499830bce2e6@gmx.com>
Date: Thu, 21 Sep 2017 16:08:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Karel, these include a minor bug fix and another change that yet again
affects hwclock's usage strings, so I thought you might want them for
the upcoming release.

If you'd rather wait until the next cycle, that is fine with me as well.

The following changes since commit 323e0668cd380b3353da03d5bd74887ab26f1ea3:

  po: fix ipcrm translation error fr.po (2017-09-20 12:14:42 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170915

for you to fetch changes up to f0a0ce744573bc3b3164062bc25e8fc6ddc7d9b9:

  hwclock: make debug implicit for test mode. (2017-09-21 14:53:43 -0400)

----------------------------------------------------------------
J William Piggott (2):
      hwclock: exit bug fix and single test mode message
      hwclock: make debug implicit for test mode.

 sys-utils/hwclock.8.in |  8 +++----
 sys-utils/hwclock.c    | 64 ++++++++++++++++++++------------------------------
 2 files changed, 29 insertions(+), 43 deletions(-)
