Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56217 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbaKBRxV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 2 Nov 2014 12:53:21 -0500
Message-ID: <54566F88.4040101@gmx.com>
Date: Sun, 02 Nov 2014 12:53:12 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@justemail.net>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: improve wording and formattin of man page of
 hwclock
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net> <1414444693-16407-4-git-send-email-bensberg@justemail.net> <544EECC9.2000300@gmx.com> <1414526532.495299.184374637.2BF00A99@webmail.messagingengine.com> <20141031095142.GX10134@x2.net.home>
In-Reply-To: <20141031095142.GX10134@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 10/31/2014 05:51 AM, Karel Zak wrote:
> On Tue, Oct 28, 2014 at 09:02:12PM +0100, Benno Schulenberg wrote:
>>
>> On Tue, Oct 28, 2014, at 02:09, JWP wrote:
>>> On 10/27/2014 05:18 PM, Benno Schulenberg wrote:
>>>>  Since v2.26
>>>>  .B hwclock
>>>>  does not update the Hardware Clock's drift factor in @ADJTIME_PATH@ by default.
>>>> -It is necessary to use \fB\-\-update-drift\fR, with \fB\-\-set\fR or
>>>> +It is necessary to use the option \fB\-\-update-drift\fR, with \fB\-\-set\fR or
>>>>  \fB\-\-systohc\fR, to force drift factor updates.
>>>
>>> The rest of the manual uses 'the --xxxx option'.
>>
>> Well, I can't explain, but in this case "the option --xxxx" is better.
>>
>>>>  Since v2.26
>>>>  .B hwclock \-\-hctosys
>>>> -automatically compensates time read from the Hardware Clock to account for
>>>> -systematic drift before using it to set the System Clock.  Therefore,
>>>> -\fB\-\-adjust\fR is no longer necessary during boot. This functionality makes
>>>> -hwclock usable early in the boot process when the root filesystem is read-only.
>>>> +automatically takes a systematic drift of the Hardware Clock into account,
>>>> +setting the System Clock to the drift-compensated time.  Therefore the option
>>>> +\fB\-\-adjust\fR is no longer necessary during boot.  This feature makes
>>>> +.B hwclock
>>>> +usable early on in the boot process when the root filesystem is read-only.
>>>
>>> "a systematic drift"? That entire phrase does not sound natural to me.
>>
>> :|
>>
>>> I think it is important to
>>> stress that *the_time_read* from the Clock is what is being compensated as this is
>>> a new behavior.
>>
>> Well, then suggest how exactly to phrase that.
> 
> I'll wait for the final patch :-)
> 
>     Karel

Karel and Benno,

I did not intent to comment further on this, because I find discourse
on human language illogical and frustrating. No doubt, that is why I
am drawn to the language of machines, but there's no escaping strings;)

I suppose it is impolite of me to leave the topic dangling though.

The first issue seems so trivial as to not justify any debate. I will
however, expand on my original comment: if there is no grammar rule to
decide a style choice, then the super-class style rule of 'be consistent'
should be applied.  I do not find 'because I say so' to be a compelling
argument.  

With regard to the second issue, I suggested 'how exactly to phrase that' 
when I edited it the first time. Unless it can be rewritten in a way that 
does not change its meaning, I feel it should remain as it is.

So there you have my opinions; I will leave the matter in both of your hands 
to make a good choice.

Will
