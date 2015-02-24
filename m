Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56076 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbbBXPdT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 10:33:19 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Lbi2Z-1XgnVm2Sol-00lAgm for
 <util-linux@vger.kernel.org>; Tue, 24 Feb 2015 16:33:17 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] build fix
Date: Tue, 24 Feb 2015 16:33:14 +0100
Message-Id: <1424791995-690-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is pull request #154 on github
https://github.com/karelzak/util-linux/pull/154

Ruediger Meier (1):
  logger: link libsystemd-daemon.so

 misc-utils/Makemodule.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.4.5

