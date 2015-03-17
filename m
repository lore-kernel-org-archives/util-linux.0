Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37052 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932589AbbCQJ5r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 05:57:47 -0400
Date: Tue, 17 Mar 2015 10:57:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: J William Piggott <elseifthen@gmx.com>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/5] hwclock: add '11 minute mode' information
Message-ID: <20150317095745.GT28925@ws.net.home>
References: <5503364E.6010302@gmx.com>
 <550338F2.2000908@gmx.com>
 <1426434447.3228874.240611693.0EF4BF24@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426434447.3228874.240611693.0EF4BF24@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 04:47:27PM +0100, Benno Schulenberg wrote:
> "When in this state, bit 6 (the bit that is set in the mask 0x0040)
> of the kernel's time_status variable is *unset*."

Yes, this is more readable (at least for me:-).

> > +It can be turned off by running anything, including
> >  .BR \%hwclock\ \-\-hctosys ,
> >  that sets the System Clock the old fashioned way.
> 
> I would move the "including..." phrase to the end of the sentence,
> as now one at first thinks that really *anything* can turn 11-minute
> mode off.

I have applied this two changes.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
