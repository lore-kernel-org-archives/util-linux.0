Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbcJFM7f (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Oct 2016 08:59:35 -0400
Date: Thu, 6 Oct 2016 14:59:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] rev: Avoid calling free in a signal handler
Message-ID: <20161006125933.zibu5ztbxvi6x4bh@ws.net.home>
References: <20161003200546.GB2287@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161003200546.GB2287@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 03, 2016 at 10:05:46PM +0200, Tobias Stoeckmann wrote:
> free() is not a safe function for a signal handler. The next
> line calls _exit() anyway, so there is no need for resource
> management.
> ---
>  text-utils/rev.c | 1 -
>  1 file changed, 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
