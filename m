Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37352 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbCPK5Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Mar 2015 06:57:16 -0400
Received: by wixw10 with SMTP id w10so39657738wix.0
        for <util-linux@vger.kernel.org>; Mon, 16 Mar 2015 03:57:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150316104954.GE28925@ws.net.home>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
	<1426424094-25451-6-git-send-email-kerolasa@iki.fi>
	<20150316104954.GE28925@ws.net.home>
Date: Mon, 16 Mar 2015 11:57:14 +0100
Message-ID: <CADk+mPCVzrJGKNmFJo4ODH7Lo0kjMyN8dBt5FOXYJOENpFWAPg@mail.gmail.com>
Subject: Re: [PATCH 5/8] logger: fix rfc5424 format crash
From: Rainer Gerhards <rgerhards@hq.adiscon.com>
To: Karel Zak <kzak@redhat.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org,
        Rainer Gerhards <rgerhards@adiscon.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

2015-03-16 11:49 GMT+01:00 Karel Zak <kzak@redhat.com>:
> On Sun, Mar 15, 2015 at 12:54:51PM +0000, Sami Kerola wrote:
>> $ logger --rfc5424=notq message
>> Segmentation fault (core dumped)
>
> Not sure if Rainer is subscribed to the list, so please keep him in CC.


I am since a couple of day (but via a gmail alias for easier filtering).

>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  misc-utils/logger.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/misc-utils/logger.c b/misc-utils/logger.c
>> index 838d225..b007377 100644
>> --- a/misc-utils/logger.c
>> +++ b/misc-utils/logger.c
>> @@ -476,7 +476,8 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
>>  #endif
>>                       xasprintf(&structured_data,
>>                                "[timeQuality tzKnown=\"1\" isSynced=\"0\"]");
>> -     }
>> +     } else
>> +             structured_data = xstrdup("");
>
> RFC5424:
>
>     STRUCTURED-DATA = NILVALUE / 1*SD-ELEMENT
>
>     NILVALUE        = "-"
>
>
> ... so I guess "" is bad idea. I'll fix it before commit.

yeah, I overlooked that case. I should really find time to work on
"make check"...

The best thing to do is use

= xstrdup(NILVALUE)

I defined NILVALUE exactly for those cases (see rest of code).

Rainer

PS: I've been silent for a couple of days because my main projects
demand attention. Will soon post more again here.

>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
