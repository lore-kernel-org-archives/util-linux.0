Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:54804 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaJCJmC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Oct 2014 05:42:02 -0400
Received: by mail-wg0-f47.google.com with SMTP id x13so1005900wgg.30
        for <util-linux@vger.kernel.org>; Fri, 03 Oct 2014 02:42:01 -0700 (PDT)
Received: from [192.168.7.32] (au213-1-82-235-205-153.fbx.proxad.net. [82.235.205.153])
        by mx.google.com with ESMTPSA id ny6sm1497607wic.22.2014.10.03.02.41.59
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2014 02:42:00 -0700 (PDT)
Message-ID: <542E7000.3040309@gmail.com>
Date: Fri, 03 Oct 2014 11:44:32 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: losetup on a image file containing (GPT) partition doesn't create
 partition devices
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I have a disk image file which is using GPT and embeds 2 partitions.

I'm setting up a loop device with:

 $ losetup -P -f disk.img

and expect the partition devices (loop0p[12] for example) to be
automatically created.

During the loop setup, udev reposrts:

 $ udevadm monitor
 KERNEL[88697.611649] change   /devices/virtual/block/loop0 (block)
 UDEV  [88697.612488] change   /devices/virtual/block/loop0 (block)
 KERNEL[88698.738369] change   /devices/virtual/block/loop0 (block)
 UDEV  [88698.744727] change   /devices/virtual/block/loop0 (block)

The loop kernel module was loaded with max_part=16

The weird thing is that if I'm setting up the loop device using a blank
image file and create the partitions (using gdisk) on this loop dev, it
works.

I'm not sure if this is an issue to util-linux though and if it's not,
sorry for the noise.

Thanks.
