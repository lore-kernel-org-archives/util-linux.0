Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63461 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbbAZNjT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 08:39:19 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LgvEY-1XsHVj19J0-00oJwO for
 <util-linux@vger.kernel.org>; Mon, 26 Jan 2015 14:39:17 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/3] fix tests ppc
Date: Mon, 26 Jan 2015 14:39:13 +0100
Message-Id: <1422279556-8846-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is pull request #147 on github
https://github.com/karelzak/util-linux/pull/147

Ruediger Meier (3):
  Revert "tests: simplify and update swaplabel test"
  tests: fix swaplabel test for 9a83b03c
  tests: fix fdisk/bsd again for big endian

 tests/expected/misc/swaplabel | 4 ++--
 tests/ts/fdisk/bsd            | 2 +-
 tests/ts/misc/swaplabel       | 9 +++++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
1.8.4.5

