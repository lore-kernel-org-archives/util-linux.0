Return-Path: util-linux-owner@vger.kernel.org
Received: from quantum.linuxfromscratch.org ([216.171.237.234]:35633 "EHLO
	quantum.linuxfromscratch.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759938Ab2J3XKj (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 30 Oct 2012 19:10:39 -0400
Received: from [192.168.0.3] (5ad2953d.bb.sky.com [90.210.149.61])
	by quantum.linuxfromscratch.org (Postfix) with ESMTPA id 5B6AD14182
	for <util-linux@vger.kernel.org>; Tue, 30 Oct 2012 17:04:00 -0600 (MDT)
Message-ID: <1351638239.1651.13.camel@kyoto.localdomain>
Subject: Discrepancies between real and symlinked mtab
From: Matt Burgess <matthew@linuxfromscratch.org>
To: util-linux@vger.kernel.org
Date: Tue, 30 Oct 2012 23:03:59 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Consider trying to answer the question "What partition is mounted
on /" (it happens to be /dev/sda3 in this example), when /etc/mtab is a
symlink pointing to /proc/mounts:

1) mount(8)

/dev/root on / type ext3 (rw,relatime,data=ordered)

Nope, that's not /dev/sda3.  And what is /dev/root anyway? There's no
such node under /dev here.

2) df(1)

Filesystem     1K-blocks    Used Available Use% Mounted on
rootfs          20642428 1576788  18017064   9% /
/dev/root       20642428 1576788  18017064   9% /

Uh-oh - now I appear to have 2 filesystems mounted at '/' (yes, I know
you can tell by the same stats that it is in fact the same FS).  What is
this rootfs entry?

3) lsblk(8)

NAME FSTYPE LABEL UUID                                 MOUNTPOINT
sda3 ext3   /lfs  aaf09e8b-d50e-429e-ba8e-11fa07ab5b75 

Well, that's odd.  I know that /dev/sda3 is mounted at /, but apparently
lsblk(8) doesn't!

If /etc/mtab is a real file, then the output of all 3 commands is
correct (and by that I mean it shows /dev/sda3).

As all 3 utils show the same issue, I assume this is something to do
with libblkid?

Thanks,

Matt.

