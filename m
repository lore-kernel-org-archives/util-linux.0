Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49811 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbbCZNuh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Mar 2015 09:50:37 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lpxdr-1Z5npt3IYh-00fiei for
 <util-linux@vger.kernel.org>; Thu, 26 Mar 2015 14:50:34 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: question about logger tests
Date: Thu, 26 Mar 2015 14:50:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201503261450.33545.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Our logger tests fail if it can't connect to /dev/log. I'd like to fix 
that case for the test-suite but have some questions:

1. It was confusing for me to figure out the actual
   problem. Maybe --no-act and/or --stderr should imply
   that --socket-errors=auto turns error printing on?

2. Alternatively we could use --socket-errors=on for all tests.

3. Couldn't we fix --no-act to not need an open /dev/log at all?

cu,
Rudi
