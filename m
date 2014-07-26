Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35302 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaGZO5C (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 10:57:02 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so7091204pde.18
        for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 07:57:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140724095556.GK26781@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
	<1406066459-4816-8-git-send-email-kerolasa@iki.fi>
	<20140724095556.GK26781@x2.net.home>
Date: Sat, 26 Jul 2014 15:57:01 +0100
Message-ID: <CAG27Bk3G+8xbjWca4OWBpX0BBxKg_UEqtSr8eaxPsHrM+MxL-Q@mail.gmail.com>
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

Comments added.

https://github.com/kerolasa/lelux-utiliteetit/commit/499505cbc97e9047afb982bc66129a94b181b16e#diff-f68064e0e43fa893a5676182f1572882R92

>> +     fputs(_("     --rfc3164         use the BSD syslog protocol\n"), out);
>
>  "use obsolete BSD syslog protocol"
>       ^^^^^^^

The BSD protocol is marked obsolete.

>> +                             parse_rfc5424(&ctl, optarg);
>
>    parse_rfc5424_flags()

The '_flags' is added to function name.

https://github.com/kerolasa/lelux-utiliteetit/commit/499505cbc97e9047afb982bc66129a94b181b16e#diff-f68064e0e43fa893a5676182f1572882R370

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
