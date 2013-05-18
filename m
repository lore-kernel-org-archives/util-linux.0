Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:45242 "EHLO Ishtar.hs"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753460Ab3ERXCI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 18 May 2013 19:02:08 -0400
Message-ID: <5198086A.1010903@tlinx.org>
Date: Sat, 18 May 2013 16:02:02 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org, LKML <linux-lkml@vger.kernel.org>
Subject: new mount is broken w/regard to devnames in /etc/fstab
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



There are 2 problems -- they are unlikely to be
directly related, but are in so much as they are in the new version
of mount.

1) How is one supposed to get the real root device?
It's not /dev/root -- and on my system /dev/root doesn't even exist.
(though to be fair, it has in the past -- udev musta got sloppy this time,
and did point to the real root device).  But how can I get /proc to display
the real root device instead of some fake name.   

It's insecure the way it is -- as /dev/root could be "anything"...

2) I'd like lvm's naming to be available through mount.  Ideally, lvm's
naming would be available in /proc/mounts...  At least, though
in going from /dev/VG/LV => /dev/mapper/VG-LV, that can be
scripted reliably to get the mount device name. 

But /dev/root?... How to script that, *reliably*...
And why the bogus name?


