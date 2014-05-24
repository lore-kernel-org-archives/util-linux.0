Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35164 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751195AbaEXMiR (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 24 May 2014 08:38:17 -0400
Message-Id: <1400935096.17218.121085157.1650AD96@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1400929696-12548-4-git-send-email-kerolasa@iki.fi>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
 <1400929696-12548-4-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 3/4] docs: setterm.1 add options compatibility note
Date: Sat, 24 May 2014 14:38:16 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, May 24, 2014, at 13:08, Sami Kerola wrote:
> +Since version 2.25 the
> +.B setterm
> +has supported long options with two hyphens, for example

s/has supported/has support for/

> +.BR \-\-help ,
> +aside with single hyphen options, for example

s/aside with single hyphen options/
  beside the historical long options with a single hyphen/

> +In scripts it is better to use backward compatibile single hyphen rather

s/use backward /use the backward-/
s/compatibile/compatible/

> +than two hyphens.  Currently there are no plans or good reasons to

s/two hyphens/the double hyphen/

Benno

-- 
http://www.fastmail.fm - A fast, anti-spam email service.

