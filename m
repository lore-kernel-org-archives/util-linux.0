Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbdHUJUu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Aug 2017 05:20:50 -0400
Date: Mon, 21 Aug 2017 11:20:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] isosize: iterate over all arguments even when something
 fails
Message-ID: <20170821092046.khbqoc6zmky7wh5m@ws.net.home>
References: <20170812083208.1208-1-kerolasa@iki.fi>
 <20170814090821.qxqr4ill4ihtjlyc@ws.net.home>
 <alpine.LNX.2.20.1708151913490.1230@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1708151913490.1230@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 15, 2017 at 07:23:39PM +0100, Sami Kerola wrote:
> On Mon, 14 Aug 2017, Karel Zak wrote:
> > Seems like overkill, why we need so specific information? I guess it
> > would be enough
> > 
> >     0 - EXIT_SUCCESS
> >     1 - EXIT_FAILURE
> >    64 - EXIT_SOMEOK  (already used for mount, lsblk, kill, ...)
> 
> I kept small overkill and used two different return values: 64 for some 
> ok, and 32 all failed.

OK, I have merged a little different way how to implement it.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
