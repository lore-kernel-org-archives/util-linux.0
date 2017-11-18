Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:56877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763485AbdKRVTT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 18 Nov 2017 16:19:19 -0500
Subject: [PATCH 0/2] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <d91b971a-29f1-3403-342b-2b837c2abcb7@gmx.com>
Date: Sat, 18 Nov 2017 16:19:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The following changes since commit 75f03badd7ed9f1dd951863d75e756883d3acc55:

  bash-completion: (umount) use findmnt, escape a space in paths (2017-11-16 16:27:32 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 171017

for you to fetch changes up to af54dbd929266f6706a34050ed51e5114f520f59:

  hwclock: fix debug regression (2017-11-17 20:25:40 -0500)

----------------------------------------------------------------
J William Piggott (2):
      hwclock: use reentrant time conversion functions
      hwclock: fix debug regression

 sys-utils/hwclock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
