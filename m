Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:65518 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbcCRLtX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Mar 2016 07:49:23 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LhOSG-1a38Jk0FhA-00mbHA for
 <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 12:49:20 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/2] ipcs: more robust and compatible /proc parsing
Date: Fri, 18 Mar 2016 12:49:16 +0100
Message-Id: <1458301758-21853-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

If this looks ok for shm then we could also add similar patches for
sem and msg.

Ruediger Meier (2):
  ipcs: make sure to parse whole lines for shm_data
  ipcs: --shmems, upward/backward compatibility

 sys-utils/ipcutils.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
1.8.4.5

