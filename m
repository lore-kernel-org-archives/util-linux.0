Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4928 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756787Ab2EOJeB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 05:34:01 -0400
Date: Tue, 15 May 2012 11:33:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mangle: check for end of string on every iteration
Message-ID: <20120515093356.GH8268@x2.net.home>
References: <1336936489-8203-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336936489-8203-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 13, 2012 at 03:14:49PM -0400, Dave Reisner wrote:
> Checking for the null byte at the end of the string only conditionally
> leads to segfaults, evidenced by mount helpers crashing on writes to

 Ah.. sorry.

> /run/mount/utab. Simply check for the null on each iteration, and append
> a null byte to the mangled string before breaking.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  lib/mangle.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
