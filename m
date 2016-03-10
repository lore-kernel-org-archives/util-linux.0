Return-Path: mail@bernhard-voelker.de
Subject: Re: sfdisk, stderr/stdout output order
To: Karel Zak <kzak@redhat.com>,
        =?UTF-8?Q?R=c3=bcdiger_Meier?=
 <sweet_f_a@gmx.de>
References: <201603101140.50532.sweet_f_a@gmx.de>
 <20160310111605.n2jona662wvbgymh@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <56E17FDC.6010604@bernhard-voelker.de>
Date: Thu, 10 Mar 2016 15:08:28 +0100
MIME-Version: 1.0
In-Reply-To: <20160310111605.n2jona662wvbgymh@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 03/10/2016 12:16 PM, Karel Zak wrote:
> On Thu, Mar 10, 2016 at 11:40:50AM +0100, Rüdiger Meier wrote:
>> I've found such test diffs with musl libc. Maybe it needs some fflush(3)
>> calls.
>
>   Yes, good point. I'll fix it.

I don't think you can enforce stdout/stderr to be synchronous.
Well, you can try with "stdbuf(1)", but only having coreutils >v7.5
(2009).  Why not check the output of both streams separately?

Have a nice day,
Berny
