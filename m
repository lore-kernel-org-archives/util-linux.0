Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:57664 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752295AbdCaJA1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 05:00:27 -0400
Received: from [10.0.0.104] ([178.25.190.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7pI0-1byrxB0Wki-00vSVc for
 <util-linux@vger.kernel.org>; Fri, 31 Mar 2017 11:00:25 +0200
To: util-linux@vger.kernel.org
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Subject: find device of a known mountpoint
Message-ID: <5f3534af-06b5-9c76-f5e3-9c1d489e570c@gmx.de>
Date: Fri, 31 Mar 2017 11:00:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I wonder whether we have a command which tells me the device 
corresponding to a known mount point. I want to avoid grepping the 
output of mount because it may not unique (regarding mounts on shared 
bind mounts) and because the original mount point may include symlinks 
which are canonicalized by the kernel.

Example:

$ truncate -s100M /tmp/img
$ losetup /dev/loop0  /tmp/img
$ mkfs.ext2  /dev/loop0

$ mkdir /tmp/mnt
$ ln -s /tmp  /tmp/xyz/symlink

$ mount /dev/loop0 /tmp/xyz/symlink/mnt
$ mount | grep loop
/dev/loop0 on /tmp/mnt type ext2 ...


I need a command which outputs "/dev/loop0" when "/tmp/xyz/symlink/mnt" 
is given.

So far I found df as the only solution (but ugly and maybe GNU-only). 
And it would succeed for any input file, not only mountpoints.

$ df -P /tmp/xyz/symlink/mnt | awk 'NR==2{print $1}'
/dev/loop0

Our mountpoint(1) looks like the right tool but prints the device 
numbers only

$ mountpoint  -d /tmp/xyz/symlink/mnt
7:0

So how could I do this in a non-ugly way?

cu,
Rudi
