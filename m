Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:54244 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508AbbDAME3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Apr 2015 08:04:29 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LobGI-1Z5A5G0db8-00gWjW for
 <util-linux@vger.kernel.org>; Wed, 01 Apr 2015 14:04:28 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: about test mount/rlimit
Date: Wed, 1 Apr 2015 14:04:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201504011404.27321.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Some questions regarding test mount/rlimit which runs only if /etc/mtab 
is a file.

This is the umount subtest:

.......
ts_init_subtest "umount"
[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
$TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT &> /dev/null
OLD_SUM=$(mtab_checksum)
(
        ulimit -f 1
        $TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
) &> /dev/null
NEW_SUM=$(mtab_checksum)
$TS_CMD_UMOUNT $TS_MOUNTPOINT &> /dev/null
[ $NEW_SUM = $OLD_SUM ] && echo "OK: mtab unmodified by umount" >> 
$TS_OUTPUT
ts_finalize_subtest
...........

I do not fully understand what is expected. Obviously the first "umount" 
should NOT modify /etc/mtab. But should it umount or not, or doesn't 
matter? Why we call a second umount then?

The problem is that in case that the first umount works we are leaving 
the test with a broken mtab file. This is not nice and also problematic 
because later tests may find a mounted /dev/loop0 in /etc/mtab.

Should we restore the original mtab? I guess it's a bit unsafe to copy 
back a backed up one. Or is there a way to "repair/sync" 
from /proc/mounts.?

cu,
Rudi
