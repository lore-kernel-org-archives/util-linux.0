Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f54.google.com ([209.85.220.54]:37387 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab3E2QU0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 May 2013 12:20:26 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so9496330pab.13
        for <util-linux@vger.kernel.org>; Wed, 29 May 2013 09:20:26 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20130528134925.GC30341@x2.net.home>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
	<51A2533B.9060905@bernhard-voelker.de>
	<CAG27Bk19Z3GFnu5=-hvuWT9mCuZ23f5h_YpeA1q11WdgGTxt2w@mail.gmail.com>
	<20130528134925.GC30341@x2.net.home>
Date: Wed, 29 May 2013 17:20:26 +0100
Message-ID: <CAG27Bk2UwNVNC-6Ziei3B2tem3_bM9-jTY7ezJfhOFsyXqDP5g@mail.gmail.com>
Subject: Re: [PATCH 0000] pull: cal the branch four
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 28 May 2013 14:49, Karel Zak <kzak@redhat.com> wrote:
>  If I good remember from "my previous life" than for example
>  PostgreSQL uses Julian calendar for unlimited datetime calculations.
>
>  See  https://github.com/postgres/postgres/blob/master/src/backend/utils/adt/datetime.c
>
>  and date2j(), j2date() and j2day() functions. Anyway, I have no clue
>  if the calculations are correct (in regards to reformation 1752).

Inspiring.

Perhaps the easiest way to signed year to work is shift year zero to
(LONG_MAX / 2). After that the all left to do is to match the week day
vs year, month, day equation table with new alignment, and find how
1752 has alteration has to be done. While that's a bit of work I find
it much easier than fixing the divisions when negative numbers are
involved. (*ehm* not even amateur mathematician talking)

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
