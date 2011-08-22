Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23392 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab1HVIcJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Aug 2011 04:32:09 -0400
Date: Mon, 22 Aug 2011 10:32:06 +0200
From: Karel Zak <kzak@redhat.com>
To: giulioo@pobox.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sfdisk: make some tests conditional to !Linux
Message-ID: <20110822083206.GA20457@nb.net.home>
References: <20110818073019.B70AFF815@i3.golden.dom>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110818073019.B70AFF815@i3.golden.dom>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 18, 2011 at 09:30:30AM +0200, Giulio wrote:
> +	    if (!chs_ok(b, PNO(p), _("start")) && !Linux)
[...]
> +	    if (!chs_ok(b, PNO(p), _("end")) && !Linux)

would be better to use

    if (!Linux && chs_ok(b, PNO(p), ....)

so the chs_ok() will not called on Linux at all?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
