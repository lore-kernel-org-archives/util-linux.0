Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40158 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752070AbbBVRhq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Feb 2015 12:37:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A40C92060F
	for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 12:37:45 -0500 (EST)
Message-Id: <1424626666.3148362.230854957.0A7EA051@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1424616106-580-2-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-2-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 01/16] whereis: tell when mandatory option is missing
Date: Sun, 22 Feb 2015 18:37:46 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:41, Sami Kerola wrote:
>  misc-utils/whereis.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

But whereis works fine with a missing -f when some
other option is given after -B or -M or -S.  Example:

$ whereis  -B /crap  -bm  when where whereis
when:
where:
whereis: /usr/share/man/man1/whereis.1.gz

To break that with a complaint about a missing -f...
Better not.

But when there's no intervening option, then it's good
to report a missing -f -- at least, when there is more
than one argument after the -B or -M or -S.

> +	if (opt_f_missing)
> +		errx(EXIT_FAILURE, _("option -f missing"));

s/missing/is missing/

Benno

-- 
http://www.fastmail.com - Send your email first class

