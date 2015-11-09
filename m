Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59896 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbbKIK3d (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Nov 2015 05:29:33 -0500
Date: Mon, 9 Nov 2015 11:29:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] losetup: support direct-IO to backing file
Message-ID: <20151109102931.GU19508@ws.net.home>
References: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 07, 2015 at 08:40:16AM +0800, Ming Lei wrote:
> The loop direct I/O patches[1] have been merged to linus kernel tree
> and will be released in v4.4.
> 
> So the two patches provide interfaces for using direct IO/AIO
> in losetup.

Thanks!

>  include/loopdev.h   |  4 ++++
>  lib/loopdev.c       | 40 ++++++++++++++++++++++++++++++++++++++++
>  sys-utils/losetup.c | 30 +++++++++++++++++++++++++++---
>  3 files changed, 71 insertions(+), 3 deletions(-)
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bc07c10a3603a5ab3ef01ba42b3d41f9ac63d1b6

If I read correctly the kernel code than LO_FLAGS_DIRECT_IO is not
possible to use when initialize loop device by LOOP_SET_FD ioctl. I
need extra LOOP_SET_DIRECT_IO ioctl. Why?

Why kernel function loop_set_fd() does not initialize lo->use_dio
according to "lo_flags & LO_FLAGS_DIRECT_IO" as we use for another
loopdev stuff? See for example LO_FLAGS_PARTSCAN. Would be possible 
to improve kernel a little bit?


Now you have to use two commands (ioctls):

 # losetup /dev/loop0 file.img
 # losetup --direct-io 1 /dev/loop0

It's fine to use --direct-io as toggle, but it would be nice to
support it also when initialize the device.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
