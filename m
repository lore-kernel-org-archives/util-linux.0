Return-Path: util-linux-owner@vger.kernel.org
Received: from nm7.bullet.mail.sp2.yahoo.com ([98.139.91.77]:48112 "HELO
	nm7.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932818Ab2ASU63 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Jan 2012 15:58:29 -0500
Message-ID: <4F188277.7090100@yahoo.com.ar>
Date: Thu, 19 Jan 2012 17:52:07 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: mount (new): Using -a, exits with 64.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello

Using new mount, when run with -a and some mounting is performed, mount 
retuns 64 instead of 0.

Example:

# mkdir /mnt/coco
# echo "coco /mnt/coco tmpfs defaults 0 0" >> /etc/fstab
# mount -a ; echo $?
64
# mount | tail -1
coco on /mnt/coco type tmpfs (rw,relatime)
# umount  /mnt/coco
# mount /mnt/coco ; echo $?
0
# mount --version
mount from util-linux 2.21-rc1 (libmount 2.21.0)

-- 
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha = 1

