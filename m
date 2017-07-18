Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbdGRT7m (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jul 2017 15:59:42 -0400
Subject: [PATCH 0/2] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b8d24f10-1bea-aa80-0a28-9f573dd81d2a@gmx.com>
Date: Tue, 18 Jul 2017 15:59:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 78f9ecb990b994e272d9a69670b5c006e7f9fcdc:

  blkid: Add dm-integrity superblock signature (2017-07-18 14:43:21 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170717

for you to fetch changes up to 8c3a4703b173408d4f2e8dd8fcabf844b0cf0146:

  hwclock: fix regression from c3ae785 (2017-07-18 15:42:55 -0400)

----------------------------------------------------------------
J William Piggott (2):
      hwclock: remove unused epoch_option
      hwclock: fix regression from c3ae785

 sys-utils/hwclock.c | 7 ++++---
 sys-utils/hwclock.h | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)
