Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63478 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbdLJPrF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 10 Dec 2017 10:47:05 -0500
Subject: [PATCH 0/4] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Date: Sun, 10 Dec 2017 10:47:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 44d753407d6b751f022ef234c85785ccd99c5590:

  tests: unlocks on failed ts_scsi_debug_init (2017-12-07 15:08:29 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 171121

for you to fetch changes up to 6cdc7b9c02b251120eb014c4dbc2387d47e7fb46:

  lib/timeutils.c: warn format_iso_time() overflow (2017-12-09 18:43:29 -0500)

----------------------------------------------------------------
J William Piggott (4):
      lib/timeutils.c: bug fix Segmentation fault
      lib/timeutils.c:strxxx_iso: test conversion errors
      lib/timeutils.c:strxxx_iso: do not wrap tm_year
      lib/timeutils.c: warn format_iso_time() overflow

 lib/timeutils.c     | 46 +++++++++++++++++++++++++++++++---------------
 sys-utils/hwclock.c |  5 ++---
 2 files changed, 33 insertions(+), 18 deletions(-)
