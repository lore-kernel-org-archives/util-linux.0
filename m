Return-Path: elseifthen@gmx.com
Message-ID: <544A4497.3010203@gmx.com>
Date: Fri, 24 Oct 2014 08:22:47 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, Karel Zak <kzak@redhat.com>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/5] hwclock: clean up messages
References: <5449BD0F.2070906@gmx.com> <20141024110803.GB10134@x2.net.home> <1414151313.843395.182838257.3685FB42@webmail.messagingengine.com>
In-Reply-To: <1414151313.843395.182838257.3685FB42@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>



On 10/24/2014 07:48 AM, Benno Schulenberg wrote:
> 
> On Fri, Oct 24, 2014, at 13:08, Karel Zak wrote:
>> On Thu, Oct 23, 2014 at 10:44:31PM -0400, JWP wrote:
> 
> In hwclock the "debug" messages are gettextized, because in fact
> they are verbose messages to help the user understand what hwclock
> is doing.  They are not meant to find programming errors in hwclock;
> if that were the case, they wouldn't be gettextized, because a
> programmer needs to be able to read an write English anyway.

I would agree that it should have been named --verbose. However, I 
have not suggested it because of Util-linux guidelines:

>From util-linux//Documentation/howto-usage-function.txt

"The rule of thumb with other options is that once they exist, you may
not change them, nor change how they work, nor remove them."

The --debug output is useful for testing and debugging, as I have 
used it as such many times.


> 
> Benno
> 
