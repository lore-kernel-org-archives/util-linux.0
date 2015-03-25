Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54938 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbbCYJkN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Mar 2015 05:40:13 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MZxch-1YvPRE1nln-00LjPe for
 <util-linux@vger.kernel.org>; Wed, 25 Mar 2015 10:40:11 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/2] some fixes last(1)
Date: Wed, 25 Mar 2015 10:40:08 +0100
Message-Id: <1427276410-25271-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is pull request #184 on github
https://github.com/karelzak/util-linux/pull/184

Ruediger Meier (2):
  last: fix first (current) runlevel line
  last, fix race when comparing time stamps

 login-utils/last.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.4.5

