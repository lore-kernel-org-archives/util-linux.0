Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:59072 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141AbcGDNjm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Jul 2016 09:39:42 -0400
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0LxPNC-1bLm2S0LVa-0170C2 for
 <util-linux@vger.kernel.org>; Mon, 04 Jul 2016 15:39:38 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: question about raw(1)
Date: Mon, 4 Jul 2016 15:39:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201607041539.37149.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I'm just curious, would this always work?: 

  modprobe raw
  raw /dev/raw/raw1 /dev/xyz

or should you wait for /dev/raw/rawctl after modprobe (udevadm settle or 
sleep)?

cu,
Rudi
