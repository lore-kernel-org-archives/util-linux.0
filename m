Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63926 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753837AbdFSLgR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 07:36:17 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MZ8fw-1d6UaJ005M-00Kz2O for <util-linux@vger.kernel.org>; Mon, 19 Jun 2017
 13:36:15 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/4] a few usage cleanups (--help, etc)
Date: Mon, 19 Jun 2017 13:36:10 +0200
Message-Id: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This patch-set corrects some minor issues for flock, agetty and gettopt.
If this is acceptable I would send similiar patches for the other
commands too.

You may also squash these commits to have less noise in the git history.

Ruediger Meier (4):
  toos: add checkusage.sh
  flock: cleaup --help
  getopt: cleanup --help
  agetty: cleanup --help

 Makefile.am         |   5 +++
 misc-utils/getopt.c |  48 ++++++++++++-------------
 sys-utils/flock.c   |  67 +++++++++++++++++-----------------
 term-utils/agetty.c | 102 ++++++++++++++++++++++++++--------------------------
 tools/checkusage.sh |  74 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+), 110 deletions(-)
 create mode 100755 tools/checkusage.sh

-- 
1.8.5.6

