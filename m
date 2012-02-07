Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44906 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760Ab2BGMBN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 07:01:13 -0500
Received: by eaah12 with SMTP id h12so2798159eaa.19
        for <util-linux@vger.kernel.org>; Tue, 07 Feb 2012 04:01:12 -0800 (PST)
From: Rogier Goossens <goossens.rogier@gmail.com>
To: util-linux@vger.kernel.org
Subject: Re: libblkid fails to detect not-so-big OCFS2 filesystems
Date: Tue, 7 Feb 2012 13:01:02 +0100
References: <201201271818.19325.goossens.rogier@gmail.com> <20120130122651.GD22107@x2.net.home>
In-Reply-To: <20120130122651.GD22107@x2.net.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202071301.03056.goossens.rogier@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

> On Fri, Jan 27, 2012 at 06:18:18PM +0100, Rogier Goossens wrote:
> > While testing KDE partitionmanager, I discovered that blkid did
> > not detect the test OCFS2 filesystem I created. After some
> > investigation, it appeared that it will assume the filesystem
> > cannot be OCFS2 if
> 
>  yes, we don't want to probe for some filesystems on very small
>  devices.
> 
> > smaller than 108M. However, mkfs.ocfs2 from ocfs2-tools (1.6.3)
> > will happily create filesystems that are much smaller, only
> > failing below approx. 15000 1k blocks, and below approx. 6000 4k
> > blocks.
> 
>  OK, fixed ... the new limit is 14000 * 1024.

Thanks for fixing !

I did some more testing for other filesystems as well, and I found the 
following:


BTRFS:
The current minimum size is 256MB

While the mkfs.btrfs refuses to create filesystems smaller than 256MB, 
they may span multiple smaller devices/partitions. In addition, after 
creation, devices can be removed to make the filesystem size smaller 
than 256MB. 

While experimenting with different device sizes, I found that a 2MB 
device could still be included in a btrfs filesystem, but including an 
1MB device failed.

A suitable minimum device size for btrfs therefore seems to be 1MB.


REISERFS:
The current minimum size is 4096 * 512.

My tests indicate that the minimum size of the journal is actually 
4096*513 (2052KB), and that mkfs.reiserfs needs at least 2176KB to 
create a filesystem with included journal.

When the journal is on a separate device, the smallest filesystem size 
I managed to create was 19*4096 (76KB) - which is 100% overhead and no 
free blocks :-). Some trickery is needed though, because device sizes 
less than 128KB trigger an assertion in mkfs.reiserfs and 
fsck.reiserfs.

An absolute minimum device size for reiserfs is therefore 76KB, 
although in practise, a device smaller than 128KB would cause problems 
with mkfs and fsck.


I verified JFS as well, and the current minimum size is OK.


Regards,

Rogier.
