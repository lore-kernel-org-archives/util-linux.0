Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:49822 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760258Ab3EAAyh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 30 Apr 2013 20:54:37 -0400
Message-ID: <518067CA.2090804@draigBrady.com>
Date: Wed, 01 May 2013 01:54:34 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: Sami Kerola <kerolasa@iki.fi>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 10/11] cal: trim three month display trailing white spaces
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi> <1367169067-23705-11-git-send-email-kerolasa@iki.fi> <517DBF96.3040409@draigBrady.com> <CAG27Bk0J_a+avhcHa9TAfbdTj0EL6BeQOY8HshovA=jV75AJeg@mail.gmail.com> <517E7860.1060604@draigBrady.com> <CAG27Bk3YqnYo_FSAo9gQuesF6K2jZ-LCzfhv2Oz7TkPqx97sZg@mail.gmail.com>
In-Reply-To: <CAG27Bk3YqnYo_FSAo9gQuesF6K2jZ-LCzfhv2Oz7TkPqx97sZg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/29/2013 07:01 PM, Sami Kerola wrote:
> On 29 April 2013 14:40, Pádraig Brady <P@draigbrady.com> wrote:
>> On 04/29/2013 10:11 AM, Sami Kerola wrote:
>>> On 29 April 2013 01:32, Pádraig Brady <P@draigbrady.com> wrote:
>>>> On 04/28/2013 06:11 PM, Sami Kerola wrote:
>>>>> Includes fix to checks that conform earlier output practise.
>>>>
>>>> I'm not sure about this.
>>>> Other output modes have trailing whitespace.
>>>> Also consider the case where you're outputting to a <pre> in a web page,
>>>> where the pre has a different bg color to the web page.
>>>> You'd want the full width output in that case.
>>>
>>> I did not realize someone might be doing that.  The reason why I wrote
>>> the change is to be consistent with month and year print out, which
>>> are already trimming spaces.
>>
>> I don't see month/year here with trimmed spaces?
>>
>> $ cal -1 | head -n1 | tr ' ' .
>> .....April.2013.....
>>
>> $ cal -y | head -n3 | tr ' ' .
>> ...............................2013...............................
>>
>> .......January...............February.................March.......
>>
>> I do see that spaces are trimmed from the last day in -1 and -y formats.
>> So I suppose it's best to be consistent and trail space there.
>> I suppose one could also not trim spaces for -1 and -y there?
> 
> Headers are using mbsalign() function to align center, which also does
> printing. That printing is not filtered through trim_trailing_spaces()
> like the calendar's numeric output.

As an aside, the "upstream" for mbsalign() in coreutils
has been updated to support MBA_NO_RIGHT_PAD.  If we were to change
that behaviour, we would probably sync up first.
http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=6cf9c59b

> 
>>> Perhaps there should be
>>> '--trim=[yes|no|auto]', where the 'auto' would be the current
>>> practice, and default.
>>
>> I don't think it needs an option TBH as removing trailing
>> spaces is trivial with: sed 's/ *$//'
>> Padding out with spaces is not trivial though,
>> which is another reason to err on the side of
>> leaving the trailing spaces.
> 
> True. Perhaps dropping the trimming all together is correct thing to
> do. The following demonstrates what not trimming would mean for code
> and tests.

+1

thanks,
Pádraig.

