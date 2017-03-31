Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932554AbdCaJTa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 05:19:30 -0400
Date: Fri, 31 Mar 2017 11:19:25 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: find device of a known mountpoint
Message-ID: <20170331091925.mpwmxxk4da4lsegr@ws.net.home>
References: <5f3534af-06b5-9c76-f5e3-9c1d489e570c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5f3534af-06b5-9c76-f5e3-9c1d489e570c@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 31, 2017 at 11:00:24AM +0200, Rüdiger Meier wrote:
> $ truncate -s100M /tmp/img
> $ losetup /dev/loop0  /tmp/img
> $ mkfs.ext2  /dev/loop0
> 
> $ mkdir /tmp/mnt
> $ ln -s /tmp  /tmp/xyz/symlink
> 
> $ mount /dev/loop0 /tmp/xyz/symlink/mnt
> $ mount | grep loop
> /dev/loop0 on /tmp/mnt type ext2 ...
> 
> 
> I need a command which outputs "/dev/loop0" when "/tmp/xyz/symlink/mnt" is
> given.

  $ findmnt -no SOURCE /tmp/xyz/symlink/mnt
  /dev/loop0


Note that for bind mounts there is nothing like primary (original)
and secondary mountpoints. It's two ways to the same filesystem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
