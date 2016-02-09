Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:49465 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755043AbcBIQj3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Feb 2016 11:39:29 -0500
Received: from www.gmx.com ([24.127.236.213]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lq9Ma-1Zphlf1aOu-00dkL1 for
 <util-linux@vger.kernel.org>; Tue, 09 Feb 2016 17:39:27 +0100
To: util-linux <util-linux@vger.kernel.org>
Subject: Configure fails on single builds
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <56BA1630.7090106@gmx.com>
Date: Tue, 9 Feb 2016 11:39:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


commit 15167589fb40be9479e1afe261bea0bf23b33a83 causing single
builds (other than chrt) to fail:

./configure --disable-all-programs --enable-hwclock

conditional \"HAVE_SCHED_SETATTR\" was never defined.
Usually this means the macro was only invoked conditionally.
