Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-phx2.redhat.com ([209.132.183.24]:51986 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab2CBLSN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 2 Mar 2012 06:18:13 -0500
Received: from mail01.corp.redhat.com (zmail01.collab.prod.int.phx2.redhat.com [10.5.5.41])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q22BIDHd001900
	for <util-linux@vger.kernel.org>; Fri, 2 Mar 2012 06:18:13 -0500
Date: Fri, 02 Mar 2012 06:18:13 -0500 (EST)
From: Balamurugan Arumugam <barumuga@redhat.com>
To: util-linux@vger.kernel.org
Subject: unclear udev format output of blkid
Message-ID: <249be96a-803a-4d00-b5b1-ff3f18722a36@zmail01.collab.prod.int.phx2.redhat.com>
In-Reply-To: <5f2c4b72-cda0-4618-ae7c-b89333c1d2b9@zmail01.collab.prod.int.phx2.redhat.com>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi list,

We are trying to parse blkid output in python for all devices and their attributes.

I found two strange things.
1. udev format output is grouped by empty newline, but I see an extra newline in between.
Below is the example,

[root@fedora-16-test ~]# blkid -c /dev/null -o full
/dev/vda2: LABEL="_Fedora-16-x86_6" UUID="8c82103c-23e0-4a86-acd0-5cbe43a91801" TYPE="ext4" 
/dev/vda3: UUID="3c718e5e-8298-4c41-a761-dbed215cbac3" TYPE="swap" 
/dev/vdb: UUID="ywykAs-XOFv-V2OJ-VeMU-3t2Q-kO5o-hyrzE8" TYPE="LVM2_member" 
/dev/vdc: UUID="NzeO60-5FJI-E6GS-ZRos-UbLX-8Aus-35QZMB" TYPE="LVM2_member" 
/dev/mapper/vg00-movies-real: UUID="a0c10d12-1861-42c5-a84a-bf370d554120" TYPE="ext4" 
/dev/vdd: LABEL="brick: /data" UUID="98ef6251-fa20-4439-936e-19e299ee5d49" SEC_TYPE="ext2" TYPE="ext3" 
/dev/mapper/vg00-movies: UUID="a0c10d12-1861-42c5-a84a-bf370d554120" TYPE="ext4" 
/dev/mapper/vg00-0--snap--movies-cow: TYPE="DM_snapshot_cow" 
/dev/mapper/vg00-0--snap--movies: UUID="a0c10d12-1861-42c5-a84a-bf370d554120" TYPE="ext4" 
[root@fedora-16-test ~]# 
[root@fedora-16-test ~]# blkid -c /dev/null -o udev
ID_FS_LABEL=_Fedora-16-x86_6
ID_FS_LABEL_ENC=_Fedora-16-x86_6
ID_FS_UUID=8c82103c-23e0-4a86-acd0-5cbe43a91801
ID_FS_UUID_ENC=8c82103c-23e0-4a86-acd0-5cbe43a91801
ID_FS_TYPE=ext4

ID_FS_UUID=3c718e5e-8298-4c41-a761-dbed215cbac3
ID_FS_UUID_ENC=3c718e5e-8298-4c41-a761-dbed215cbac3
ID_FS_TYPE=swap

ID_FS_UUID=ywykAs-XOFv-V2OJ-VeMU-3t2Q-kO5o-hyrzE8
ID_FS_UUID_ENC=ywykAs-XOFv-V2OJ-VeMU-3t2Q-kO5o-hyrzE8
ID_FS_TYPE=LVM2_member

ID_FS_UUID=NzeO60-5FJI-E6GS-ZRos-UbLX-8Aus-35QZMB
ID_FS_UUID_ENC=NzeO60-5FJI-E6GS-ZRos-UbLX-8Aus-35QZMB
ID_FS_TYPE=LVM2_member

ID_FS_UUID=a0c10d12-1861-42c5-a84a-bf370d554120
ID_FS_UUID_ENC=a0c10d12-1861-42c5-a84a-bf370d554120
ID_FS_TYPE=ext4

ID_FS_LABEL=brick:_/data
ID_FS_LABEL_ENC=brick:\x20\x2fdata
ID_FS_UUID=98ef6251-fa20-4439-936e-19e299ee5d49
ID_FS_UUID_ENC=98ef6251-fa20-4439-936e-19e299ee5d49
ID_FS_SEC_TYPE=ext2
ID_FS_TYPE=ext3

ID_FS_UUID=a0c10d12-1861-42c5-a84a-bf370d554120
ID_FS_UUID_ENC=a0c10d12-1861-42c5-a84a-bf370d554120
ID_FS_TYPE=ext4

ID_FS_TYPE=DM_snapshot_cow

ID_FS_UUID=a0c10d12-1861-42c5-a84a-bf370d554120
ID_FS_UUID_ENC=a0c10d12-1861-42c5-a84a-bf370d554120
ID_FS_TYPE=ext4
[root@fedora-16-test ~]# 

You can see last few lines are having confusing information.
Is it known issue?

2. In udev format output for all devices, there is no devname displayed.  Without devname, its unclear grouping.  Is there a plan to add devname in udev format output?


I tried the above in util-linux from fedora 16 and git source build.

Thanks in advance,

Regards,
Bala
