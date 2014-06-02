Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f53.google.com ([209.85.160.53]:61920 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbaFBQmf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Jun 2014 12:42:35 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so4393747pbc.40
        for <util-linux@vger.kernel.org>; Mon, 02 Jun 2014 09:42:34 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201406020035.40358.sweet_f_a@gmx.de>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<201405291223.40734.sweet_f_a@gmx.de>
	<CAG27Bk02R6UE4qqws=KOh5YKZ+hZJUyM1i8Z2dZ0h65a5Bpu2A@mail.gmail.com>
	<201406020035.40358.sweet_f_a@gmx.de>
Date: Mon, 2 Jun 2014 17:42:34 +0100
Message-ID: <CAG27Bk09hbETdviRdWyQ6QrrUOj-VUxqUurWAMTZuWFF4k=H9Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 1 June 2014 23:35, Ruediger Meier <sweet_f_a@gmx.de> wrote:
>> > At least I would quote it
>> >   cd "$TS_OUTDIR"
>> > or even better
>> >   cd "$TS_OUTDIR" || exit 1
>>
>> Hi Rudi,
>>
>> Good point. I changed my git to have the better change dir you
>> proposed.
>
> BTW I just noticed that bash's
> $ cd ''
> does NOT return error. But
> $ /usr/bin/cd ''
> does like it should IMO.

Karel,

Please drop the rename changes for now. They do not seem to be ready
before v2.25. Lets see afterwards what could or should be done to
rename, and others tests that change direcrory.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
