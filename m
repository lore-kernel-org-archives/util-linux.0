Return-Path: util-linux-owner@vger.kernel.org
Received: from mail1.vodafone.ie ([213.233.128.43]:50024 "EHLO
	mail1.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbbBLLOP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 Feb 2015 06:14:15 -0500
Message-ID: <54DC88BF.5040702@draigBrady.com>
Date: Thu, 12 Feb 2015 11:04:31 +0000
From: =?windows-1252?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Felix Miata <mrmazda@earthlink.net>, util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
References: <54DC762E.2090404@earthlink.net>
In-Reply-To: <54DC762E.2090404@earthlink.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/02/15 09:45, Felix Miata wrote:
> Red, blue and green in particular produce poor contrast on the black
> background of a typical framebuffer screen.

Agreed, though the bold variants are better.
Better again are 256 color variants.
The Linux console lagged xterms in support, but does support it now.

> As these screens are configured
> as functional twins of those modes we find ourselves in at rescue time, it
> amounts to an unfortunate and unnecessary accessibility/usability obstacle
> that is IMO is a subset of a larger general problem found under the moniker
> A11Y[1].
> 
> A very good, very recent article discusses the mindset that leads to default
> settings that thwart use by the disadvantaged[2], however slight that
> impediment may be.

I agree completely. color is useful but one has to be very careful
in how it's used. ls --color for example is too aggressive IMHO,
and I adjust to highlight rather than color with:
  http://www.pixelbeat.org/scripts/l
I've been pusing back upstream against adding new color combinations.

> With util-linux >= 2.25 we can turn colors off via
> 
> 	# touch /etc/terminal-colors.d/disable [3]
> 
> for some commands, but far too few. It should apply to all, including many
> outside the purview of util-linux, and more importantly, do so by default.

coreutils will keep this scheme in mind too.

thanks,
Pádraig.

