Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57459 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbbLNMMC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Dec 2015 07:12:02 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MSMr9-1ZfcTL1jmV-00TVj2 for
 <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:12:00 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: sfdisk, re-eading partition table fails
Date: Mon, 14 Dec 2015 13:11:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201512141311.59328.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

our test suite shows that many sfdisk tests fail sometimes to "Re-read
partition table" at the end. I was able to find some systems where
I could re-produce the problem using the script below.

Seems that the problem is because of the first BLKRRPART ioctl call
in sfdisk.c function is_device_used(). Maybe it cause udev or
whatever to open the device and then the real BLKRRPART in
write_changes() fails.

Removing the first BLKRRPART ioctl (or sleeping about 50ms after the first one)
"fixes" the issue.

------ my test script -------------
#!/bin/bash
export LANG="C"
export LC_ALL="C"

export LD_LIBRARY_PATH=/home/rudi/devel/util-linux/build/.libs
SFDISK=/home/rudi/devel/util-linux/build/.libs/sfdisk
LOG=/tmp/sfdisk.log

modprobe -r scsi_debug || exit 1
modprobe -b scsi_debug dev_size_mb=100 sector_size=512 || exit 1
udevadm settle
sleep 2
DEVICE=/dev/$(grep --with-filename scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
echo device: $DEVICE

rm -f "$LOG"

# create a partition
echo ',+,L' | $SFDISK --label dos ${DEVICE} &> /dev/null
udevadm settle
sleep 2

echo "+10M,-10M" | strace -f -o /tmp/strace $SFDISK -N1 ${DEVICE} >> "$LOG" 2>&1
if grep -qi "failed" "$LOG"; then 
	echo "!! FAILED !!"
	exit 1
fi
exit 0
----------

cu,
Rudi
