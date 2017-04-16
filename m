Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:47600 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754504AbdDPBIV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Apr 2017 21:08:21 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id v3G18HRT023165
        for <util-linux@vger.kernel.org>; Sat, 15 Apr 2017 18:08:19 -0700
Message-ID: <58F2C401.5090001@tlinx.org>
Date: Sat, 15 Apr 2017 18:08:17 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: util-linux-v2.25:mountpoint misnamed or bugged, and "-d" bugged
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


mountpoint doesn't detect file, device
or other inode mount points.

Also, the "-d" switch doesn't show the maj:min of the mounted
inode.  Of note: "-x" does show the maj:min of a remounted blockdev.

#reproduce (showing additional variant w/a char device)

cd /tmp
mkdir foo1
cd foo1
mkdir mnt
sudo mount tmpfs -t tmpfs mnt
touch mnt/file mnt_file mnt_null
sudo mknod mnt/null c 1 3
sudo mount --bind mnt/file mnt_file
sudo mount --bind mnt/null mnt_null
function is_mountedQ {
  if /usr/bin/mountpoint -q $1; then
    echo "$1 is a mount point"
  else
    echo "$1 is not a mount point"
  fi
}
is_mountedQ mnt_file
is_mountedQ mnt_null

------------
Note, -x does show a remounted dev:

Ishtar:/tmp/foo1/mnt> sudo mknod sda b 8 0
Ishtar:/tmp/foo1> ll mnt/sda
  brw-rw-r-- 1 8, 0 Apr 15 17:59 mnt/sda
Ishtar:/tmp/foo1> touch mnt_sda
Ishtar:/tmp/foo1> sudo mount --bind mnt/sda mnt_sda
Ishtar:/tmp/foo1> ll mnt_sda
  brw-rw-r-- 1 8, 0 Apr 15 17:59 mnt_sda
Ishtar:/tmp/foo1> mountpoint -x mnt_sda
  8:0

"mount |grep foo1" shows all the mount points:

Ishtar:/tmp/foo1> mount |grep foo1
tmpfs on /tmp/foo1/mnt type tmpfs (rw,relatime)
tmpfs on /tmp/foo1/mnt_file type tmpfs (rw,relatime)
tmpfs on /tmp/foo1/mnt_null type tmpfs (rw,relatime)
tmpfs on /tmp/foo1/mnt_sda type tmpfs (rw,relatime)

======
Side (or end) note:
Besides "mountpoint" handling mounted inodes, it **could**
be "more complete" by being enhanced to:

1) scan all names on its command line
2) scan all inodes in a directory
  or
3) scan all inodes recursively, starting at a directory


