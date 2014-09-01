Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:41367 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbaIAPhZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Sep 2014 11:37:25 -0400
Received: by mail-wg0-f43.google.com with SMTP id a1so5577135wgh.14
        for <util-linux@vger.kernel.org>; Mon, 01 Sep 2014 08:37:23 -0700 (PDT)
Received: from [192.168.7.30] (au213-1-82-235-205-153.fbx.proxad.net. [82.235.205.153])
        by mx.google.com with ESMTPSA id pm6sm2843953wjb.36.2014.09.01.08.37.22
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Sep 2014 08:37:22 -0700 (PDT)
Message-ID: <54049344.4010502@gmail.com>
Date: Mon, 01 Sep 2014 17:39:48 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Weird behaviour with lsblk and freshly created loop device
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Right after associating a loop device with a disk image file, I'm using
lsblk to retrieve some info about the partitions.

If I'm doing this as root:

  $ losetup /dev/loop0 /tmp/installer-disks/disk0.img && lsblk -n --raw
--paths -o NAME,PARTTYPE /dev/loop0 && losetup -d /dev/loop0

then the output is missing the parttypes:

  /dev/loop0
  /dev/loop0p1
  /dev/loop0p2

However adding a sleep or 'udevadm settle' after setting the loop device
the parttypes are correctly showed:

   $ losetup /dev/loop0 /tmp/installer-disks/disk0.img && udevadm settle
&& lsblk -n --raw --paths -o NAME,PARTTYPE /dev/loop0 && losetup -d
/dev/loop0
  /dev/loop0
  /dev/loop0p1 0657fd6d-a4ab-43c4-84e5-0933c84b4f4f
  /dev/loop0p2 4f68bce3-e8cd-4db1-96e7-fbcaf984b709

Could anybody tell me if that's expected ?

Thanks.
