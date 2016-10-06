Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941886AbcJFNAA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Oct 2016 09:00:00 -0400
Date: Thu, 6 Oct 2016 14:59:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] rev: Avoid out of boundary read
Message-ID: <20161006125958.pbbrc33essqaex77@ws.net.home>
References: <20161003200623.GC2287@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161003200623.GC2287@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 03, 2016 at 10:06:23PM +0200, Tobias Stoeckmann wrote:
> Check if the length of the parsed string is at least 1,
> otherwise an out of boundary read would occur.
> ---
>  text-utils/rev.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
