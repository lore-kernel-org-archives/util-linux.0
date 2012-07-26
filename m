Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab2GZKfC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 06:35:02 -0400
Date: Thu, 26 Jul 2012 12:34:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/19] sulogin: fix shadow declaration
Message-ID: <20120726103453.GH12592@x2.net.home>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
 <1343243745-1172-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343243745-1172-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 25, 2012 at 09:15:24PM +0200, Sami Kerola wrote:
> login-utils/sulogin.c:337:8: warning: declaration of 'sushell' shadows a global declaration [-Wshadow]
> login-utils/sulogin.c:332:13: warning: shadowed declaration is here [-Wshadow]
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/sulogin.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

 Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
