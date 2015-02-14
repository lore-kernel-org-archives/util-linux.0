Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:55502 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241AbbBNSMe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 14 Feb 2015 13:12:34 -0500
Received: from tenfore.ga-group.nl ([77.12.225.240]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0Lhwt0-1XrELd3wWY-00n8M9 for
 <util-linux@vger.kernel.org>; Sat, 14 Feb 2015 19:12:32 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] fix warning, gcc 5.0
Date: Sat, 14 Feb 2015 19:12:29 +0100
Message-Id: <1423937550-2035-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

see also pull request on github
https://github.com/karelzak/util-linux/pull/151

Ruediger Meier (1):
  fsck: fix warning, gcc 5.0

 disk-utils/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.4.5

