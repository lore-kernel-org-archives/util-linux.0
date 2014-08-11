Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:56238 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbaHKUeD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Aug 2014 16:34:03 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so11674877pab.20
        for <util-linux@vger.kernel.org>; Mon, 11 Aug 2014 13:34:03 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140811131201.GK17719@x2.net.home>
References: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
	<1407671771-29745-4-git-send-email-kerolasa@iki.fi>
	<20140811131201.GK17719@x2.net.home>
Date: Mon, 11 Aug 2014 21:34:02 +0100
Message-ID: <CAG27Bk0EYBdEZWBVW18qgzuUkvUdO3BH7Re2GTvw2p7BGHG_rw@mail.gmail.com>
Subject: Re: [PATCH 3/5] logger: optimize string initializations
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11 August 2014 14:12, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Aug 10, 2014 at 12:56:09PM +0100, Sami Kerola wrote:
>> -     char pid[32] = { '\0' }, time[64] = { '\0' }, timeq[80] = { '\0' };
>> +     char pid[32], time[64], timeq[80];
>
>  I agree that the original code is not elegant, but "else foo[0] =
>  '\0'" is also pretty ugly. It would be better to set all to the
>  default by one line
>
>    *pid = *time = *timeq = '\0';
>
>  at begin of the function.

Hi Karel,

Done in proposed way.

https://github.com/kerolasa/lelux-utiliteetit/commit/2e31a991d10dadb2a702be6999030a945b8cf364

>>       if ((process = get_process_id(ctl)))
>>               snprintf(pid, sizeof(pid), " %d", process);
>> +     else
>> +             pid[0] = '\0';
>
>  I really don't like hairy code like this.

OK, I'll try to be less hairy in future.  We'll see how that goes.
Eventually there will be occasional hairy patch, and hopefully they
are rejected in good will.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
