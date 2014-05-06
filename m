Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:48077
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756789AbaEFNud (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 May 2014 09:50:33 -0400
Date: Tue, 6 May 2014 09:50:31 -0400
Message-Id: <201405061350.s46DoVxC008646@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Karel Zak <kzak@redhat.com>
CC: luto@amacapital.net, util-linux@vger.kernel.org
In-reply-to: <20140506094631.GG5962@x2.net.home> (kzak@redhat.com)
Subject: Re: getting rid of "mount: only root can ..."
References: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
 <201405022221.s42MLpT4015462@hobgoblin.ariadne.com>
 <CALCETrUU6ziKYA3RSb_6nEW4HyeR5BLGQ_3SgcnnnLnBX1us0g@mail.gmail.com>
 <201405052250.s45Monxm008110@hobgoblin.ariadne.com>
 <CALCETrXTJpkA-EqzS=kvSfS4QEO5Gc3TV42+FFrUbQN3ALfuCw@mail.gmail.com> <20140506094631.GG5962@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Karel Zak <kzak@redhat.com>

> I'll try to improve it to make it more usable with user namespaces.
> The problem is that mount(8) is not just about mount(2) call only. If
> we drop privileges then mount(8) will report problems with things like
> FS detection, loopdevs setups, etc. It's necessary to review the code
> and make errors/warnings somehow usable. ... added to my TODO for the
> next week ;-)

Yeah, that's the only thing that will work well:  Have mount(8) and
the kernel both know what the rules are and enforce them
consistently.  And ideally, mount(8) should tell the user exactly what
the rule is that's being violated.

Dale
