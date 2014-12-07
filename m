Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:16989 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaLGL4I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 06:56:08 -0500
Message-ID: <54844055.7030602@draigBrady.com>
Date: Sun, 07 Dec 2014 11:56:05 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 01/10] lib/mbalign: fix unsigned integer overflow [AddressSanitizer]
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>	<1417355862-16935-2-git-send-email-kerolasa@iki.fi>	<547FA265.6040806@draigBrady.com> <CAG27Bk0SOOXzB2aJC66AO2pBeicRYHAosmAsd5kdUx8W3meiCg@mail.gmail.com>
In-Reply-To: <CAG27Bk0SOOXzB2aJC66AO2pBeicRYHAosmAsd5kdUx8W3meiCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/12/14 20:14, Sami Kerola wrote:
> On 3 December 2014 at 23:53, Pádraig Brady <P@draigbrady.com> wrote:
>> On 30/11/14 13:57, Sami Kerola wrote:
>>> This error was reported 155 times.
>>>
>>> lib/mbsalign.c:322:18: runtime error: unsigned integer overflow: 0 - 1
>>> cannot be represented in type 'size_t' (aka 'unsigned long')
>>
>> What compiler and version are you using for this?
>> I don't get the error with gcc 4.9.2 with -fsanitize=undefined
>> Note the error is incorrect I think as the variable is not read
>> after the overflow.
> 
> Hi Pádraig,
> 
> Sorry it took ages to reply to a trivial question.
> 
> $ clang --version
> clang version 3.5.0 (tags/RELEASE_350/final)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> 
> I have not done sanitation runs with gcc.
> 
> The system is archlinux with testing repos enabled with daily updates,
> that should mean a lot of libraries and such are fairly recent.

Thanks for the info.
BTW I don't see it with clang 3.4.2.
This seems like a too problematic warning TBH,
as unsigned overflow is defined,
the overflow value is not used in this case,
this seems like a very common idiom.

thanks,
Pádraig.
