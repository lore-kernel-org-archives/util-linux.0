Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59532 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564AbaBTQY3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 20 Feb 2014 11:24:29 -0500
Date: Thu, 20 Feb 2014 17:24:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: findmnt on 3.14-rc3 =?utf-8?B?4oCTIG9u?= =?utf-8?Q?ly?= shows
 /proc in tree mode
Message-ID: <20140220162425.GB27495@x2.net.home>
References: <le50p4$1td$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <le50p4$1td$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 20, 2014 at 03:43:13PM +0200, Mantas Mikulėnas wrote:
> Using util-linux 2.24.1 on Arch Linux, running `findmnt` only shows
> mounts at or under "/proc", and ignores all other mount points
> (including "/"). This only happens in "tree" mode – if I run `findmnt
> --raw` it lists all mounts correctly.
> 
> This happens with custom-built 3.14-rc3 kernel, but works fine with
> Arch's stock 3.13.x (the same Arch initramfs for both). Building
> `findmnt` from util-linux.git did not change anything.
> 
> > $ findmnt
> > TARGET                       SOURCE      FSTYPE    OPTIONS
> > /proc                        proc        proc      rw,nosuid,nodev,noexec,relatime
> > └─/proc/sys/fs/binfmt_misc   systemd-1   autofs    rw,relatime,fd=21,pgrp=1,timeout=300,minprot
> >   └─/proc/sys/fs/binfmt_misc binfmt_misc binfmt_mi rw,relatime
> 
> It seems there is a small difference in /proc/self/mountinfo with 3.14;
> the entry for / looks like this:
> 
> > 19 0 8:3 / / rw,relatime - ext4 /dev/sda3 rw,data=ordered

 Hmm... it seems like the kernel does not have pseudo rootfs entry, so
 the mount IDs starts from zero.

 Fixed (commit 6c373810f5b1d32824371e9dff6ee5a006388f98),
 it was bug in libmount mnt_table_get_root_fs().

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
