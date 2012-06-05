Return-Path: hpa@zytor.com
References: <20120529114518.GI1744@fi.muni.cz> <20120605114616.GB14536@x2.net.home>
In-Reply-To: <20120605114616.GB14536@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: flock(1) exit code (enhancement request)
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 05 Jun 2012 07:08:58 -0700
To: Karel Zak <kzak@redhat.com>, Jan Kasprzak <kas@fi.muni.cz>
CC: util-linux@vger.kernel.org
Message-ID: <65e0a2a4-bbb5-444e-89c4-49d97af9df9d@email.android.com>
List-ID: <util-linux.vger.kernel.org>

Well, if it maps onto sysexits.h in a sensible way that would be my first choice.

Karel Zak <kzak@redhat.com> wrote:

>On Tue, May 29, 2012 at 01:45:18PM +0200, Jan Kasprzak wrote:
>>         This problem can be solved for example by mapping the exit
>code 1
>> of the -c command to something else. I.e. to add something like
>> 
>>         -m <number>
>>         --map-exit-code-1-to <number>
>> 
>> where the exit code of flock(1) would be <number>, iff the -c
><command> exits
>> with code 1.
>
>Not sure if a generic remap for exit(1) is a good solution.
>
>> 	The alternative would be to have user-settable exit code for
>> the "conflicting lock exists" failure.
>
>Yes, It would be nice to have user-settable exit codes, for:
>
>    --rc-timeout <num>
>    --rc-conflict <num>
>
>> 	What do you think about it? If you agree with the above syntax,
>> I can of course post a patch to flock(1).
>
>Send patch.
>
>    Karel
>
>-- 
> Karel Zak  <kzak@redhat.com>
> http://karelzak.blogspot.com

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
