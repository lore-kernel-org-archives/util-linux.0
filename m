Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbdKHKye (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 8 Nov 2017 05:54:34 -0500
Date: Wed, 8 Nov 2017 11:54:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Luca Ceresoli <lucaceresoli77@gmail.com>
Cc: util-linux@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH] md5: declare byteReverse as static
Message-ID: <20171108105430.c2vgoj3dqngshepd@ws.net.home>
References: <1510061949-9661-1-git-send-email-lucaceresoli77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510061949-9661-1-git-send-email-lucaceresoli77@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 07, 2017 at 02:39:09PM +0100, Luca Ceresoli wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
> 
> byteReverse() is an internal function in md5.c, and is not exposed via
> any header file, but it is not declared as static.

Well, we use symbols script (libuuid/src/libuuid.sym), so for standard
linker all another symbols are invisible. The problem is static build...

>  lib/md5.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
