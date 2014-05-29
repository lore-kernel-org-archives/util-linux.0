Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59135 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbaE2AxV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 May 2014 20:53:21 -0400
Received: from tenfore.ga-group.nl ([77.12.144.175]) by mail.gmx.com
 (mrgmx001) with ESMTPSA (Nemesis) id 0LoEwL-1WNNeo1KcT-00gDrm for
 <util-linux@vger.kernel.org>; Thu, 29 May 2014 02:53:19 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] setarch question, uname -m
Date: Thu, 29 May 2014 02:53:17 +0200
Message-Id: <1401324798-15059-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <201405270134.29753.sweet_f_a@gmx.de>
References: <201405270134.29753.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

I just send a patch proposal to let "setarch $(uname -m) ..." work
everywhere. Tested on several arm flavours. If this makes no sense
please tell me. Then I would fix our setarch test for non-hardcoded
archs.


Ruediger Meier (1):
  setarch, add generic support for setarch $(uname -m) ...

 sys-utils/setarch.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
1.8.4.5

