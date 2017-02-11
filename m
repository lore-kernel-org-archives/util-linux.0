Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36842 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbdBKLYk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Feb 2017 06:24:40 -0500
Received: by mail-qt0-f194.google.com with SMTP id h53so7315340qth.3
        for <util-linux@vger.kernel.org>; Sat, 11 Feb 2017 03:24:39 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 11 Feb 2017 11:24:38 +0000
Message-ID: <CAG27Bk2kJ0P3i82vRK=cREtDhjO0VDBzXXpKpMBTvpnBCWefdA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hwclock: remove date(1)
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10 February 2017 at 20:58, J William Piggott <elseifthen@gmx.com> wrote:
> This branch adds the parse_datetime module from the gnu
> portability library.

Assuming gnulib integration is wanted then replacing bootstrap process,
deduplicating pieces of code in include/ with gnulib versions would be in
todo list.  For example why one would keep util-linux xmalloc() when gnulib
provides the same.  Same is true for close_stdout(), and many other
functions.

While code reuse is good idea I have doubts if this really is direction
where to go to.  It feels like gnulib integration is a big change, and easy
only when done incomplete or inadequate way.  Choosing the former is a bit
risky - I assume it is really difficult to know how much coding resource
will stick around doing the needed, how long it might take when reviews and
testing is included to a timeline.

Poor intergration has it's obvious problems.  Duplication of 'same' code,
leading to confusion which code paths are used where.  This can result bugs
that are easy to miss, e.g., end up being part of releases.  If the
integration is kept minimal then we might result in adding 25k lines of code
to replace one exec() that has worked fairly OK for years.  That in inself
feels awkward.

If asked would I be interested of gnulib challenge I would say yes, with a
catch, there is only so few hours per week I have time for this so without a
lot of people saying 'yes, lets do this' timeline getting integration
completed becomes unacceptably long.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
