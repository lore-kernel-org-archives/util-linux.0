Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52732 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010AbbFPO1C (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Jun 2015 10:27:02 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MZTP3-1ZQ7jz2OnV-00LBx7 for
 <util-linux@vger.kernel.org>; Tue, 16 Jun 2015 16:26:58 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/2] 2 minor misc fixes
Date: Tue, 16 Jun 2015 16:26:55 +0200
Message-Id: <1434464817-8851-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is pull request 202 on github
https://github.com/karelzak/util-linux/pull/202

Ruediger Meier (2):
  procutils: reset errno before readdir
  tests: always kill helper

 lib/procutils.c         |  1 +
 tests/ts/kill/print_pid | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
1.8.4.5

