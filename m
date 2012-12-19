Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34324 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab2LSP41 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Dec 2012 10:56:27 -0500
Date: Wed, 19 Dec 2012 14:38:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 13/14] lib/ismounted: detect loopback mounts
Message-ID: <20121219133843.GC17959@x2.net.home>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
 <1355654642-22106-14-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355654642-22106-14-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 16, 2012 at 10:44:01AM +0000, Sami Kerola wrote:
> While double checking the minix changes worked I noticed fsck.minix not
> to abort check if the file system was mounted using loopback device.  The
> commands before this commit which one needs to reproduce the issue are:
> 
> dd if=/dev/zero count=100 of=minixfs
> ./mkfs.minix ./minixfs
> mkdir x
> ./mount ./minixfs x
> ./fsck.minix minixfs

 Nice catch, although I have doubts that this is expected way how use
 fsck ;-)

> Neither did that appear, nor the fsck check got to be aborted.  It seems
> the generic fsck, and mkswap had same problem as they rely on
> is_mounted().

 fsck(8) uses libmount and this use case (fsck <fs image>) is ignored
 there. Not sure if we want to support it... 
 
 (It's not so easy, because you can use --offset and --sizelimit in losetup, 
  and you need these information to (reliable) found connection between 
  the image and a filesystem. It's already implemented in libmount,
  but it seems like overkill for fsck. I'll think about it.... :-)

>  lib/Makemodule.am | 1 +
>  lib/ismounted.c   | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

 I have applied a little different solution. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
