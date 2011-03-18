Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43227 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab1CRHG3 (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 18 Mar 2011 03:06:29 -0400
Received: by vws1 with SMTP id 1so3413272vws.19
        for <util-linux-ng@vger.kernel.org>; Fri, 18 Mar 2011 00:06:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimmV34u+t9zDJ44AiAncU1PeSv9Rsn+qkvgeKVS@mail.gmail.com>
References: <AANLkTimmV34u+t9zDJ44AiAncU1PeSv9Rsn+qkvgeKVS@mail.gmail.com>
Date: Fri, 18 Mar 2011 08:06:28 +0100
Message-ID: <AANLkTinJDp6Kwb20dkmgKSNWY0kD7x34ZBgLtDixS9sj@mail.gmail.com>
Subject: Re: mounting FreeBSD partition in Linux (Fedora 14)
From: J B <jb.1234abcd@gmail.com>
To: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> ...
> While having that /dev/sda10 (FreeBSD slice) mounted as above, I used cfdisk
> and added /dev/sda10 Linux partition (right after /dev/sda9 of course).
>
> To my surprise, I discovered that after that df and mount do not show that
> FreeBSD /dev/sda10 mounted partition ! Magically disappeared :-)
> ...

Sorry, not exactly.
The cfdisk action did not cause it of course; it ends with a write command (it
is suggested to reboot to make the changes permanent).
But until that time it creates a presumably semi-permanent state of /dev/sda10
being in cfdisk and fdisk displays, and at the same time df and mount showing
/dev/sda10 mounted as UFS partition on /media mount point.
A subsequent reboot cleared that temporary manual /media mount.

> ...
> What would have happened (as I suggested it previously) if I put that FreeBSD
> /dev/sda10 in /etc/fstab ?
> That new Linux /dev/sda10 partition would be auto mounted at that mount point,
> which would presumably be a source of data for some system or user app ...

That test was done by me.
# cat /etc/fstab
...
/dev/sda10              /media                  ufs     ro,ufstype=ufs2  0 0
...

In this case /dev/sda10 was already a Linux parition per above and the mount
failed as shown in boot log:
# dmesg
...
[   18.597349] EXT4-fs (sda7): re-mounted. Opts: (null)
[   18.835869] ufs_read_super: bad magic number
[   20.743108] Adding 2933244k swap on /dev/sda5.  Priority:-1 extents:1
across:2933244k
...

But other bad outcomes are possible (see next post).

> ...

JB
