Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42636 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161AbaEXMaw (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 24 May 2014 08:30:52 -0400
Message-Id: <1400934651.15812.121082081.6ADC22B3@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 1/4] setterm: add usage() descriptions
Date: Sat, 24 May 2014 14:30:51 +0200
In-Reply-To: <1400929696-12548-2-git-send-email-kerolasa@iki.fi>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
 <1400929696-12548-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi Sami,

On Sat, May 24, 2014, at 13:08, Sami Kerola wrote:
> +	fputs(_(" --inversescreen <on|off>          inverse foreground and background colors\n"), out);

s/inverse/swap/
s/colors/colors for the whole screen/

And all these <on|off> should be [on|off], like in the man page,
as they are literal arguments and optional.

> +	fputs(_(" --foreground    <default|color>   set foreground color\n"), out);

default|<color>

> +	fputs(_(" --reverse       <on|off>          reverse all output options\n"), out);

Hm?  Shouldn't that be "set reverse video"?
Or maybe "swap foreground and background colors from here"?
It doesn't invert brightness or other attributes.

> +	fputs(_(" --clear         <all|rest>        clear screen and set cursor position\n"), out);

[all|rest]

> +	fputs(_(" --regtabs       <1-160>           set default tab stop position\n"), out);

To be consistent this should be "--regtabs <number>", and then add that
<number> can be 1..160.  But that loses conciseness.

> +	fputs(_(" --blank         <0-60|force|poke> set inactivity interval\n"), out);

--blank  [<number>|force|poke]
and <number> can be 1..60 (minutes)

Benno

-- 
http://www.fastmail.fm - Send your email first class

