Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbdGDH6j (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Jul 2017 03:58:39 -0400
Date: Tue, 4 Jul 2017 09:58:33 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Ruediger Meier <ruediger.meier@ga-group.nl>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 3/5] hwclock: final usage() strings slice
Message-ID: <20170704075833.eqhwwhpo36s2i63d@ws.net.home>
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
 <40df38f4-6bf5-1959-74af-6ee481b88a12@gmx.com>
 <201707031051.27992.ruediger.meier@ga-group.nl>
 <05bbcea5-5f5a-4767-7d98-6b0a4e6575a6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <05bbcea5-5f5a-4767-7d98-6b0a4e6575a6@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 03, 2017 at 11:35:01AM -0400, J William Piggott wrote:
> >> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > 
> > What about the mentioned whitespaces for puts() to get printf
> > on one line? 
> > 
> >   puts(  _("     --update-drift   update the RTC drift factor"));
> >   printf(_("     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
> >   printf(_("     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
> >   puts(  _("     --test           dry run; use -D to view what would have happened"));
> >   puts(  _(" -D, --debug          use debug mode"));
> 
> Sure, if that is what Karel wants (it can be a separate patch).
> 
> The only thing that I don't like about that choice is that it can cause
> puts() lines to wrap that otherwise would not. Since puts() is a lot
> more common than printf(), it seems like putting the alignment burden on
> printf() makes more sense.

I think the idea is to use the extra space only if you mix printf and
puts in the same code block. We have on many place only puts (or
fputs) -- in this case the extra space is unnecessary.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
