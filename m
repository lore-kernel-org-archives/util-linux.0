Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170404131125.vbq2ziezq3ekucyt@ws.net.home>
References: <58CAA79B.4010108@projektwerkstatt.de> <95b803a1-8288-25d6-4bbe-738348016813@projektwerkstatt.de>
 <20170404131125.vbq2ziezq3ekucyt@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 5 Apr 2017 16:30:16 +0100
Message-ID: <CAG27Bk3=R966OvHXf5vWvhM-v_2EmKc5ASs+Lc08-LL9e3D3nA@mail.gmail.com>
Subject: Re: not responding
To: Karel Zak <kzak@redhat.com>
Cc: kalle <kalle@projektwerkstatt.de>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 4 April 2017 at 14:11, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Apr 02, 2017 at 08:56:07PM +0200, kalle wrote:
>> i have util-linux version 2.20.1 , the "more"-manpage says version 5.19
>
> Well, the current version is v2.29.2 ...
>
>> of more, and found the following problems in "more":
>> I start with more FILE.
>> then "=" to get the line "57". It is to say here, that the first line of
>> the screen, will not be shown again, even if typing "b".
>> Then z ;then = again. Gives line 115.
>> b;= :line 58
>> s;= :line 116
>> b;= :line 59
>> f;= :line 173
>> b;= :line 116
>> b;= :line 59
>>
>> This result seems to contradict to man more's definitions of
>> -"s" :"skip forward k lines of text. Defaults to 1."
>> -"f" :"skip forward k screenfuls of text. Defaults to 1."
>
> Hmm... it's mess, like everything around more(1).
> Sami any comment? :-)

I started to reproduce this issue, and I got headache. I fully agree with
maintainer statement about more(1).

Secondly, to fix we need ... eh, full rewrite? Perhaps I should sent the
untestable monster pull one day. But it's a horrible thing to do when
testability is an issue. It might take years to get more corrected. Sorry
Kalle, I'm sure that is not what you wanted to hear.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
