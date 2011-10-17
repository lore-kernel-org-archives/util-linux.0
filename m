Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50648 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab1JQJQG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Oct 2011 05:16:06 -0400
Date: Mon, 17 Oct 2011 11:15:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] rtcwake: fix crash (invalid free)
Message-ID: <20111017091539.GK9667@nb.net.home>
References: <1318509631-10977-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318509631-10977-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 13, 2011 at 02:40:31PM +0200, Petr Uzel wrote:
> ~ $ rtcwake -d X -s 10
> *** glibc detected *** rtcwake: munmap_chunk(): invalid pointer: 0x00007fff839253c3 ***
> ======= Backtrace: =========
> /lib64/libc.so.6(+0x733b6)[0x7f582677a3b6]
> rtcwake[0x4022d5]
> /lib64/libc.so.6(__libc_start_main+0xfd)[0x7f5826725bfd]
> rtcwake[0x4016b9]
> ======= Memory map: ========
> <SNIP>
> 
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  sys-utils/rtcwake.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
