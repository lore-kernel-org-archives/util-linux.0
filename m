Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:61439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757094AbdLWBy4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 22 Dec 2017 20:54:56 -0500
Subject: [v2 PATCH 0/2] Pull Request
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <e2d14b08-f310-cf33-feb4-6e07b8b0f59b@gmx.com>
Date: Fri, 22 Dec 2017 20:54:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 v2 changelog
 * fix typo in v1
 * move REFORMATION_YEAR to the control struct
 * add more about the --1752-reform option to man page
 * add a second patch with minor style and wording changes

The following changes since commit 43afa84581de8984aa00ef2e9208198929f72ddf:

  lib/mbsalign: encode \x to \xecx (2017-12-20 13:01:43 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 171219

for you to fetch changes up to 5be40a1748e3f39ed976edfca3d45240e350cb8b:

  cal: change reformation to reform (2017-12-22 20:22:03 -0500)

----------------------------------------------------------------
J William Piggott (2):
      cal: add --iso and --1752-reform format options
      cal: change reformation to reform

 misc-utils/cal.1 |  25 ++++++++---
 misc-utils/cal.c | 134 ++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 100 insertions(+), 59 deletions(-)
