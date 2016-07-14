Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbcGNKMR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 06:12:17 -0400
Date: Thu, 14 Jul 2016 12:12:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix segmentation fault in tailf on 32 bit
Message-ID: <20160714101215.ckr3tl22fmpcumwa@ws.net.home>
References: <20160710141407.GA26802@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160710141407.GA26802@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 10, 2016 at 04:14:08PM +0200, Tobias Stoeckmann wrote:
>  text-utils/tailf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

 Applied with a small change, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
