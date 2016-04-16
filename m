Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36609 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbcDPPXi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 11:23:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id l6so13158759wml.3
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 08:23:37 -0700 (PDT)
Date: Sat, 16 Apr 2016 16:23:29 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] docs: optinal option arguments should be long-only
In-Reply-To: <1460707163.1560857.579528393.51AFCD05@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.20.1604161620400.4742@imuri>
References: <1460668650-8594-1-git-send-email-kerolasa@iki.fi> <1460707163.1560857.579528393.51AFCD05@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 15 Apr 2016, Benno Schulenberg wrote:

> 
> On Thu, Apr 14, 2016, at 23:17, Sami Kerola wrote:
> > +.I \-n
> > +and optional option
> > +.IR \-o .
> 
> Those need to be .B and .BR -- they are literal arguments.
> 
> > +One will expect
> > +.BI command \ \-no
> > +and
> > +.BI command \ \-on
> 
> Both just .B.
> 
> > +to be the same, but in fact the former is two separate options while later
> > +will use
> > +.I n
> > +as option argument of
> > +.I -n
> 
> .B n  and  .B -o

Thank you for review Benno. Fixes you asked are available in the git 
repository at:

git://github.com/kerolasa/lelux-utiliteetit.git 2016wk15

https://github.com/kerolasa/lelux-utiliteetit/commit/398c6547338778cec441d8a0503d0598517b87fe

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
