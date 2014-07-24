Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f52.google.com ([209.85.220.52]:51523 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758059AbaGXKbt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 24 Jul 2014 06:31:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so3631131pad.25
        for <util-linux@vger.kernel.org>; Thu, 24 Jul 2014 03:31:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140724095556.GK26781@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
	<1406066459-4816-8-git-send-email-kerolasa@iki.fi>
	<20140724095556.GK26781@x2.net.home>
Date: Thu, 24 Jul 2014 11:31:49 +0100
Message-ID: <CAG27Bk2DsRgWO4qijMXZfdCoWnOFdjZZgwO3m1XgSDLV+8sXbg@mail.gmail.com>
Subject: Re: [PATCH 07/10] logger: add rfc5424 support
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Kodiak Firesmith <ksf@sei.cmu.edu>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 July 2014 10:55, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jul 22, 2014 at 11:00:56PM +0100, Sami Kerola wrote:
>>  struct logger_ctl {
>> @@ -82,6 +85,9 @@ struct logger_ctl {
>>       int logflags;
>>       int pri;
>>       char *tag;
>> +     unsigned int    rfc5424_time:1,
>> +                     rfc5424_tq:1,
>
>  what does it mean "_tq"? It's always good idea use comments for flags
>  and struct members :-)

Thanks for review. Adding comments would indeed make the code more
understandable, I'll do that.

One of my major doubts has been is it too verbose to have the time
quality markups in messages by default? It is possible various
auditors would prefer to see time quality messages, but they are
minority. For most the time quality markups are probably strange
unnecessary looking noise. I feel it is better to be more explicit
about data by default, and allow messaging to be less verbose than
other way around. Does anyone have strong opinions, or good argument,
in behalf or against time quality markup?

>> +     fputs(_("     --rfc3164         use the BSD syslog protocol\n"), out);
>
>  "use obsolete BSD syslog protocol"
>       ^^^^^^^

Request to add 'obsolete' sounds like approval to change the default
from rfc 3164 to rfc 5424.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
