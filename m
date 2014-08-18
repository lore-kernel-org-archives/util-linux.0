Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:52736
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372AbaHRPX6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Aug 2014 11:23:58 -0400
Date: Mon, 18 Aug 2014 10:47:20 -0400
Message-Id: <201408181447.s7IElKIT020343@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Linda Walsh <lkml@tlinx.org>
CC: util-linux@vger.kernel.org
In-reply-to: <53F15592.9020403@tlinx.org> (lkml@tlinx.org)
Subject: Re: Utilities don't take into account capabilities
References: <fbcec6cf5352.53efd3e4@langara.bc.ca> <53F11687.5060805@tlinx.org> <fb20984219ad.53f14f7a@langara.bc.ca> <53F15592.9020403@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Linda Walsh <lkml@tlinx.org>
> 
> Steven Stewart-Gallus wrote:
> >> Seriously... What capabilities does mount need in order to function?
> >>     
> >
> > I can help out with this one.
> >   
> ----
> awesome... but, um... was hoping the author of mount could
> tell me what caps I needed to enable to use his program
> w/a non-root user... ;-)... oh well... um...now as to when we
> can get a version that doesn't check for UID & EUID==0?
> 
> well... maybe in the works?

I believe there's a complication...  I'm no expert, but I vaguely
recall from some previous thread that there are situations where
'mount' isn't purely a front-end for the kernel mount() call.
Instead, 'mount' wants to set up some things and then call mount().

The example that comes to mind is setting up a file on a loopback
device, then mounting the loopback device.  But I think there were
other situations like this.

The problem being, that 'mount' wants to verify that the mount() call
will succeed *first* before attempting the set-up operations.  And
some of the setup operations require root capabilities.

There's also the complication of the "users" and "user=" options,
which are to permit a user to do something he doesn't actually have
the capabilities for.

Dale
