Return-Path: bensberg@justemail.net
Message-Id: <1426434447.3228874.240611693.0EF4BF24@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 4/5] hwclock: add '11 minute mode' information
Date: Sun, 15 Mar 2015 16:47:27 +0100
In-Reply-To: <550338F2.2000908@gmx.com>
References: <5503364E.6010302@gmx.com> <550338F2.2000908@gmx.com>
List-ID: <util-linux.vger.kernel.org>


On Fri, Mar 13, 2015, at 20:22, J William Piggott wrote:
> +If the kernel is compiled with the \%'11\ minute\ mode' option it will
> +be active when the kernel's clock discipline is in a synchronized state.
> +When in this state the binary 64's bit of the kernel's [...]

s/state the/state, the/

This comma really is needed, because without it I start to read
the sentence as "When in this state the binary... explodes, you
are in deep shit."

About the "binary 64's bit"...  As explained in our private conversation,
I think this is an absurd and incomprehensible way of referring to bit 6
(with the least-significant bit being bit 0) of a value.  Please think of
something else.

> +.I \%time_status
> +variable is unset (10111111).

Ow.  That is puzzling.  As if all the other bits have to be set in
order for bit 6 to be unset.  I would instead say something like:

"When in this state, bit 6 (the bit that is set in the mask 0x0040)
of the kernel's time_status variable is *unset*."

> +It can be turned off by running anything, including
>  .BR \%hwclock\ \-\-hctosys ,
>  that sets the System Clock the old fashioned way.

I would move the "including..." phrase to the end of the sentence,
as now one at first thinks that really *anything* can turn 11-minute
mode off.

Benno

-- 
http://www.fastmail.com - Email service worth paying for. Try it for free
