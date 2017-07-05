Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbdGERqB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 5 Jul 2017 13:46:01 -0400
Subject: Re: [PATCH 3/5] hwclock: final usage() strings slice
To: Karel Zak <kzak@redhat.com>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
 <40df38f4-6bf5-1959-74af-6ee481b88a12@gmx.com>
 <201707031051.27992.ruediger.meier@ga-group.nl>
 <05bbcea5-5f5a-4767-7d98-6b0a4e6575a6@gmx.com>
 <20170704075833.eqhwwhpo36s2i63d@ws.net.home>
Cc: Ruediger Meier <ruediger.meier@ga-group.nl>,
        util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <7824f55b-9494-6fad-a12f-aeff6be6dba6@gmx.com>
Date: Wed, 5 Jul 2017 13:45:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170704075833.eqhwwhpo36s2i63d@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 07/04/2017 03:58 AM, Karel Zak wrote:
> On Mon, Jul 03, 2017 at 11:35:01AM -0400, J William Piggott wrote:
>>>> To unsubscribe from this list: send the line "unsubscribe util-linux" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>
>>> What about the mentioned whitespaces for puts() to get printf
>>> on one line? 
>>>
>>>   puts(  _("     --update-drift   update the RTC drift factor"));
>>>   printf(_("     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
>>>   printf(_("     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
>>>   puts(  _("     --test           dry run; use -D to view what would have happened"));
>>>   puts(  _(" -D, --debug          use debug mode"));
>>
>> Sure, if that is what Karel wants (it can be a separate patch).
>>
>> The only thing that I don't like about that choice is that it can cause
>> puts() lines to wrap that otherwise would not. Since puts() is a lot
>> more common than printf(), it seems like putting the alignment burden on
>> printf() makes more sense.
> 
> I think the idea is to use the extra space only if you mix printf and
> puts in the same code block. We have on many place only puts (or
> fputs) -- in this case the extra space is unnecessary.

True. I meant that in mixed conditions *puts() seems more common. So if
you have a full column of *puts() and one *printf(), forcing the puts
lines to add whitespace could make many of them wrap, thus adding more
ugliness to the source than if the alignment burden is on *printf().

Again, this is an anecdotal comment only, I don't have a strong opinion
about it. For messy usage() blocks I typically toggle nowrap in my
editor; so the alignment choice is not a big deal for me.

If there aren't any other objections you could commit this set; the
alignment change qualifies for a separate commit, I think.


> 
>     Karel
> 
