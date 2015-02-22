Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49348 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751980AbbBVRVE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Feb 2015 12:21:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id AD5BC209FF
	for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 12:21:03 -0500 (EST)
Message-Id: <1424625664.3145324.230850161.4C47C348@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1424616106-580-17-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-17-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 16/16] logger: fix -i argument parsing regression
Date: Sun, 22 Feb 2015 18:21:04 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:41, Sami Kerola wrote:
> Reviewed-by: Benno Schulenberg <benno@vertaalt.nl>

Please use my justemail address (the current one) here instead.
The vertaalt one I use just for translations.

> +.BR \-i

s/BR/B/    (since there is just one argument)

> +.BR "\-\-id" [ = \fIid ]

s/= /=/    (to fix my own mistake)

> -	fputs(_(" -i, --id[=<id>]          log <id> (default is PID)\n"), out);
> +	fputs(_(" -i                       log logger command PID\n"), out);

Better: "log the logger command's PID" -- there is room enough to
avoid telegram style.

> +	fputs(_("     --id[=<id>]          log <id> (default is PID)\n"), out);

Better: "log the given <id>, or otherwise the PID"

Benno

-- 
http://www.fastmail.com - Access all of your messages and folders
                          wherever you are

