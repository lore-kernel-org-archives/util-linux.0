Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49421 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab2GZKcn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 06:32:43 -0400
Date: Thu, 26 Jul 2012 12:32:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/19] mkswap: fix shadow declaration
Message-ID: <20120726103233.GF12592@x2.net.home>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
 <1343243745-1172-5-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343243745-1172-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 25, 2012 at 09:15:22PM +0200, Sami Kerola wrote:
> disk-utils/mkswap.c:366:57: warning: declaration of 'is_blkdev' shadows a global declaration [-Wshadow]
> ./include/blkdev.h:92:5: warning: shadowed declaration is here [-Wshadow]
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  disk-utils/mkswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
