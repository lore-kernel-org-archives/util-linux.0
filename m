Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f52.google.com ([209.85.215.52]:64015 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaJFQcv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Oct 2014 12:32:51 -0400
Received: by mail-la0-f52.google.com with SMTP id hz20so4648301lab.25
        for <util-linux@vger.kernel.org>; Mon, 06 Oct 2014 09:32:49 -0700 (PDT)
Received: from [192.168.7.32] (au213-1-82-235-205-153.fbx.proxad.net. [82.235.205.153])
        by mx.google.com with ESMTPSA id wj8sm5880123lbb.34.2014.10.06.09.32.48
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2014 09:32:49 -0700 (PDT)
Message-ID: <5432C4C8.30101@gmail.com>
Date: Mon, 06 Oct 2014 18:35:20 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: losetup: failed to setup loop device > 1
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I don't really understand what's going on, it seems that I can't setup a
loop device if loop0 is already in use.

If no loop is in use, everything works as expected:

# LOOPDEV_DEBUG=1 losetup -f disk.img
loopdev:  [0x7fffaf57c898]: find_unused requested
loopdev:  [0x7fffaf57c898]: loop0 successfully assigned
loopdev:  [0x7fffaf57c898]: find_unused by loop-control [rc=0]
loopdev:  [0x7fffaf57c898]: set backing file=/root/diskt.img
loopdev:  [0x7fffaf57c898]: device setup requested
loopdev:  [0x7fffaf57c898]: setup: backing file open: OK
loopdev:  [0x7fffaf57c898]: open ok
loopdev:  [0x7fffaf57c898]: setup: device open: OK
loopdev:  [0x7fffaf57c898]: setup: LOOP_SET_FD: OK
loopdev:  [0x7fffaf57c898]: setup: LOOP_SET_STATUS64: OK
loopdev:  [0x7fffaf57c898]: setup success [rc=0]
loopdev:  [0x7fffaf57c898]: de-initialize
loopdev:  [0x7fffaf57c898]: iter: de-initialize

However if loop0 is busy, it fails this way:

# LOOPDEV_DEBUG=1 losetup -f disk.img
loopdev:  [0x7fff15a8da98]: find_unused requested
loopdev:  [0x7fff15a8da98]: loop1 successfully assigned
loopdev:  [0x7fff15a8da98]: find_unused by loop-control [rc=0]
loopdev:  [0x7fff15a8da98]: set backing file=/root/disk.img
loopdev:  [0x7fff15a8da98]: device setup requested
loopdev:  [0x7fff15a8da98]: setup: backing file open: OK
loopdev:  [0x7fff15a8da98]: open failed
loopdev:  [0x7fff15a8da98]: setup failed [rc=-6]
losetup: failed to setup loop device: No such device or address
loopdev:  [0x7fff15a8da98]: de-initialize
loopdev:  [0x7fff15a8da98]: iter: de-initialize

The weird thing is that loop1 is succesfully found/allocated but it
failed during the open() of the device.

strace shows:
...
open("/dev/loop-control", O_RDWR)       = 0
ioctl(0, 0x4c82, 0x3)                   = 1
...
open("/dev/loop1", O_RDWR)              = -1 ENXIO (No such device or
address)
...

The loop min count for that system is 8 so it shouldn't be a problem to
setup 2 loop devices and the trace shows that requesting a new loop works.

One last details is that the system uses pretty old stuff: kernel
3.4.50, util-linux 2.21.1.

Could anybody give me some help ?

Thanks.
