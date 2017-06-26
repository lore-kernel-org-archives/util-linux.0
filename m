Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbdFZOZO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 10:25:14 -0400
Date: Mon, 26 Jun 2017 16:25:09 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] pull request
Message-ID: <20170626142509.3sumyu6ppcpx5bh2@ws.net.home>
References: <e5059958-a9b9-2ff4-f1b8-6122520bacac@gmx.com>
 <20170626082744.fx4zzuq4sgpzdkk6@ws.net.home>
 <4aaa7de1-b06c-331c-55fe-2cadcdcee87b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4aaa7de1-b06c-331c-55fe-2cadcdcee87b@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 26, 2017 at 09:47:42AM -0400, J William Piggott wrote:
> 
> 
> On 06/26/2017 04:27 AM, Karel Zak wrote:
> > On Sun, Jun 25, 2017 at 05:45:56PM -0400, J William Piggott wrote:
> >>
> >> * Rudi didn't like cluttering boilerplate.c with seldom used USAGE_*
> >>   constants and I don't disagree with that point. I do think they should
> >>   be in the file for new contributor discovery purposes. As a compromise
> >>   I added the missing ones as a comment.
> >>
> >> * the newly added USAGE_COLUMNS could be used in disk-utils/fdisk-list.c:432
> >>   if Karel wants to drop the ' (for -o)'. I did not change it.
> > 
> > I think USAGE_COLUMNS should be good enough everywhere and the
> > additional notes (like ' (for -o)') are unnecessary.
> > 
> > Maybe we can change the text to "Available output columns:" to make it
> > more specific for readers.
> 
> Since we cannot guarantee that the 'output' option name will always be
> available.

I have already pushed "Available output columns:" :-) 

The "output" does not mean any option in this case.

> It might be better to stay generic with the header and
> instead create the reference in the option description like:
> 
>  -o, --output <list>    columns to display (see Columns:)
> 
>  Columns:
>       SOURCE  source device
>       ...

Anyway, I like this "see Columns:" idea. Go ahead and send patch.

> On a somewhat related note; in recent discussion I've been trying to
> promote the idea of using consistent language. For example, with all of
> the synonyms: output, show, to stdout, display, print, etc. I think it
> would be helpful to both users and translators to choose one to be used
> consistently. Especially for technical writing it is important to use
> consistent terms.
> 
> An idea from the Linux man-pages project is that man-pages.7 has a list
> of preferred terms/spellings; perhaps util-linux could have a list of
> preferred terms to be used in documentation and message strings?

Sounds good. (but I hope we will have no endless "bike-shed
color" discussion about the terms)

> We also might want to consider replacing Documentation/howto-man-page.txt
> with a link to, or a copy of, man-pages.7. Michael and company have
> added a lot to it in recent times.

Documentation/howto-man-page.txt is a template, if you want to write new
tool than it should be good enough to cp(1) this template and use it.
I'd like to keep it there.

We can rename the file to Documentation/boilerplate.1 and rewrite
Documentation/howto-man-page.txt to the real how-to with link to the
Michal's man-pages.7.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
