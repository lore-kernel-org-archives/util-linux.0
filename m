Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:58419 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbbCMPJk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Mar 2015 11:09:40 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Ldcv0-1ZDiNc2d4U-00inWv for
 <util-linux@vger.kernel.org>; Fri, 13 Mar 2015 16:09:38 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/2] tailf is deprecated
Date: Fri, 13 Mar 2015 16:09:35 +0100
Message-Id: <1426259377-15288-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is pull request 178 on github
https://github.com/karelzak/util-linux/pull/178

Ruediger Meier (2):
  tailf: deprecated
  tests: disarm tailf test

 Documentation/deprecated.txt |  5 +++++
 tests/expected/tailf/simple  |  1 +
 tests/ts/tailf/simple        |  4 ++++
 text-utils/tailf.1           |  6 ++++++
 text-utils/tailf.c           | 16 ++++++++++++----
 5 files changed, 28 insertions(+), 4 deletions(-)

-- 
1.8.4.5

