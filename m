Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18992 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab2KLNjo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Nov 2012 08:39:44 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qACDdi26024713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 12 Nov 2012 08:39:44 -0500
Date: Mon, 12 Nov 2012 14:39:41 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Ondrej Oprala <ooprala@redhat.com>
Subject: losetup --list
Message-ID: <20121112133941.GE26857@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 I have applied Ondrej's patch to support a new losetup output format.
 The output uses tt.c, so it's compatible with our others utils
 (lscpu, lsblk, prlimit, ...).

 Now losetup prints all loopdevs in the new format if no other option
 is specified.

   $ losetup
   NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE
   /dev/loop0         0      0         0  0 /home/fs-images/swap.img
   /dev/loop1         0    100         0  0 /home/fs-images/disk.img

   $ losetup -O +MAJ:MIN
   NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                 MAJ:MIN
   /dev/loop0         0      0         0  0 /home/fs-images/swap.img    7:0  
   /dev/loop1         0    100         0  0 /home/fs-images/disk.img    7:1 


 (we read all important information from /sys, so it's usable for
  non-root users too.)

 The change is backwardly compatible, -j or -a without --list returns
 the original format. The old format is marked as deprecated now.

 Thanks to Ondrej!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
