Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:53629 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbaFAW4q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 1 Jun 2014 18:56:46 -0400
Received: from brln-4db817cb.pool.mediaways.net ([77.184.23.203]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MZCUG-1X7n5k1hm8-00KuQV
 for <util-linux@vger.kernel.org>; Mon, 02 Jun 2014 00:56:44 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: build-sys: minor issues
Date: Mon, 2 Jun 2014 00:56:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201406020056.17074.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I have two minor issues with our build-sys:

1. ./configure --enable-all-programs
also triggers --enable-deprecated-last. Would be nice to exclude this 
deprecated stuff somehow.

2. make dist
changes files in source dir, which makes the git clone dirty. Would be 
nice if we could avoid this somehow.

cu,
Rudi
