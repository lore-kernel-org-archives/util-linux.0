Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:38982 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaGIUtI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 16:49:08 -0400
Received: by mail-we0-f179.google.com with SMTP id w62so8014024wes.38
        for <util-linux@vger.kernel.org>; Wed, 09 Jul 2014 13:49:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: Re: small problem with kill --queue
Date: Wed,  9 Jul 2014 21:49:02 +0100
Message-Id: <1404938943-2543-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1404912546.1512.139736225.71C7CA63@webmail.messagingengine.com>
References: <1404765295.16902.139036593.3B689FEB@webmail.messagingengine.com> <CAG27Bk3niwrfc1oW9DfSvxZ2tV3Y=ZXEi1Wb+61AXOBYS_jmWw@mail.gmail.com> <1404912546.1512.139736225.71C7CA63@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 9 July 2014 14:29, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Tue, Jul 8, 2014, at 00:39, Sami Kerola wrote:
>> Right. I am not sure did I mess up or someone else earlier when
>> --queue was introduced.
>
> It looks like you made the mistaken change four months ago,
> in commit 9e8dffd5cd29f03029b1ac99eecb129532ca5c0f.

Yep. Another bug I created. Oops & sorry.

>> Which way ever that was now when I look
>> sigqueue(3) manual page your change proposal makes sense. Please have
>> a look of the change below, that I hope to get reviewed before the
>> final v2.25 is out. [...]
>>
>> +The
>> +.B \-\-queue
>> +should be combined with
>> +.BI \-\-signal " signal"
>> +when other than a SIGTERM is wanted to accompanied with
>> +.IR sigval .
>
> I don't think it's necessary to explain again that wanting to send any
> other signal than TERM requires the --signal option; this is already at
> the top of the page.
>
> Also, thinking again, this word "sigval" looks far too similar to "signal",
> it would be much clearer to use the plain word "value" instead.  So my
> upcoming patches for the usage text and man page use that instead.

I tried to think possible person who is trying to write program(s) that
would use the kill --queue mechanism.  Maybe it is good enoug for such
persons to find this email conversation from web archive, with remark the
--queue <value> is the same value as in

sigaction(3p) SA_SIGINFO void func(int signo, siginfo_t *info, void *context);

the 'si_value' value in 'siginfo_t' struture,  and in sigqueue(3)

int sigqueue(pid_t pid, int sig, const union sigval value);

the 'int sival_int' in 'union sigval'.

That said, the following patch looks good to me.

[PATCH 2/2] docs: fix many wording and some formatting issues in the man page of kill

>> + ctl->sigdata.sival_int = strtos32_or_err(arg, _("argument error"));
>
> Maybe "argument of --queue must be an integer" instead?
>
> My patch to kill.c also improves the error message when the
> signal name or number cannot be interpreted.  Currently:
>
> ./kill --sigmal HUP foobar
> kill: invalid sigval argument
>
> Huh?
>
> New:
>
> ./kill --sigmal HUP foobar
> kill: invalid signal name or number: -sigmal

You took care of this already.

[PATCH 1/2] textual: fix the usage message of kill

Incoming change from me[*] is intented to be applied on top of the
textual fix.

[*] [PATCH] kill: use --queue option argument as sigval integer value

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
