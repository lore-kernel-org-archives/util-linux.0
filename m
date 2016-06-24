Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbcFXJbp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jun 2016 05:31:45 -0400
Date: Fri, 24 Jun 2016 11:31:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/6] tests: remove utmpdump localization go-around
Message-ID: <20160624093143.wgmytikwnybb7dp3@ws.net.home>
References: <20160620204037.3292-1-kerolasa@iki.fi>
 <20160620204037.3292-6-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160620204037.3292-6-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2016 at 09:40:36PM +0100, Sami Kerola wrote:
> The utmpdump timestamps are unambiguous, so forcing locale environment is
> never needed.

and what about strptime()?

I think it's fine to keep tests robust and in well know environment.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
