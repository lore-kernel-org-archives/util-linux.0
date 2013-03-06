Return-Path: util-linux-owner@vger.kernel.org
Received: from brisi.sourcepole.ch ([5.9.57.43]:60562 "EHLO
	brisi.sourcepole.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143Ab3CFOJ1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Mar 2013 09:09:27 -0500
Received: from brisi-br ([192.168.138.1] helo=sourcepole.ch)
	by vilan-mail with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <tpo2@sourcepole.ch>)
	id 1UDER4-0007yz-9o
	for util-linux@vger.kernel.org; Wed, 06 Mar 2013 14:31:13 +0100
To: <util-linux@vger.kernel.org>
Subject: making users aware of losetup rw =?UTF-8?Q?setups=3F?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 06 Mar 2013 14:31:03 +0100
From: Tomas Pospisek <tpo2@sourcepole.ch>
Message-ID: <e685cb16a5c23651124fb5ed69469042@sourcepole.ch>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The loopback blockdevice is extremely handy and nice to use, however 
there are many allusions on the internets [1] [2], that using a loopback 
block device on a disk image in a rw manner is unreliable, i.e. the 
loopback device *might eat your data* (!).

This is a kernel/driver issue for sure, however I'd like if that was 
documented in the losetup manpage so that users are made aware of the 
fact and don't loose their data.

We seem to have been bitten by this problem recently. In our case we 
have a LVM partition that contains a disk image. We make a LVM snapshot 
of that LVM partition in order to backup it up. Since the LVM partition 
contains a disk image with its own partition, we mount the respective 
disk-partition with an offset like this:

   mount -o offset=1048576 /dev/vg_disks/server_image /mnt/snapshot

I think it is while mounting that we see this:

[65162.184173] Buffer I/O error on device loop0, logical block 3932144
[65162.184297] Buffer I/O error on device loop0, logical block 3932144
[65162.184431] Buffer I/O error on device loop0, logical block 3932158
[65162.184555] Buffer I/O error on device loop0, logical block 3932158
[65162.210044] Buffer I/O error on device loop0, logical block 3932144
[65162.210281] Buffer I/O error on device loop0, logical block 3932158
[65162.210323] Buffer I/O error on device loop0, logical block 3932159
[65162.210373] Buffer I/O error on device loop0, logical block 3932159
[65162.210422] Buffer I/O error on device loop0, logical block 3932159
[65162.210588] Buffer I/O error on device loop0, logical block 3932159
[65162.299517] EXT4-fs (loop0): ext4_orphan_cleanup: deleting 
unreferenced inode 81
[65162.299531] EXT4-fs (loop0): 1 orphan inode deleted
[65162.299550] EXT4-fs (loop0): recovery complete
[65162.367689] EXT4-fs (loop0): mounted filesystem with ordered data 
mode. Opts: (null)
[65255.139406] quiet_error: 35 callbacks suppressed
[65255.139447] Buffer I/O error on device loop0, logical block 7864304
[65255.139509] Buffer I/O error on device loop0, logical block 7864304
[65255.139578] Buffer I/O error on device loop0, logical block 7864318
[65255.139635] Buffer I/O error on device loop0, logical block 7864318
[65255.141001] Buffer I/O error on device loop0, logical block 7864304
[65255.152388] Buffer I/O error on device loop0, logical block 7864318
[65255.153897] Buffer I/O error on device loop0, logical block 7864319
[65255.155149] Buffer I/O error on device loop0, logical block 7864319
[65255.156447] Buffer I/O error on device loop0, logical block 7864319
[65255.157690] Buffer I/O error on device loop0, logical block 7864319
[65255.270004] EXT4-fs (loop0): ext4_orphan_cleanup: deleting 
unreferenced inode 92
[65255.270019] EXT4-fs (loop0): ext4_orphan_cleanup: deleting 
unreferenced inode 91
[65255.270023] EXT4-fs (loop0): ext4_orphan_cleanup: deleting 
unreferenced inode 90
[65255.270026] EXT4-fs (loop0): ext4_orphan_cleanup: deleting 
unreferenced inode 89
[65255.270030] EXT4-fs (loop0): ext4_orphan_cleanup: deleting 
unreferenced inode 86
[65255.270033] EXT4-fs (loop0): 5 orphan inodes deleted
[65255.270504] EXT4-fs (loop0): recovery complete
[65255.395442] EXT4-fs (loop0): mounted filesystem with ordered data 
mode. Opts: (null)

In short - somehow the FS gets errors from the underlying loop device. 
However the layers below the loop device are *not* reporting any errors, 
thus one would think it's the loop device itself that is breaking here.

The backups runs every night and we have been seeing this occassionally 
- say once a week. A few times it hung the whole machine.

I get the impression that it has been known for at least 5 years that 
the loopback block device is broken wrt to writing back to the 
underlying layer in edge cases, however there is no up front clear 
documentation of that fact. Thus until (if) this will be fixed in the 
kernel I would suggest to put a big warning into the losetup man page.

?

Thanks,
*t

[1] http://www.drbd.org/users-guide/ch-configure.html
[2] https://bugs.launchpad.net/wubi/+bug/204133
