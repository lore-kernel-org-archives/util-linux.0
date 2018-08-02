Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f195.google.com ([209.85.223.195]:38145 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeHBUa3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 2 Aug 2018 16:30:29 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so2885511iog.5
        for <util-linux@vger.kernel.org>; Thu, 02 Aug 2018 11:38:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20180802085117.vwbtc7kwkcphhelv@ws.net.home>
References: <20180801212644.1652-1-kerolasa@iki.fi> <20180802085117.vwbtc7kwkcphhelv@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 2 Aug 2018 19:38:08 +0100
Message-ID: <CAG27Bk0qkNb=0K+X0aMmQBL96OWhOLL1ZZov1SSm8PUa_Mjrtw@mail.gmail.com>
Subject: Re: [PATCH] mesg: do not print 'ttyname failed' message unless
 --verbose requested
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2 August 2018 at 09:51, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Aug 01, 2018 at 10:26:44PM +0100, Sami Kerola wrote:
>> Lots of people are confused why mesg(1) is priting this message.  Usual
>> cause seems to be an uninteractive shell trying to turn running 'mesg n'
>> from a /root/.profile where command invocation is by default on debian based
>> systems.  This might be rare case when failing silently is better.
>>
>> Reference: https://www.google.com/search?q=mesg+ttyname+failed
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  term-utils/mesg.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/term-utils/mesg.c b/term-utils/mesg.c
>> index 8714ad1aa..7c4e390bb 100644
>> --- a/term-utils/mesg.c
>> +++ b/term-utils/mesg.c
>> @@ -121,8 +121,11 @@ int main(int argc, char *argv[])
>>       argc -= optind;
>>       argv += optind;
>>
>> -     if ((tty = ttyname(STDERR_FILENO)) == NULL)
>> -             err(MESG_EXIT_FAILURE, _("ttyname failed"));
>> +     if ((tty = ttyname(STDERR_FILENO)) == NULL) {
>> +             if (verbose == TRUE)
>> +                     err(MESG_EXIT_FAILURE, _("ttyname failed"));
>> +             exit(MESG_EXIT_FAILURE);
>> +     }
>
> What about:
>
> if (isatty(STDERR_FILENO)) {
>     if (verbose)
>         warnx(_("no tty"));
>     exit(MESG_EXIT_FAILURE);
> }
>
> tty = ttyname(STDERR_FILENO);
> if (!tty)
>    ... the current code ...

Hi Karel

That's probably better. I pushed that version to my remote branch
'mesg' and made pull request:

https://github.com/karelzak/util-linux/pull/675

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
