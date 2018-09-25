Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:40251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeIZErQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Sep 2018 00:47:16 -0400
Received: from adsiz.fritz.box ([95.90.40.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW9TR-1gGDZY4Bh3-00XPMs for
 <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 00:37:30 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/2] minor fixes for v2.33
Date: Wed, 26 Sep 2018 00:37:27 +0200
Message-Id: <20180925223729.28934-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Fix some minor issues seen on my travis -Werror build
on i386 and OSX.

Ruediger Meier (2):
  libfdisk: fix OSX compiler warning
  libfdisk: fix printf format modifier

 libfdisk/src/context.c | 8 +++++---
 libfdisk/src/script.c  | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.13.7
