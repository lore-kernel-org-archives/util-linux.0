Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45825 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964898AbcBQNHc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Feb 2016 08:07:32 -0500
Date: Wed, 17 Feb 2016 14:07:30 +0100
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] unshare: allow persisting mount namespaces
Message-ID: <20160217130730.s54rcv65vygikurg@ws.net.home>
References: <1428578536-31603-1-git-send-email-kzak@redhat.com>
 <1428578536-31603-2-git-send-email-kzak@redhat.com>
 <87bnix6xj6.fsf@x220.int.ebiederm.org>
 <20150410081733.GM3923@ws.net.home>
 <m31t8zhgfv.fsf@gmail.com>
 <m3twlvfb39.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3twlvfb39.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 30, 2016 at 04:31:06PM +0300, Yuriy M. Kaminskiy wrote:
> From 64d1e9d905455b8177d65ad58ca2b403bbe8222c Mon Sep 17 00:00:00 2001
> From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
> Date: Sat, 30 Jan 2016 16:18:39 +0300
> Subject: [PATCH] unshare: fix busyloop and reduce racing probability
> 
> Replace busy-loop with waiting on pipe from parent.
> 
> Note: reduces racing probability, but still there are window where
> it is possible (if parent unshare process will be [externally] killed
> between successful read(fds[0]) and mount() calls).
> 
> Signed-off-by: Yuriy M. Kaminskiy <yumkam@gmail.com>
> ---
>  sys-utils/unshare.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 9 deletions(-)

 Thanks, applied with small changes. 
 
 I have used stuff from include/all-io.h (loops around read/write)
 to make code more readable.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
