Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:41737 "EHLO Ishtar.hs"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753317Ab3DVWau (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Apr 2013 18:30:50 -0400
Received: from [192.168.4.12] (Athenae [192.168.4.12])
	by Ishtar.hs (8.14.5/8.14.4/SuSE Linux 0.8) with ESMTP id r3MMUjbX068719
	for <util-linux@vger.kernel.org>; Mon, 22 Apr 2013 15:30:48 -0700
Message-ID: <5175BA15.9060803@tlinx.org>
Date: Mon, 22 Apr 2013 15:30:45 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: mount --no-canonical seems broken.
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



I would use mount --no-canonical to rewrite mtab to match fstab so

my utils could find volumes in /etc/fstab -- but recently in
util-linux-2.21.2
this has no longer worked.

I made sure to have /etc/mtab NOT be a symlink to /proc/self/mounts so
mount could write to it.  It DOES write to it, but it doesn't display it.

Example:
After doing a remount as recommended by the manpage...

    mount -f --no-canonical -a -o remount

mount and df now produce different output.


Ishtar:home/../archive# echo $PWD
/home/.snapdir/@GMT-2013.04.16-05.07.03/archive

Ishtar:home/../archive# df .
Filesystem                         Size  Used Avail Use% Mounted on
/dev/HnS/Home-2013.04.16-05.07.03  1.0T  787G  238G  77%
/home/.snapdir/@GMT-2013.04.16-05.07.03

Ishtar:home/../archive# mount |grep /home/snapdir
Ishtar:home/../archive# mount |grep 04.16
/dev/mapper/HnS-Home--2013.04.16--05.07.03 on
/home/.snapdir/@GMT-2013.04.16-05.07.03 type xfs (ro,nouuid,norecovery)

I've tried up to version util-linux-2.23-rc2....


Ideas?









