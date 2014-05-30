Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37585 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029AbaE3Hoo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 30 May 2014 03:44:44 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so1438750pab.1
        for <util-linux@vger.kernel.org>; Fri, 30 May 2014 00:44:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201405291223.40734.sweet_f_a@gmx.de>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<20140527144601.GB385@x2.net.home>
	<CAG27Bk2FVPQgR8Qd-y3KfN9X9zs7w_jr1GiRqFGtdMjdZNk1Bw@mail.gmail.com>
	<201405291223.40734.sweet_f_a@gmx.de>
Date: Fri, 30 May 2014 08:44:43 +0100
Message-ID: <CAG27Bk02R6UE4qqws=KOh5YKZ+hZJUyM1i8Z2dZ0h65a5Bpu2A@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 May 2014 11:23, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> On Thursday 29 May 2014, Sami Kerola wrote:
>> On 27 May 2014 15:46, Karel Zak <kzak@redhat.com> wrote:
>> > On Mon, May 26, 2014 at 04:46:12PM +0100, Sami Kerola wrote:
>> >> git://github.com/kerolasa/lelux-utiliteetit.git rename
>> >
>> >  Not merged, it seems that the tests still uses the current directory
>> >  rather than $TS_OUTDIR, right?
>>
>> Oh, that's a beginner mistake. Fix is available in same git remote
>> location. All I did was a cd before file operations in each script,
>> something like this:
>>
>> +++ b/tests/ts/rename/basic
>> @@ -22,6 +22,7 @@ TS_DESC="basic check"
>>  ts_init "$*"
>>
>>  ts_check_test_command "$TS_CMD_RENAME"
>> +cd $TS_OUTDIR
>
> I know we are doing similar already in other tests too. IMO cd in scripts can be very dangerous, specially if there is no error handling.
>
> For example if ts_init is broken (while you are working on it) and TS_OUTDIR would be unset then "cd $TS_OUTDIR" would jump into your $HOME ... which could be really bad.
>
> At least I would quote it
>   cd "$TS_OUTDIR"
> or even better
>   cd "$TS_OUTDIR" || exit 1

Hi Rudi,

Good point. I changed my git to have the better change dir you proposed.

What would you think adding exit on error[1], disallow referrals to
unset variables[2], and make any errors in pipe chains to cause exit
on error to blow up[3], as default in ts_init()? I use in my own
scripts these as default settings, and when I refactor scripts I tend
to add these to make them more robust. Down side is that these
settings often cause quite a bit changes, which would mean the change
should not be considered before the release v2.25 is out.

[1] set -e && trap 'ts_failed "exit on error"' ERR
[2] set -u
[3] set -o pipefail

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
