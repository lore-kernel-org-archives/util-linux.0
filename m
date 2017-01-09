Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759330AbdAILll (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 9 Jan 2017 06:41:41 -0500
Date: Mon, 9 Jan 2017 12:32:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: pull: hwclock 27 changes
Message-ID: <20170109113201.kt3mmxr7fqlwscdm@ws.net.home>
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
 <alpine.LNX.2.20.1701072212010.9096@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1701072212010.9096@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 07, 2017 at 11:06:23PM +0000, Sami Kerola wrote:
> > > 
> > > 
> > > I tried to convince Karel of this long ago. This code has been broken
> > > from day one, so nobody can be using it. IMO, it should be removed now.
> > > 
> > > 
> 
> I agree. --compare is broken. I think there are couple options.
> 
> 1) remove --compare code, and mention in manual page it's gone
> 2) keep the code, but deprecate it
> 3) keep the code, and fix it (but how???)
> 4) keep the broken code and whistle happy days theme song
> 5) something else
> 
> I am 60-40 leaning towards recommending removal. If we don't remove rest 
> of my 40 goes to deprecate. Karel, I think we need maintainer advice.

I have re-read our old discussions about this topic and I agree that
it's better to kill the problematic (broken?) functionality that care
about backward compatibility. It really seems nobody uses this stuff. 

So, go ahead and send patch to remove all around --compare.

BTW, we had discussion about unmaintained adjtimex merge to
util-linux.

    Karel
   

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
