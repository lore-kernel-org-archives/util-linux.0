Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbbBLNVO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Feb 2015 08:21:14 -0500
Date: Thu, 12 Feb 2015 14:21:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150212132110.GE32318@ws.net.home>
References: <54DC762E.2090404@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54DC762E.2090404@earthlink.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 12, 2015 at 04:45:18AM -0500, Felix Miata wrote:
> With util-linux >= 2.25 we can turn colors off via
> 
> 	# touch /etc/terminal-colors.d/disable [3]
> 
> for some commands, but far too few. It should apply to all, including many
> outside the purview of util-linux, and more importantly, do so by default.

This is never ending story and there is no setting which works for
everyone. All I want to provide tools to make it possible to support
various use-cases. It's downstream (distors) job to provide knobs to
switch between the use-cases (profiles).

For example I can imagine packages 
   fedora-terminal-colors-{high-contrast,disable,...}.rpm
to setup coreutils, util-linux, gcc, ... whatever.

> It should be up to those who wish a legibility reduction to discover how to
> and apply the reduction, not the other way around as it is now. It is much
> more difficult for those who cannot handle low contrast to improve it than
> for those who find it too high to reduce it, a variation on the chicken/egg
> paradigm.

We can also add --{disable,enable}-colors-by-default to move the
decision to downstream and use default according the current
terminal-colors.d setting. Your default will be disable, my enabled.

For example for fedora I will keep the colors enabled, because it's
current distribution policy.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
