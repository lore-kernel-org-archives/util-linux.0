Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51175 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbaKDNQ1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Nov 2014 08:16:27 -0500
Message-ID: <5458D1A2.40106@gmx.com>
Date: Tue, 04 Nov 2014 08:16:18 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>
CC: Karel Zak <kzak@redhat.com>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: improve wording and formattin of man page of
 hwclock
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net> <1414444693-16407-4-git-send-email-bensberg@justemail.net> <544EECC9.2000300@gmx.com> <1414526532.495299.184374637.2BF00A99@webmail.messagingengine.com> <20141031095142.GX10134@x2.net.home> <54566F88.4040101@gmx.com> <1415049315.2564297.186608257.366970B7@webmail.messagingengine.com>
In-Reply-To: <1415049315.2564297.186608257.366970B7@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/03/2014 04:15 PM, Benno Schulenberg wrote:

> Well, there are several problems with your (and also Karels) version
> of the text.  First, "automatically".  The word suggests to me that
> there is/was a way to do this unautomatically, that is: by the use of
> an option.  But is was never possible to make hwclock set the System
> Clock to a drift-compensated time without touching the Hardware Clock
> nor the adjtime file.  Second, "compensates time [...] to account for".
> The expression in English is " to compensate something /for/ a deviance" --
> there should be no "to account".  But the interposing of "read from the
> Hardware Clock" makes the use of this expression difficult to grasp.
> So it's better to rewrite the whole thing.  Third, a "the" is needed
> before "time".  Fourth, the "This functionality" referring to --adjust
> no longer being necessary during boot is awkward; it's second word
> can simply de dropped.

I do not disagree with you here. I did not want to be heavy handed when
editing Karel's words, because it is his project and I am new here. I only
wanted to make clear to the reader that the Hardware Clock itself was not
being altered.

> 
> So... my suggestion:
> 
> "Since v2.26 hwclock --hctosys does a better job at setting the System Clock:
> it no longer simply copies the time from the Hardware Clock to the System Clock,
> but it reads the Hardware Clock, applies a compensation for the systematic drift
> to this read time, and sets the System Clock to the resulting time.  Thus it is
> no longer necessary to run hwclock --adjust before doing hwclock --hctosys, and
> therefore hwclock can be used very early on in the boot process when the root
> filesystem is still read-only."
> 
> Any amendments?

Nope, that seems quite complete Benno!
