Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33718 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbbF2IJP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 29 Jun 2015 04:09:15 -0400
Received: by wiwl6 with SMTP id l6so91649310wiw.0
        for <util-linux@vger.kernel.org>; Mon, 29 Jun 2015 01:09:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CADNa6_39RU7RQRpd0oG1KAVT2Yo0Z1fi6roy6cQXCeNkeFQG5A@mail.gmail.com>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
	<1435520605-4296-5-git-send-email-kerolasa@iki.fi>
	<CADNa6_39RU7RQRpd0oG1KAVT2Yo0Z1fi6roy6cQXCeNkeFQG5A@mail.gmail.com>
Date: Mon, 29 Jun 2015 09:09:14 +0100
Message-ID: <CAG27Bk22KnyNehHSxgx3Om1R25mjFyFffV==gAYpNXS-y35BKQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] docs: unify mkswap(8) with swapon(8) about holes warning
From: Sami Kerola <kerolasa@iki.fi>
To: Dave Rutherford <dave@evilpettingzoo.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 June 2015 at 03:35, Dave Rutherford <dave@evilpettingzoo.com> wrote:
> On Sun, Jun 28, 2015 at 3:43 PM, Sami Kerola <kerolasa@iki.fi> wrote:
>>
>> +It is recommended to use
>> +.BR dd (1)
>> +and /dev/zero to in these cases.  Please read notes from
>
>
> You're missing a verb after `to' there.

Thanks for review Dave. I changed the wording to form: 'and /dev/zero
in these cases.' Updated version is in my remote repo.

https://github.com/kerolasa/lelux-utiliteetit/commit/5e3899b316392a5ff65d917ae47adb2053529309

> Thanks for your comments on my patch to wall. I certainly
> hope your suggestion for json was satire. I'm new to the list
> so not sure I have the right perception there yet.

Being able to parse[1] wall(1) message was earlier seen as something
possibly useful. Json would do that fairly well, but I admit json is
broken proposal - it feels wrong. Maybe wall(1) should copy the
message to /dev/log and whom ever is interested to know when exactly
messages were sent, what was said, and by whom, should read system
log. Obviously system log is not readable all distributions for all
users, so syslog is useful to a limit

[1] http://www.spinics.net/lists/util-linux-ng/msg09930.html

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
