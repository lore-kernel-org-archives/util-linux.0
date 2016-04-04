Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52224 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926AbcDDIdt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Apr 2016 04:33:49 -0400
Date: Mon, 4 Apr 2016 10:33:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] chrt: validate priority before trying to use it
Message-ID: <20160404083348.csw5hqnmw5gbyyvz@ws.net.home>
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
 <1459672529-2278-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459672529-2278-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 03, 2016 at 09:35:29AM +0100, Sami Kerola wrote:
>  schedutils/chrt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

 Too late for v2.28, applied to the "next" branch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
