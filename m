Return-Path: util-linux-owner@vger.kernel.org
Received: from monster.unsafe.ru ([195.18.34.9]:41019 "EHLO mail.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423097Ab2KNUE5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 15:04:57 -0500
Received: from [192.168.1.10] (unknown [77.232.15.43])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.unsafe.ru (Postfix) with ESMTPSA id 41AFF3620238
	for <util-linux@vger.kernel.org>; Wed, 14 Nov 2012 20:04:54 +0000 (UTC)
Message-ID: <50A3F95E.6030407@gmail.com>
Date: Thu, 15 Nov 2012 00:04:46 +0400
From: Alexey Gladkov <gladkov.alexey@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: new mount regression
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Greetings!

I found that mount no longer understands fstype list in the /etc/fstab
after the migration to libmount:

$ dd if=/dev/zero of=/tmp/disk bs=1M count=10
$ losetup /dev/loop0 /tmp/disk
$ mkfs.ext3 /dev/loop0
$ grep loop0 /etc/fstab
/dev/loop0 /media vfat,hfsplus,ext4,ext3,ext2 defaults 0 0

$ mount /media
mount: unknown filesystem type 'vfat,hfsplus,ext4,ext3,ext2'

But if we use deprecated mount:

$ ./mount.deprecated -v /media
/dev/loop0 on /media type ext4 (rw)

Also new mount understands fstype list in options:

$ mount -t vfat,hfsplus,ext4,ext3,ext2 /dev/loop0 /media

-- 
Rgrds, legion

