Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbaEZKLI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 06:11:08 -0400
Date: Mon, 26 May 2014 12:11:02 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
Message-ID: <20140526101102.GE2968@x2.net.home>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
 <1400929696-12548-5-git-send-email-kerolasa@iki.fi>
 <1400935458.18113.121085821.31470970@webmail.messagingengine.com>
 <CAG27Bk2CBYDtF36R-41ZAqQrpzbdqP4=TDQx3m32=hs25GyFZg@mail.gmail.com>
 <1401052223.27518.121405397.106D8440@webmail.messagingengine.com>
 <CAG27Bk2sEtwwNZPb8=ExxwhRVG0WQrd60W=MJuHaJBNXOpptoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2sEtwwNZPb8=ExxwhRVG0WQrd60W=MJuHaJBNXOpptoQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 26, 2014 at 09:42:05AM +0100, Sami Kerola wrote:
> On 25 May 2014 22:10, Benno Schulenberg <bensberg@justemail.net> wrote:
> > On Sun, May 25, 2014, at 12:58, Sami Kerola wrote:
> >> That convention should be documented. Meanwhile I hope the following
> >> is a bit closer how the manual should be.
> >>
> >> New version:
> >> https://github.com/kerolasa/lelux-utiliteetit/commit/bbc05cc2e30a6d6a3adcc7207d5549b782f03574
> >
> >> -.B force
> >> +.I force
> >
> > This and poke are literal arguments and should stay bold.
> 
> Thank you, I missed them.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/bbc05cc2e30a6d6a3adcc7207d5549b782f03574

 BTW, it would be really nice to have per feature/issue branches
 rather than only branch 2014wk20 with setterm, uuidd and rename
 changes :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
