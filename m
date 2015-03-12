Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55959 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbCLSI3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Mar 2015 14:08:29 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LfHs4-1ZKbdj2Lxg-00okDg for
 <util-linux@vger.kernel.org>; Thu, 12 Mar 2015 19:08:27 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/2] Fix test fdisk/bsd ppc64le
Date: Thu, 12 Mar 2015 19:08:24 +0100
Message-Id: <1426183706-30366-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

A minor thing, maybe for v2.26.1.

This is pull request 177 on github
https://github.com/karelzak/util-linux/pull/177

Ruediger Meier (2):
  tests: improve readability for fdisk/bsd
  tests: fix fdisk/bsd for ppc64le

 tests/ts/fdisk/bsd | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
1.8.4.5

