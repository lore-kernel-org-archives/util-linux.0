Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46561 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbaEXMoU (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 24 May 2014 08:44:20 -0400
Message-Id: <1400935458.18113.121085821.31470970@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1400929696-12548-5-git-send-email-kerolasa@iki.fi>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
 <1400929696-12548-5-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
Date: Sat, 24 May 2014 14:44:18 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, May 24, 2014, at 13:08, Sami Kerola wrote:
> Underline option arguments, and use bold for options.

Ehm, no, that is not the style.  Italics (underline on a terminal) is
for things that need to be replaced, need to be filled in; bold is for
literal arguments, things that have to be typed as is.

> +.RI ( on
> +or
> +.IR off ),

.RB ( on " or " off )

> +the default is
> +.IR on .

.BR on .

> +.I 8-color

Correct.

> +below is
> +.IR  black ,

.BR black ,

And so on.

Benno

-- 
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again

