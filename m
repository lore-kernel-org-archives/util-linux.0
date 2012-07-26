Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32572 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385Ab2GZKeG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 06:34:06 -0400
Date: Thu, 26 Jul 2012 12:33:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/19] libmount: fix shadow declaration
Message-ID: <20120726103357.GG12592@x2.net.home>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
 <1343243745-1172-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343243745-1172-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 25, 2012 at 09:15:23PM +0200, Sami Kerola wrote:
> libmount/src/tab_update.c:203:8: warning: declaration of 'rc' shadows a previous local [-Wshadow]
> libmount/src/tab_update.c:159:6: warning: shadowed declaration is here [-Wshadow]
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  libmount/src/tab_update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
