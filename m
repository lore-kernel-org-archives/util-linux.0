Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:51837 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbaEGIMe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 May 2014 04:12:34 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so613124wes.32
        for <util-linux@vger.kernel.org>; Wed, 07 May 2014 01:12:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140507071023.GT5962@x2.net.home>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
	<20140507071023.GT5962@x2.net.home>
Date: Wed, 7 May 2014 09:12:33 +0100
Message-ID: <CAG27Bk2WxGW4_e3pbAauX=dufbhQ9ojSqHisJf3_FhHUuNf8jw@mail.gmail.com>
Subject: Re: [PATCH 00/15] cytune modernization
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 7 May 2014 08:10, Karel Zak <kzak@redhat.com> wrote:
> On Sun, May 04, 2014 at 04:49:41PM +0100, Sami Kerola wrote:
>> Couple days ago Benno Schulenberg mentioned email with subject 'cytune:
>> misnamed long options' usage() being a bit misleading that I concurred
>> with note that the cytune could probably be improved various ways.  This
>> patch set proposes the improvements I had in mind.
>>
>> Please notice that I do not have hardware to test the cytune command, so
>> testing after the changes did not happen.  All I can say I tried to be
>> careful not to break program logic, and hopefully that will work.
>
>  Frankly, I'm a little bit nervous from all the invasive cytune
>  changes, because we have no way how to test it. It's fine to change
>  warning/error messages, usage() or so, but the another changes
>  without tests seem risky.

How about if I would splitting the cytune changes in two; safe changes
that can be merged and testing todo changes.  The todo changes would be
are archived to a cytune branch in upstream git until (if ever) someone
who has hardware has checked all works.

BTW does anyone in this list have cyclades and time for running sanity
checks?

>  The question is if we have to maintain HW specific util, particularly
>  when the HW seem rarely available (ebay only?). Maybe the best would
>  be to drop cytune.c from u-l and suggest to possible users to use
>  old u-l versions or maintain cytune.c outside u-l.

IMHO dropping the command would be best.

I can either prepare a safe change + testing todo or clean up. Let's wait for
couple days if someone has a good reason why the cytune(8) is still needed.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
