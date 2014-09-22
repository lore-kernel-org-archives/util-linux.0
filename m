Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f53.google.com ([209.85.220.53]:49271 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbaIVMC0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Sep 2014 08:02:26 -0400
Received: by mail-pa0-f53.google.com with SMTP id hz1so4329419pad.26
        for <util-linux@vger.kernel.org>; Mon, 22 Sep 2014 05:02:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAP0zEAbucyO55YyAhbUkcEB-+R8GQ1qv+XAdQYzp-bo2xB2wjQ@mail.gmail.com>
References: <karelzak/util-linux/pull/117@github.com>
	<karelzak/util-linux/pull/117/c55868722@github.com>
	<CAP0zEAb8y+P-McdLc23dJyqG3_=mFQw9PEmkaLLbzGzmWL7p-A@mail.gmail.com>
	<CAP0zEAZhyOqM-VmBkGEA4sN2wC+YycOtP8h6AxytjTDXsw1K4A@mail.gmail.com>
	<20140917131848.GA5366@x2.net.home>
	<CAP0zEAZ9aMs-ky5ivweJoytTn7MvGcq0qyyDnFkk-5iMWRHz0w@mail.gmail.com>
	<20140922113327.GI5366@x2.net.home>
	<CAP0zEAbucyO55YyAhbUkcEB-+R8GQ1qv+XAdQYzp-bo2xB2wjQ@mail.gmail.com>
Date: Mon, 22 Sep 2014 13:02:25 +0100
Message-ID: <CAG27Bk0XXisYj9=d=RHtHSELc21=JVfyEzqSaTEwTqtLNv+szw@mail.gmail.com>
Subject: Re: Fwd: [util-linux] cal: add landscape layout for yearly views (#117)
From: Sami Kerola <kerolasa@iki.fi>
To: Gennady Kovshenin <gennady@kovshenin.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> On Mon, Sep 22, 2014 at 5:33 PM, Karel Zak <kzak@redhat.com> wrote:
>> On Wed, Sep 17, 2014 at 09:52:36PM +0600, Gennady Kovshenin wrote:
>>> I like the format=auto idea. But we can keep it to just the number of
>>> columns instead of a full CxR format.
>>
>>  It would be the best to talk about number of months ;-)
>>
>>> i.e. format=2 (2x6), format=3 (3x4), format=4 (4x3), and so on.
>>> perhaps the parameter should be called --columns/-c instead of format.
>>> We can either have an additional auto value to the format, or have it
>>> be on by default.
>>> Having auto on by default means breaking compatibility. Some users
>>> might be parsing output expecting the default 3x4 view in place and if
>>> we abruptly change this to be stretched automatically their scripts
>>> might break.
>>>
>>> Any thoughts on the above? --format vs. --columns? And the default
>>> value thereof.
>>
>> Or something else --horizontal-months[=<num>|auto]
>>
>> and think we can support arbitrary <num> in range 1-12.
>>
>>     Karel

On 22 September 2014 12:38, Gennady Kovshenin <gennady@kovshenin.com> wrote:

> Agreed. And the default would still be 3, right? For back compatibility.
>
> What's the short version of the flag -z?

Mind the fact the cal is part of posix, so adding short options may
cause (theoretically) necessity to be either backwards incompatible or
break the standard.

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cal.html

> And would the auto mode try to still limit itself to a rectangle? Or
> stretch indefinitely?

IMHO rectangles are fine if the they are requested with an option
something like

--geometry=x:y

But if the number of months is wanted to be

--begin=<date>
--end=<date>

Then the default geometry 3xN should be applied, unless otherwise
defined by user.

When --geometry=5:3 is defined and --begin && --end define a period of
a year (for example), then the last three 'month' entries should be
blanks.

Would that make sense?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
