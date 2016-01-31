Return-Path: util-linux-owner@vger.kernel.org
Received: from static-50-37-226-42.drr01.cral.id.frontiernet.net ([50.37.226.42]:45995
	"EHLO mail.z2zcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932679AbcAaEZC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 30 Jan 2016 23:25:02 -0500
Received: from [192.168.1.4] (hades.aexorsyst.com [192.168.1.4])
	by mail.z2zcorp.com (8.14.4/8.14.4) with ESMTP id u0V3UDLZ024129
	for <util-linux@vger.kernel.org>; Sat, 30 Jan 2016 19:30:14 -0800
Message-ID: <56AD7FC5.3080902@z2zcorp.com>
Date: Sat, 30 Jan 2016 19:30:13 -0800
From: Zoltan <zoltan@z2zcorp.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: util-linux-2.27.1 - umount -a -O _netdev problem, _netdev ignored
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

There is a problem in the code of util-linux-2.27.1, in the umount binary.

The command

umount -a -O _netdev

does _not_ umount anything, despite an /etc/fstab with the likes of

...
alpha:/var/mail       /var/mail      nfs _netdev,soft,tcp
...

The "mount -a -O _netdev" command works as expected.  However, the
/run/mount/utab files is empty, and I was unable to get the "umount -a -O
_netdev" to work as advertised.  Running it with "--verbose" flag merely
confirmed that everything was being ": ignored".

I have a physical /etc/mtab (not symlink), and the "_netdev" option is missing
from /etc/mtab file, but that's probably expected???

If I manually add it (_netdev) to /etc/mtab, then the umount -a -O _netdev
does work.  But /run/mount/utab is empty.  Trying to step through the code
gets pretty brutal, and the *fs population is still hidden inside some
macro...and I can never find where the /run/mount/utab is even being parsed in
the umount code-path.

This is with a root-over-NFS setup, in case that matters.  Probably shouldn't.
 Kernel is 4.3.0.

Is this  a regression?  Seems there were issues before...wondering if it
re-surfaced.

-- 
     ###  Any similarity between my views and the truth is completely ###
     ###     coincidental, except that they are endorsed by NO ONE    ###
