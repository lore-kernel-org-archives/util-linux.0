Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52124 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075AbaEYVKX (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 25 May 2014 17:10:23 -0400
Message-Id: <1401052223.27518.121405397.106D8440@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAG27Bk2CBYDtF36R-41ZAqQrpzbdqP4=TDQx3m32=hs25GyFZg@mail.gmail.com>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
 <1400929696-12548-5-git-send-email-kerolasa@iki.fi>
 <1400935458.18113.121085821.31470970@webmail.messagingengine.com>
 <CAG27Bk2CBYDtF36R-41ZAqQrpzbdqP4=TDQx3m32=hs25GyFZg@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
Date: Sun, 25 May 2014 23:10:23 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, May 25, 2014, at 12:58, Sami Kerola wrote:
> That convention should be documented. Meanwhile I hope the following
> is a bit closer how the manual should be.
> 
> New version:
> https://github.com/kerolasa/lelux-utiliteetit/commit/bbc05cc2e30a6d6a3adcc7207d5549b782f03574

> -.B force
> +.I force

This and poke are literal arguments and should stay bold.

> -.B \-\-default
> +\fB\-\-default\fP

Why do you make this kind of changes?  The first is perfectly fine
and more readable.

I am not going to make any more detailed comments, it's much
easier to later simply provide a patch.

Benno

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own

