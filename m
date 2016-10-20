Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:55203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753846AbcJTN7T (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Oct 2016 09:59:19 -0400
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MTSrf-1cPVad0FHD-00SLaJ for
 <util-linux@vger.kernel.org>; Thu, 20 Oct 2016 15:59:16 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: bug v2.29-rc2, /etc/mtab file
Date: Thu, 20 Oct 2016 15:59:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201610201559.15231.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

On RHEL/CentOs-6 with /etc/mtab file some of our mount tests write something to
/etc/mtab. AFAIR it should be ignored nowadays by default, right?

After our test-suite was running I see these lines left in /etc/mtab:

tmpd /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/fstab-broken-mnt tmpfs rw 0 0
tmpd /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/fstab-broken-mnt tmpfs rw 0 0
none /home/abuild/rpmbuild/BUILD/util-linux-2.29-rc2/tests/output/mount/fstab-none-mnt tmpfs rw,nosuid,nodev,relatime 0 0


cu,
Rudi
