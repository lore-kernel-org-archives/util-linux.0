Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:57645 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbaEYAQz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 24 May 2014 20:16:55 -0400
Received: from [192.168.2.101] ([79.192.161.140]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MOwbP-1Wu6k63Kit-006Rjg for
 <util-linux@vger.kernel.org>; Sun, 25 May 2014 02:16:53 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: BUG: umount --all-targets vs /etc/mtab
Date: Sun, 25 May 2014 02:16:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201405250216.47401.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

umount --all-targets does not work if /etc/mtab is a regular file and not a 
link to /proc/mounts.

reproduce:
$ sudo mv /etc/mtab  /etc/mtab.orig 
$ sudo cp /proc/mounts /etc/mtab
$ sudo make check TS_OPTS="--parallel=1 mount" 

Test mount/umount-alltargets fails.
 
cu,
Rudi
