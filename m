Return-Path: util-linux-owner@vger.kernel.org
Received: from mta-out1.inet.fi ([62.71.2.194]:40868 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126AbaJXWEG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 18:04:06 -0400
Received: from [192.168.0.11] (80.222.42.135) by kirsi1.inet.fi (8.5.142.08)
        id 54252736027A30A3 for util-linux@vger.kernel.org; Sat, 25 Oct 2014 00:58:11 +0300
Message-ID: <544ACB36.6050906@iki.fi>
Date: Sat, 25 Oct 2014 00:57:10 +0300
From: Lauri Nurmi <lanurmi@iki.fi>
MIME-Version: 1.0
To: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] hwclock: clean up message periods/full stops
References: <5449BE57.9040203@gmx.com> <1414150431.840372.182833341.74402120@webmail.messagingengine.com> <544A4817.3070406@gmx.com>
In-Reply-To: <544A4817.3070406@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

24.10.2014, 15:37, JWP kirjoitti:
> On 10/24/2014 07:33 AM, Benno Schulenberg wrote:
>> On Fri, Oct 24, 2014, at 04:49, JWP wrote:
>>> This is unsightly and difficult to read.
>> Ehm...  I would think the lack of periods would make things
>> more difficult to read.
> Agreed. However, having 2/3 of the messages without and 1/3 with
> makes no sense at all.

Of course it makes sense e.g. if 1/3 of the messages are sentences and 
2/3 are not.

>>> -		      ("The value of the --date option is not a valid date.\n"
>>> -		       "In particular, it contains quotation marks."));
>>> +		      ("The value of the --date option is not a valid date\n"
>>> +		       "In particular, it contains quotation marks"));
>> This is ugly.  Two lines of text and it's unclear that the first
>> sentence ends at the end of the line.  If you absolutely want
>> to get rid of the period, put a semicolon after "valid date" and
>> lowercase "in particular".
> That would not make sense to me.  Either we use punctuation or we don't.

"We use punctuation where appropriate" is not an option? If you feel 
that way, maybe it would be better not to touch the messages.

> I am no grammar expert, but if two sentences was originally correct then
> it should still be correct.

A sentence ends in a period. You removed the period. Now they are 
sentences missing a period.

>
>> All just cosmetic changes, invalidating all the translations.
>> Not nice.
> My sincere oligopolies to translators, but hwclock is slated for refactoring
> and I expect many message changes will be included.

Then it is completely unnecessary and silly to introduce this kind of 
nonsensical changes at this point. It leads to translators needing to 
update the translations not only once, but twice.


BR,
(Mr) Lauri Nurmi
a translator

