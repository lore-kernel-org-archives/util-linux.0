Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:41498 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755450AbbBLJpW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Feb 2015 04:45:22 -0500
Message-ID: <54DC762E.2090404@earthlink.net>
Date: Thu, 12 Feb 2015 04:45:18 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: tty[1-6]: colors a negative accessibility/usability trend
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Red, blue and green in particular produce poor contrast on the black
background of a typical framebuffer screen. As these screens are configured
as functional twins of those modes we find outselves in at rescue time, it
amounts to an unfortunate and unnecessary accessibility/usability obstacle
that is IMO is a subset of a larger general problem found under the moniker
A11Y[1].

A very good, very recent article discusses the mindset that leads to default
settings that thwart use by the disadvantaged[2], however slight that
impediment may be.

With util-linux >= 2.25 we can turn colors off via

	# touch /etc/terminal-colors.d/disable [3]

for some commands, but far too few. It should apply to all, including many
outside the purview of util-linux, and more importantly, do so by default.

It should be up to those who wish a legibility reduction to discover how to
and apply the reduction, not the other way around as it is now. It is much
more difficult for those who cannot handle low contrast to improve it than
for those who find it too high to reduce it, a variation on the chicken/egg
paradigm.

If we can get all components of util-linux to adhere to maximizing
legibility, it would have the potential serve as an important springboard for
other projects to do the same, and maybe even spill onto the web.

[1] http://a11yproject.com/
[2] http://alistapart.com/article/reframing-accessibility-for-the-web
[3] http://karelzak.blogspot.de/2014/04/terminal-colorsd.html
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
