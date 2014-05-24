Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39158 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750751AbaEXMdc (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 24 May 2014 08:33:32 -0400
Message-Id: <1400934810.16438.121084941.30D576D1@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1400929696-12548-3-git-send-email-kerolasa@iki.fi>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
 <1400929696-12548-3-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 2/4] docs: setterm.1 add missing options to manual page and
 remove duplicate
Date: Sat, 24 May 2014 14:33:30 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, May 24, 2014, at 13:08, Sami Kerola wrote:
> +.TP
> +.BR \-\-inversescreen " [" on | off "]"

Previously it had the string "(virtual consoles only)" appended.

> +Invert foreground and background color.

Swap foreground and background colors for the whole screen?

Benno

-- 
http://www.fastmail.fm - Email service worth paying for. Try it for free

