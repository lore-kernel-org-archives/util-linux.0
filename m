Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35824 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbcDPWPs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 18:15:48 -0400
Received: by mail-wm0-f47.google.com with SMTP id a140so73581922wma.0
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 15:15:47 -0700 (PDT)
Date: Sat, 16 Apr 2016 23:15:38 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] docs: optional option arguments should be long-only
In-Reply-To: <1460837334.2005140.580799433.310551C6@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.20.1604162311380.13075@imuri>
References: <1460668650-8594-1-git-send-email-kerolasa@iki.fi> <1460707163.1560857.579528393.51AFCD05@webmail.messagingengine.com> <alpine.LNX.2.20.1604161620400.4742@imuri> <1460837334.2005140.580799433.310551C6@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 16 Apr 2016, Benno Schulenberg wrote:

> 
> On Sat, Apr 16, 2016, at 17:23, Sami Kerola wrote:
> > On Fri, 15 Apr 2016, Benno Schulenberg wrote:
> > > > +will use
> > > > +.I n
> > > > +as option argument of
> > > > +.I -n
> > > 
> > > .B n  and  .B -o
> > 
> > https://github.com/kerolasa/lelux-utiliteetit/commit/398c6547338778cec441d8a0503d0598517b87fe
> 
> You still missed the -n.  That last -n needs to be -o.
> 
> 
> /me hears Sami slap forehead.  :)

Some claimed the slap was heard all the way in Czechia.

> After a second look:
> s/while later/while the latter/
> s/.B -n/.BR -o ./
> s/option.  So/So/
> s/short form/short forms/

Thank you again Benno, here is the lates.

https://github.com/kerolasa/lelux-utiliteetit/commit/326c5c93b917a623f346155c8b3438b379d9fd60

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
