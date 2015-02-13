Return-Path: bruce.dubbs@gmail.com
Message-ID: <54DE3AAE.2010906@gmail.com>
Date: Fri, 13 Feb 2015 11:55:58 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, "Dale R. Worley"
 <worley@alum.mit.edu>
CC: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>, mrmazda@earthlink.net,
        util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
References: <54DC88BF.5040702@draigBrady.com> <87h9uqv6lv.fsf@hobgoblin.ariadne.com> <20150213092131.GM32318@ws.net.home>
In-Reply-To: <20150213092131.GM32318@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Feb 12, 2015 at 10:21:48PM -0500, Dale R. Worley wrote:
>> I don't particularly like colorization.  But technically, it seems to me
>> that what is needed is a systematic way for the user to indicate his
>> colorization preferences to *all* utilities.  And a corresponding way
>> for the system to provide defaults for those user preferences.
>>
>>
>> Only when there is a systematic framework for colorization will all the
>> programs allow colorizing to be configured.
>
> It would be possible to create a shared library from our lib/colors.c
> to support terminal-colors.d/... :-)

Why not use the LS_COLORS environment variable used by coreutils' dircolors? 
Does util-linux need to create something different?

   -- Bruce
