Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbdHUJUE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Aug 2017 05:20:04 -0400
Date: Mon, 21 Aug 2017 11:20:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] look: use WORDLIST environment variable to find word list
Message-ID: <20170821092000.q3vyxgosrcbqivwx@ws.net.home>
References: <20170812083208.1208-1-kerolasa@iki.fi>
 <20170812083208.1208-2-kerolasa@iki.fi>
 <20170814091257.rq7kqgoi4vsqo2rb@ws.net.home>
 <alpine.LNX.2.20.1708151911190.1230@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1708151911190.1230@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 15, 2017 at 07:13:34PM +0100, Sami Kerola wrote:
> On Mon, 14 Aug 2017, Karel Zak wrote:
> 
> > Would be better fallback to _PATH_WORDS if WORDLIST= points to
> > nowhere?
> > 
> >     file = _PATH_WORDS; /* default */
> >     if ((x = getenv("WORDLIST")) && access(file, R_OK) == 0)
> >         file = x;
> > 
> > seems like more backwardly compatible way.
> 
> No problems, change is updated much like proposed above.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/dd8be07d84988b130286a1194210bdb26b223736
> 
> That is in branch: 2017wk32

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
