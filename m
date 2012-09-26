Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32756 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505Ab2IZJ1u (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Sep 2012 05:27:50 -0400
Date: Wed, 26 Sep 2012 11:27:46 +0200
From: Karel Zak <kzak@redhat.com>
To: g.esp@free.fr
Cc: util-linux@vger.kernel.org
Subject: Re: mount remount regression with loop and real /etc/mtab
Message-ID: <20120926092746.GG22639@x2.net.home>
References: <1155996641.234046196.1348554681833.JavaMail.root@zimbra33-e6.priv.proxad.net>
 <1939212649.237487662.1348640721365.JavaMail.root@zimbra33-e6.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1939212649.237487662.1348640721365.JavaMail.root@zimbra33-e6.priv.proxad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 26, 2012 at 08:25:21AM +0200, g.esp@free.fr wrote:
> The case that fail with /etc/mtab as real file
> [chroot-i486] root:/tmp$ rm -f /etc/mtab && echo -n >/etc/mtab
> [chroot-i486] root:/tmp$ mount -oloop /tmp/blob /tmp/mnt
> [chroot-i486] root:/tmp$ mount -o remount,loop,ro /tmp/mnt
> [chroot-i486] root:/tmp$ mount
> /dev/loop0 on /tmp/mnt type ext2 (ro,loop)
> [chroot-i486] root:/tmp$ losetup -a
> /dev/loop0: [2051]:306957 (/tmp/blob)
> /dev/loop1: [0005]:2218 (/dev/loop0)
> [chroot-i486] root:/tmp$ umount /tmp/mnt
> umount: /tmp/mnt: filesystem umounted, but mount(8) failed: Device or resource busy
> [chroot-i486] root:/tmp$ losetup -d /dev/loop1
> [chroot-i486] root:/tmp$ losetup -d /dev/loop0

 Fixed. Thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
