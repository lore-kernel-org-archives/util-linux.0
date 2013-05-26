Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34667 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab3EZT7g (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 May 2013 15:59:36 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so6041749pbc.35
        for <util-linux@vger.kernel.org>; Sun, 26 May 2013 12:59:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAG27Bk19Z3GFnu5=-hvuWT9mCuZ23f5h_YpeA1q11WdgGTxt2w@mail.gmail.com>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
	<51A2533B.9060905@bernhard-voelker.de>
	<CAG27Bk19Z3GFnu5=-hvuWT9mCuZ23f5h_YpeA1q11WdgGTxt2w@mail.gmail.com>
Date: Sun, 26 May 2013 20:59:35 +0100
Message-ID: <CAG27Bk1DgWPTY9f3LfZEj+E_La4ogcPSyfCEpa7AanKG584wwg@mail.gmail.com>
Subject: Re: [PATCH 0000] pull: cal the branch four
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 26 May 2013 19:55, Sami Kerola <kerolasa@iki.fi> wrote:
> On 26 May 2013 19:23, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
>> On 05/26/2013 11:14 AM, Sami Kerola wrote:
>>> The cal branch I have in my git has got fixes to issues reviewed earlier,
>>> and I hope all works.  Based on that I decided to get rid of upper cal
>>> year limit, 9999, and replace it with unsigned long.  I know the change
>>> does not make much practical sense, the point of the change is that where
>>> there is no need to have artificial limits to a random magic number they
>>> should not exist.
>>
>> unsigned years ... hmm, not that this would work today, but what about BC
>> years? E.g. on what weekday did Julius Caesar die (March 15th, 44 BC, [1])?
>> Maybe a future improvement (... having to make years signed again)?
>>
>> [1] http://en.wikipedia.org/wiki/Julius_Caesar
>
> You are right. I'll make the year to be signed, and make error to be
> displayed, for now, if negative year is defined.

The year is now signed integer.

https://github.com/kerolasa/lelux-utiliteetit/commit/e44fe4712140774b677de466affc31e0581ee335

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
