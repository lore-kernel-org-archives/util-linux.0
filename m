Return-Path: elseifthen@gmx.com
Message-ID: <544A4817.3070406@gmx.com>
Date: Fri, 24 Oct 2014 08:37:43 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>
CC: Karel Zak <kzak@redhat.com>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] hwclock: clean up message periods/full stops
References: <5449BE57.9040203@gmx.com> <1414150431.840372.182833341.74402120@webmail.messagingengine.com>
In-Reply-To: <1414150431.840372.182833341.74402120@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>



On 10/24/2014 07:33 AM, Benno Schulenberg wrote:
> 
> On Fri, Oct 24, 2014, at 04:49, JWP wrote:
>> 33% of message lines terminated with a period/full stop.
> 
> You mean 33% of hwclock messages, or 33% of util-linux messages?

hwclock

> 
>> This is unsightly and difficult to read.
> 
> Ehm...  I would think the lack of periods would make things
> more difficult to read.

Agreed. However, having 2/3 of the messages without and 1/3 with
makes no sense at all.  I am happy to use whatever the project
chooses. Looking at existing hwclock code, boilerplate.c and 
howto-usage-function.txt it would appear that not using periods
is the current standard?

> 
>> -		      ("The value of the --date option is not a valid date.\n"
>> -		       "In particular, it contains quotation marks."));
>> +		      ("The value of the --date option is not a valid date\n"
>> +		       "In particular, it contains quotation marks"));
> 
> This is ugly.  Two lines of text and it's unclear that the first
> sentence ends at the end of the line.  If you absolutely want
> to get rid of the period, put a semicolon after "valid date" and
> lowercase "in particular".

That would not make sense to me.  Either we use punctuation or we don't.
I am no grammar expert, but if two sentences was originally correct then
it should still be correct.

> 
> [...]
> 
> All just cosmetic changes, invalidating all the translations.
> Not nice.

My sincere oligopolies to translators, but hwclock is slated for refactoring
and I expect many message changes will be included.  Hopefully, the changes
will include improving things for translators.



> 
> Benno
> 
