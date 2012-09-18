Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp4-g21.free.fr ([212.27.42.4]:50571 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273Ab2IRFui (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Sep 2012 01:50:38 -0400
Received: from zimbra33-e6.priv.proxad.net (unknown [172.20.243.183])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 13A3E4C8018
	for <util-linux@vger.kernel.org>; Tue, 18 Sep 2012 07:50:30 +0200 (CEST)
Date: Tue, 18 Sep 2012 07:50:29 +0200 (CEST)
From: g.esp@free.fr
To: util-linux@vger.kernel.org
Message-ID: <2140853048.211115988.1347947429555.JavaMail.root@zimbra33-e6.priv.proxad.net>
In-Reply-To: <1621495890.210163275.1347911558877.JavaMail.root@zimbra33-e6.priv.proxad.net>
Subject: util-linux-2.22 regression on umount with loop and /etc/mtab real
 file
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I find that some coreutils(-8.19) tests using mount -oloop fail to remove the loop when the fs is unmounted after util-linux-2.22 upgrade.

How to reproduce

[chroot-i486] root:/$ mount --version
mount from util-linux 2.21.2 (with libblkid support)
[chroot-i486] root:/$ dd if=/dev/zero of=/tmp/foo_fs bs=8192 count=200 &>/dev/null
[chroot-i486] root:/$ mkfs -t ext2 -F /tmp/foo_fs &>/dev/null
[chroot-i486] root:/$ mkdir /tmp/bar_dir

[chroot-i486] root:/$ mount -oloop /tmp/foo_fs /tmp/bar_dir
[chroot-i486] root:/$ losetup -a
/dev/loop0: [2051]:366712 (/tmp/foo_fs)
[chroot-i486] root:/$ umount /tmp/foo_fs
[chroot-i486] root:/$ losetup -a

The loop is cleaned on umount with 2.21.2
With 2.22, unmounting /tmp/foo_fs no more remove the loop

[chroot-i486] root:/$ mount --version
mount from util-linux 2.22 (libmount 2.22.0: debug)
[chroot-i486] root:/$ losetup -a
[chroot-i486] root:/$ mount -oloop /tmp/foo_fs /tmp/bar_dir
[chroot-i486] root:/$ umount /tmp/foo_fs
[chroot-i486] root:/$ losetup -a
/dev/loop0: [2051]:387175 (/tmp/foo_fs)

The loop remain.

A real /etc/mtab was in use. If using /etc/mtab as a symlink to /proc/mount, the loop disappear on umount.
I am not a strong opponent to /etc/mtab as symlink as I was there a few years back. And I know where the wind is blowing actually.
It's just that issues happen in both cases.
For example, a simple df command inside a chroot report error for mountpoints made outside of the chroot.

Gilles
