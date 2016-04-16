Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54253 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751508AbcDPUI4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 16 Apr 2016 16:08:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 0B61920B3C
	for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 16:08:55 -0400 (EDT)
Message-Id: <1460837334.2005140.580799433.310551C6@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <alpine.LNX.2.20.1604161620400.4742@imuri>
References: <1460668650-8594-1-git-send-email-kerolasa@iki.fi>
 <1460707163.1560857.579528393.51AFCD05@webmail.messagingengine.com>
 <alpine.LNX.2.20.1604161620400.4742@imuri>
Subject: Re: [PATCH] docs: optional option arguments should be long-only
Date: Sat, 16 Apr 2016 22:08:54 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, Apr 16, 2016, at 17:23, Sami Kerola wrote:
> On Fri, 15 Apr 2016, Benno Schulenberg wrote:
> > > +will use
> > > +.I n
> > > +as option argument of
> > > +.I -n
> > 
> > .B n  and  .B -o
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/398c6547338778cec441d8a0503d0598517b87fe

You still missed the -n.  That last -n needs to be -o.


/me hears Sami slap forehead.  :)


After a second look:
s/while later/while the latter/
s/.B -n/.BR -o ./
s/option.  So/So/
s/short form/short forms/

Benno

-- 
http://www.fastmail.com - Same, same, but different...

