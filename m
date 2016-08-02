Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45952 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967152AbcHBOHu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 10:07:50 -0400
Date: Tue, 2 Aug 2016 16:07:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] chfn: stop adding trailing commas to gecos
Message-ID: <20160802140743.xf45rlx755ec7zpz@ws.net.home>
References: <20160726180602.4914-1-kerolasa@iki.fi>
 <20160726180602.4914-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160726180602.4914-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 26, 2016 at 07:06:02PM +0100, Sami Kerola wrote:
> The other field should not appear automatically, it causes not-automatically
> trimmed trailing commas to appear in gecos.

Hmmm.. I'm really not sure if this is a good idea. I'm almost sure
that somewhere in our universe is a program or a custom script that
parses GECOS and expects fixed number of commas.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
