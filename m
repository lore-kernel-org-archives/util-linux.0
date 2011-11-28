Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49350 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab1K1JOk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Nov 2011 04:14:40 -0500
Date: Mon, 28 Nov 2011 10:14:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Roger Leigh <rleigh@codelibre.net>
Cc: util-linux@vger.kernel.org
Subject: Re: Using /etc/fstab.d
Message-ID: <20111128091435.GB29168@nb.net.home>
References: <20111127221956.GF17458@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111127221956.GF17458@codelibre.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 27, 2011 at 10:19:56PM +0000, Roger Leigh wrote:
> I noticed that support had recently been added for /etc/fstab.d.
> In Debian, we're configuring with --enable-libmount-mount, but
> I'm not seeing it being used; strace shows no opendir/stat calls
> for it.  Is anything else necessary to enable it, or is it not
> yet actually used by mount?

 Do you really have the latest git tree (gil pull to refresh)?

> I've just created a file /etc/fstab.d/test.fstab, and then
> tried "mount /foo", where /foo would be the entry in test.fstab,
> but don't see anything happening.

 [git clone / git clean -xdf; cd util-linux]

 $ ./autogen.sh
 $ ./configure --enable-libmount-mount
 $ make -C mount/ mount

 # cat /etc/fstab.d/tests.fstab 
 /home/fs-images/ext2.img /mnt/loop      auto    defaults,noauto

 # ./mount/mount /mnt/loop

 # findmnt /mnt/loop
 TARGET    SOURCE     FSTYPE OPTIONS
 /mnt/loop /dev/loop0 ext2   rw,relatime,errors=continue


 # findmnt --fstab /mnt/loop
 TARGET    SOURCE                   FSTYPE OPTIONS
 /mnt/loop /home/fs-images/ext2.img auto   defaults,noauto


 .. so works for me ;-)

 Try 
       LIBMOUNT_DEBUG=0xffff ./mount/mount ...

 to debug the problem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
