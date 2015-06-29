Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41653 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbbF2JtP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Jun 2015 05:49:15 -0400
Date: Mon, 29 Jun 2015 11:49:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/7] pull: various small changes
Message-ID: <20150629094913.GV1992@ws.net.home>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 28, 2015 at 08:43:18PM +0100, Sami Kerola wrote:
> But deprecations can be tricky, so it would be great to hear if I
> assumptions about reset(1) and the last-deprecated are right or wrong.

 The old last(1) implementation deprecation is expected and planned,
 so it's fine and I think it's also fine to add the reset script
 between deprecated stuff.

 Applied, thanks.

>   build-sys: add minimal whitespace build directory support

 I don't like this patch. I don't think it's good idea to add warning
 about libtools limitations to the all build systems. If we really need
 such warning than it has to be in the LT_INIT.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
