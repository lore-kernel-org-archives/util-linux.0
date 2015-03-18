Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50858 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbbCRJnN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Mar 2015 05:43:13 -0400
Date: Wed, 18 Mar 2015 10:43:07 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/5] hwclock: add '11 minute mode' information
Message-ID: <20150318094307.GZ28925@ws.net.home>
References: <5503364E.6010302@gmx.com>
 <550338F2.2000908@gmx.com>
 <1426434447.3228874.240611693.0EF4BF24@webmail.messagingengine.com>
 <20150317095745.GT28925@ws.net.home>
 <5508D1E0.205@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5508D1E0.205@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 17, 2015 at 09:16:16PM -0400, J William Piggott wrote:
> 
> 
> On 03/17/2015 05:57 AM, Karel Zak wrote:
> > On Sun, Mar 15, 2015 at 04:47:27PM +0100, Benno Schulenberg wrote:
> >> "When in this state, bit 6 (the bit that is set in the mask 0x0040)
> >> of the kernel's time_status variable is *unset*."
> > 
> > Yes, this is more readable (at least for me:-).
> 
> I explained to Mr Schulenbuerg that I wrote it that way for layman users. 
> Are they going to understand 'the bit that is set in the mask 0x0040'?

I have doubts it will be readable for layman users at all
independently on used words :-) Now it's at least readable for
advanced users. If you want to make it really readable for layman
users than add and example to the man page.

> What does that even mean? What does 'mask' have to do with it? It could
> simply say "the bit that is set by binary 0x0040"
> How does that differ from saying the binary 64's bit?
> 
> Using hex will help the average user how?
> 
> I used decimal because adjtimex displays the status variable as a decimal
> number:
> 
> adjtimex -p
> status: 8193
> 
> adjtimex -p
> status: 8257
> 
> Which one is synchronized?

$ echo $((8193 & 0x0040))
0

$ echo $((8257 & 0x0040))
64

and frankly it's adjtimex mistake that it does not provide the
information in more human readable way. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
