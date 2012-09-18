Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757371Ab2IRJ3a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Sep 2012 05:29:30 -0400
Date: Tue, 18 Sep 2012 11:29:26 +0200
From: Karel Zak <kzak@redhat.com>
To: g.esp@free.fr
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux-2.22 regression on umount with loop and /etc/mtab
 real file
Message-ID: <20120918092926.GA20576@x2.net.home>
References: <1621495890.210163275.1347911558877.JavaMail.root@zimbra33-e6.priv.proxad.net>
 <2140853048.211115988.1347947429555.JavaMail.root@zimbra33-e6.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2140853048.211115988.1347947429555.JavaMail.root@zimbra33-e6.priv.proxad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 18, 2012 at 07:50:29AM +0200, g.esp@free.fr wrote:
> The loop is cleaned on umount with 2.21.2
> With 2.22, unmounting /tmp/foo_fs no more remove the loop
> 
> [chroot-i486] root:/$ mount --version
> mount from util-linux 2.22 (libmount 2.22.0: debug)
> [chroot-i486] root:/$ losetup -a
> [chroot-i486] root:/$ mount -oloop /tmp/foo_fs /tmp/bar_dir
> [chroot-i486] root:/$ umount /tmp/foo_fs
> [chroot-i486] root:/$ losetup -a
> /dev/loop0: [2051]:387175 (/tmp/foo_fs)
> 
> The loop remain.

Kernel version? I guess something old... :-)

Since kernel 2.6.37 we use autoclear flag:

  $ cat /sys/block/loop0/loop/autoclear
  1

if the flags is enabled (should be always by mount(8)) then the loop
device is automatically detached by kernel after successful umount(2).
It means that we don't have to store any extra information in
userspace or do any magic around loopdevs in umount(8) command.


I found a bug in libmount umount code, it does not check for the
option "loop" in mtab -- this bug is invisible on systems where
autoclear flags is usable. Fixed. Try the code from upstream tree:

  git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
  cd util-linux
  ./autogen.sh
  ./configure
  make mount umount

Note that you can use LIBMOUNT_DEBUG=0xffff env.variable to get more
information from libmount.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
