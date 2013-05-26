Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62214 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab3EZSz4 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 May 2013 14:55:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa10so6096019pad.33
        for <util-linux@vger.kernel.org>; Sun, 26 May 2013 11:55:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <51A2533B.9060905@bernhard-voelker.de>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
	<51A2533B.9060905@bernhard-voelker.de>
Date: Sun, 26 May 2013 19:55:55 +0100
Message-ID: <CAG27Bk19Z3GFnu5=-hvuWT9mCuZ23f5h_YpeA1q11WdgGTxt2w@mail.gmail.com>
Subject: Re: [PATCH 0000] pull: cal the branch four
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 26 May 2013 19:23, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> On 05/26/2013 11:14 AM, Sami Kerola wrote:
>> The cal branch I have in my git has got fixes to issues reviewed earlier,
>> and I hope all works.  Based on that I decided to get rid of upper cal
>> year limit, 9999, and replace it with unsigned long.  I know the change
>> does not make much practical sense, the point of the change is that where
>> there is no need to have artificial limits to a random magic number they
>> should not exist.
>
> unsigned years ... hmm, not that this would work today, but what about BC
> years? E.g. on what weekday did Julius Caesar die (March 15th, 44 BC, [1])?
> Maybe a future improvement (... having to make years signed again)?
>
> [1] http://en.wikipedia.org/wiki/Julius_Caesar

Hi Berny,

You are right. I'll make the year to be signed, and make error to be
displayed, for now, if negative year is defined.

BTW I tried the Tøndering's algorithm negative years and it gave odd
and obviously wrong results. If someone who is part of this list is
interested of mathematical puzzles making the negative year weekday
determination to work should be interesting challenge.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
