Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60509 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbbLIRnS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Dec 2015 12:43:18 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MKYpv-1a8eZv05vb-001zRu for
 <util-linux@vger.kernel.org>; Wed, 09 Dec 2015 18:43:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/5] blkdiscard: some output fixes
Date: Wed,  9 Dec 2015 18:43:09 +0100
Message-Id: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is pull request 239 on github
https://github.com/karelzak/util-linux/pull/239

Ruediger Meier (5):
  blkdiscard: fix timeval comparison inclusive usecs
  blkdiscard: fix stats reporting (off by one)
  blkdiscard: don't report "zero range" at the end
  tests: blkdiscard, check return values
  tests: skip BLKDISCARD if unsupported

 sys-utils/blkdiscard.c            | 13 ++++---
 tests/expected/blkdiscard/offsets | 31 ++++++++++++++++
 tests/ts/blkdiscard/offsets       | 78 +++++++++++++++++++++++----------------
 3 files changed, 84 insertions(+), 38 deletions(-)

-- 
1.8.4.5

