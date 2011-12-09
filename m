Return-Path: util-linux-owner@vger.kernel.org
Received: from gimli.pitney-fabs.co.uk ([87.106.140.52]:50974 "EHLO
	gimli.pitney-fabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab1LIMeC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Dec 2011 07:34:02 -0500
Received: from host81-139-106-247.in-addr.btopenworld.com ([81.139.106.247] helo=golden.localdomain)
	by gimli.pitney-fabs.co.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <walrond.andrew@gimli.pitney-fabs.co.uk>)
	id 1RYzeJ-0001CD-RA
	for util-linux@vger.kernel.org; Fri, 09 Dec 2011 12:34:00 +0000
Date: Fri, 9 Dec 2011 12:33:58 +0000
From: Andrew Walrond <andrew@walrond.org>
To: util-linux@vger.kernel.org
Subject: Mount -a and bind mounts. Bug?
Message-ID: <20111209123357.GA3173@golden.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When using bind mounts, particularly when they are specified in /etc/fstab, 'mount -a' does not recognise that a mount is already mounted and will rebind another copy over the top with each mount -a.

Is this the expected behaviour? I'm not sure so I thought I'd ask.
I'm using v2.20.1.

Example:

user@localhost ~ $ cat /etc/fstab 
#FILESYSTEM          MOUNTPOINT  TYPE     OPTIONS      BACKUP FSCK-PASS
/root/etc            /etc        none     bind         0      0
/root/home           /home       none     bind         0      0
/root/local          /local      none     bind         0      0
/root/mnt            /mnt        none     bind         0      0
/root/tmp            /tmp        none     bind         0      0
/root/var            /var        none     bind         0      0
/root/swap            none       swap     sw           0      0

user@localhost ~ $ mount
rootfs on / type rootfs (rw,size=0k,nr_inodes=0)
none on /dev type devtmpfs (rw,relatime,size=7202028k,nr_inodes=1800507,mode=755)
none on /proc type proc (rw,relatime)
none on /sys type sysfs (rw,relatime)
none on /dev/pts type devpts (rw,relatime,gid=3,mode=620)
none on /dev/shm type tmpfs (rw,relatime)
/dev/vda on /root type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /etc type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /home type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /local type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /mnt type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /tmp type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /var type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)

user@localhost ~ $ sudo mount  -a

user@localhost ~ $ mount
rootfs on / type rootfs (rw,size=0k,nr_inodes=0)
none on /dev type devtmpfs (rw,relatime,size=7202028k,nr_inodes=1800507,mode=755)
none on /proc type proc (rw,relatime)
none on /sys type sysfs (rw,relatime)
none on /dev/pts type devpts (rw,relatime,gid=3,mode=620)
none on /dev/shm type tmpfs (rw,relatime)
/dev/vda on /root type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /etc type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /home type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /local type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /mnt type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /tmp type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /var type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /etc type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /home type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /local type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /mnt type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /tmp type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
/dev/vda on /var type ext4 (rw,relatime,user_xattr,acl,barrier=1,data=ordered)
