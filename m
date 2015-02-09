Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62230 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759789AbbBIPLF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Feb 2015 10:11:05 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MVZuV-1Y7Kgq2Lc7-00Z33z for
 <util-linux@vger.kernel.org>; Mon, 09 Feb 2015 16:11:03 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/2] some ppc fixes for 2.26-rc2
Date: Mon,  9 Feb 2015 16:11:00 +0100
Message-Id: <1423494662-2658-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Ruediger Meier (2):
  cal: use int64_t instead of long
  setarch: fix typo (missing braces) for ppcle

 misc-utils/cal.c    | 3 ++-
 sys-utils/setarch.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.8.4.5

