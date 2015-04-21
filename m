Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:63554 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbDUKeb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Apr 2015 06:34:31 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LaooK-1ZDDTw3Y9A-00kLGe for
 <util-linux@vger.kernel.org>; Tue, 21 Apr 2015 12:34:28 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: sfdisk, latest fixes break ppc64
Date: Tue, 21 Apr 2015 12:34:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201504211234.27649.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

the latest sfdisk fixes 2928068a..a53e37f9 seem to break ppc64

test sfdisk/gpt:
[  431s]                 : read-dump                   .../home/abuild/rpmbuild/BUILD/util-linux-2.26.git227.2cb28/tests/ts/sfdisk/gpt: line 96: 15657 Aborted                 
$TS_CMD_SFDISK --list -o START,END,SIZE,UUID,TYPE,NAME ${TS_DEVICE} >> $TS_OUTPUT 2>&1
[  431s]                 : write-dump                  ... FAILED (sfdisk/gpt-write-dump)
....
[  438s] --- /home/abuild/rpmbuild/BUILD/util-linux-2.26.git227.2cb28/tests/expected/sfdisk/gpt-read-dump       2015-04-21 09:37:08.855755828 +0000
[  438s] +++ /home/abuild/rpmbuild/BUILD/util-linux-2.26.git227.2cb28/tests/output/sfdisk/gpt-read-dump 2015-04-21 10:02:53.610000012 +0000
[  438s] @@ -25,15 +25,4 @@
[  438s]  The partition table has been altered.
[  438s]  Calling ioctl() to re-read partition table.
[  438s]  Syncing disks.
[  438s] -Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
[  438s] -Units: sectors of 1 * 512 = 512 bytes
[  438s] -Sector size (logical/physical): 512 bytes / 4096 bytes
[  438s] -I/O size (minimum/optimal): 4096 bytes / 32768 bytes
[  438s] -Disklabel type: gpt
[  438s] -Disk identifier: <removed>
[  438s] -
[  438s] -Start    End Size UUID                                 Type             Name
[  438s] - 2048   8191   3M 4DD6948A-44F8-4E6C-8BDC-064F740704F8 Linux root (x86)
[  438s] - 8192  14335   3M 44B51DEF-5F04-465A-91AA-2889A62D8E49 Linux filesystem
[  438s] -14336  20479   3M 643E1D0D-BC02-4CED-B83B-86121062858F Linux filesystem
[  438s] -20480 102399  40M D2A29B0A-FDEE-40C3-9BAE-B9FA782C986C Linux filesystem GPT is the best
[  438s] +sfdisk: libfdisk/src/label.c:175: fdisk_label_get_field: Assertion `id > 0' failed.
[  438s] --- /home/abuild/rpmbuild/BUILD/util-linux-2.26.git227.2cb28/tests/expected/sfdisk/gpt-write-dump      2015-04-21 09:37:08.869755975 +0000
[  438s] +++ /home/abuild/rpmbuild/BUILD/util-linux-2.26.git227.2cb28/tests/output/sfdisk/gpt-write-dump        2015-04-21 10:02:53.680000012 +0000
[  438s] @@ -2,8 +2,8 @@
[  438s]  label-id: 3B8559DB-33AF-43E9-BEFC-C331D829B539
[  438s]  device: <removed>
[  438s]  unit: sectors
[  438s] -first-lba: 2048
[  438s] -last-lba: 102366
[  438s] +first-lba: 2251799813685248
[  438s] +last-lba: 16037037897601253376
[  438s]
[  438s]  <removed>1 : start=        2048, size=        6144, type=44479540-F297-41B2-9AF7-D131D5F0458A, uuid=4DD6948A-44F8-4E6C-8BDC-064F740704F8
[  438s]  <removed>2 : start=        8192, size=        6144, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, uuid=44B51DEF-5F04-465A-91AA-2889A62D8E49
[  438s] + sudo -E ./mount
[  438s] + sudo -E cat /proc/mounts
[  438s] + sudo -E cat /etc/mtab
[  438s] + sudo -E ./losetup --all
[  438s] + md5sum /tmp/mount2_mount /tmp/mount2_proc /tmp/mount2_etc
[  438s] e692b5dd6e7daa7ac1fc6e43d2d8d7b0  /tmp/mount2_mount
[  438s] 5ea7870d46476a3d72a8ee2c26a50842  /tmp/mount2_proc
[  438s] b6abaf8ac1486439f8418d2b2c8c7c5c  /tmp/mount2_etc
[  438s] + diff -u /tmp/mount1_mount /tmp/mount2_mount
[  438s] + diff -u /tmp/mount1_etc /tmp/mount2_etc
[  438s] + diff -u /tmp/mount1_proc /tmp/mount2_proc
[  438s] + diff -u /tmp/losetup1 /tmp/losetup2
[  438s] + exit 1
[  438s] error: Bad exit status from /var/tmp/rpm-tmp.M8JOAg (%check)
[  438s]
[  438s]
[  438s] RPM build errors:
[  438s]     Bad exit status from /var/tmp/rpm-tmp.M8JOAg (%check)
[  438s] ### WATCHDOG MARKER START ###
[  440s] reboot: Power down
[  440s] ### WATCHDOG MARKER END ###


cu,
Rudi
