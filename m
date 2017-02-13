Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752812AbdBMNER (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Feb 2017 08:04:17 -0500
Date: Mon, 13 Feb 2017 14:04:08 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: J William Piggott <elseifthen@gmx.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/3] hwclock: remove date(1)
Message-ID: <20170213130408.psp6qoyaa6htl6aa@ws.net.home>
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
 <CAG27Bk2kJ0P3i82vRK=cREtDhjO0VDBzXXpKpMBTvpnBCWefdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2kJ0P3i82vRK=cREtDhjO0VDBzXXpKpMBTvpnBCWefdA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 11, 2017 at 11:24:38AM +0000, Sami Kerola wrote:
> On 10 February 2017 at 20:58, J William Piggott <elseifthen@gmx.com> wrote:
> > This branch adds the parse_datetime module from the gnu
> > portability library.
> 
> Assuming gnulib integration is wanted then replacing bootstrap process,
> deduplicating pieces of code in include/ with gnulib versions would be in
> todo list.  For example why one would keep util-linux xmalloc() when gnulib
> provides the same.  Same is true for close_stdout(), and many other
> functions.
> 
> While code reuse is good idea I have doubts if this really is direction
> where to go to.

I have no doubts, I'm sure that we don't want it. It's overkill.

> to replace one exec() that has worked fairly OK for years.  That in inself
> feels awkward.

Well, from my point of view it would be good enough to use our
parse_timestamp() from lib/timeutils.c to implement 'hwclock --date'
if we would think about it as a new feature. 

Now it's probably too late as I guess date(1) supports more formats,
so we need to keep exec(date) for backward compatibility. I don't see
any significant change that forces us to replace this exec with gnulib.

> If asked would I be interested of gnulib challenge I would say yes, with a
> catch, there is only so few hours per week I have time for this so without a
> lot of people saying 'yes, lets do this' timeline getting integration
> completed becomes unacceptably long.
 
Let's keep util-linux simple and stupid. We don't need portability to
mars rover and obsolete UNIXes like coreutils. Sometimes it's better
to locally duplicate effort (or steal code from another projects)
than ride a gnulib monster.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
