Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:40130 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbbCALGQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 06:06:16 -0500
Received: by wesx3 with SMTP id x3so28127990wes.7
        for <util-linux@vger.kernel.org>; Sun, 01 Mar 2015 03:06:14 -0800 (PST)
Date: Sun, 1 Mar 2015 11:06:13 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 16/16] logger: fix -i argument parsing regression
In-Reply-To: <1424625664.3145324.230850161.4C47C348@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.03.1503011102280.822@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi> <1424616106-580-17-git-send-email-kerolasa@iki.fi> <1424625664.3145324.230850161.4C47C348@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 22 Feb 2015, Benno Schulenberg wrote:

> On Sun, Feb 22, 2015, at 15:41, Sami Kerola wrote:
> > Reviewed-by: Benno Schulenberg <benno@vertaalt.nl>
> 
> Please use my justemail address (the current one) here instead.
> The vertaalt one I use just for translations.
> 
> > +.BR \-i
> 
> s/BR/B/    (since there is just one argument)
> 
> > +.BR "\-\-id" [ = \fIid ]
> 
> s/= /=/    (to fix my own mistake)
> 
> > -	fputs(_(" -i, --id[=<id>]          log <id> (default is PID)\n"), out);
> > +	fputs(_(" -i                       log logger command PID\n"), out);
> 
> Better: "log the logger command's PID" -- there is room enough to
> avoid telegram style.

Nalime Benno,

> > +	fputs(_("     --id[=<id>]          log <id> (default is PID)\n"), out);
> 
> Better: "log the given <id>, or otherwise the PID"

Here is updated version of the change.

https://github.com/kerolasa/lelux-utiliteetit/commit/7dbe2082a9d87316d7aed7d1c8a7f94a8a80b1f0

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
