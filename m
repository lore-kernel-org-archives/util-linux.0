Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbcFXJUO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jun 2016 05:20:14 -0400
Date: Fri, 24 Jun 2016 11:20:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] utmpdump: use always UTC-0 timezone in textual output
Message-ID: <20160624092012.kk2ks7gbpjnlmpiu@ws.net.home>
References: <20160620204037.3292-1-kerolasa@iki.fi>
 <20160620204037.3292-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160620204037.3292-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2016 at 09:40:32PM +0100, Sami Kerola wrote:
> Converting a time structure from text format that has timezone markup is
> practically impossible.  See reference links for more information.  This
> leads to situation where multiple utmpdump(1) conversions from binary to
> text and back make timestamps to shift amount of timezone offset to UTC-0.
> 
> The easiest way to make multiple conversions to work without timeshifts is
> to always use UTC-0 timezone.  Downside of this approach is that the textual
> format is less human readable than local timestamps would be.

Makes sense, but it would be nice to have big fat note in the man
page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
