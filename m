Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55531 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750749AbaD1InJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Apr 2014 04:43:09 -0400
Message-Id: <1398674252.3689.111120501.427ACD73@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1398629138-31718-9-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
 <1398629138-31718-9-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 08/12] swapon: swaps with legacy version label are not
 supported
Date: Mon, 28 Apr 2014 10:37:32 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Apr 27, 2014, at 22:05, Sami Kerola wrote:
> -	if (memcmp(buf, "SWAP-SPACE", 10) == 0 ||
> -            memcmp(buf, "SWAPSPACE2", 10) == 0)
> +	if (memcmp(buf, SWAP_SIGNATURE, 10) == 0)

s/10/SWAP_SIGNATURE_SZ/  ?

Benno

-- 
http://www.fastmail.fm - Accessible with your email software
                          or over the web

