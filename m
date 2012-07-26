Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab2GZKfX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 06:35:23 -0400
Date: Thu, 26 Jul 2012 12:35:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/19] blkid: fix shadow declaration
Message-ID: <20120726103514.GI12592@x2.net.home>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
 <1343243745-1172-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343243745-1172-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 25, 2012 at 09:15:25PM +0200, Sami Kerola wrote:
> misc-utils/blkid.c:402:15: warning: declaration of 'usage' shadows a global declaration [-Wshadow]
> misc-utils/blkid.c:63:13: warning: shadowed declaration is here [-Wshadow]
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/blkid.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
