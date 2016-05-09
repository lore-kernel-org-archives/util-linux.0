Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45336 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbcEIKmy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 May 2016 06:42:54 -0400
Date: Mon, 9 May 2016 12:42:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] setterm: deduplicate color optiong string parsing
Message-ID: <20160509104252.bprannc4x3ycaord@ws.net.home>
References: <1462738638-3141-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462738638-3141-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 08, 2016 at 09:17:17PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/setterm.c | 94 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 41 deletions(-)

I have applied another solution:
https://github.com/karelzak/util-linux/commit/98297e65a1e242cb09c370a10a7c0345fd8504ed

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
