Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44380 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028AbbBBKby (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Feb 2015 05:31:54 -0500
Date: Mon, 2 Feb 2015 11:31:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] textual: grammarize and harmonize the stat error message
Message-ID: <20150202103150.GI16162@ws.net.home>
References: <1422562908-2103-1-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422562908-2103-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 29, 2015 at 09:21:48PM +0100, Benno Schulenberg wrote:
>  disk-utils/fdformat.c    |    2 +-
>  disk-utils/fsck.cramfs.c |    2 +-
>  disk-utils/mkfs.bfs.c    |    2 +-
>  disk-utils/mkfs.cramfs.c |    6 +++---
>  disk-utils/mkfs.minix.c  |    2 +-
>  disk-utils/mkswap.c      |    2 +-
>  disk-utils/partx.c       |    2 +-
>  login-utils/last.c       |    2 +-
>  login-utils/utmpdump.c   |    2 +-
>  misc-utils/namei.c       |    2 +-
>  misc-utils/rename.c      |    2 +-
>  sys-utils/blkdiscard.c   |    2 +-
>  sys-utils/dmesg.c        |    2 +-
>  sys-utils/fallocate.c    |    2 +-
>  sys-utils/fsfreeze.c     |    2 +-
>  sys-utils/fstrim.c       |    2 +-
>  sys-utils/swapon.c       |    2 +-
>  sys-utils/switch_root.c  |    4 ++--
>  term-utils/mesg.c        |    2 +-
>  text-utils/more.c        |    2 +-
>  text-utils/tailf.c       |    4 ++--
>  21 files changed, 25 insertions(+), 25 deletions(-)

 Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
