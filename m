Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbdGCIag (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 04:30:36 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: fputs() vs puts()
Date: Mon, 3 Jul 2017 10:30:21 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com> <20170629201231.vjxp6mkecuqoalfo@ws.net.home> <1d036b95-430d-839f-031c-31b80e6e2b4f@gmx.com>
In-Reply-To: <1d036b95-430d-839f-031c-31b80e6e2b4f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201707031030.22137.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 30 June 2017, J William Piggott wrote:
> On 06/29/2017 04:12 PM, Karel Zak wrote:
> > On Thu, Jun 29, 2017 at 10:46:50AM -0400, J William Piggott wrote:
> >>>    (William, can you update your "standardize USAGE_COLUMNS"
> >>> patches? Please.)
> >>
> >> Sure, one clarification please: you want only the columns header
> >> in all caps? So:
> >>
> >> Usage:
> >> Options:
> >> Functions:
> >> Commands:
> >> COLUMNS:
> >
> > ha.. that's a good question. Suggestions?
> >
> > For example coreutils project uses uppercase for keywords only, for
> > example dd(1)
> >
> >     Each FLAG symbol may be:
> >        ...
> >     Each CONV symbol may be:
> >        ...
> >
> > it seems like original Rudi's idea
> >
> >     Available COLUMNS:
>
> But they also use:
> of=FILE
> conv=CONVS
>
> So we cannot completely follow that paradigm. The above are not
> option args, and you do not want option args in all caps.
>
> The columns situation is unique, we don't have to play follow the
> leader.
>
> Comparing:
>
>         --output <list>    COLUMNS to display (see below)
>         ...
>         Available COLUMNS:
>
> With:
>         --output <list>    columns to display (see Columns:)
>         ...
>         Columns:
>
>
> What does the reader learn by yelling COLUMNS at them.

It's just de-facto standard for "--help/man"-like technical 
documentation. If you would write html or info docs, then you would not 
use capital letters but links to click on.

Compare:

$ man bash | grep -i EXPANSION
$ man bash | grep  EXPANSION

or

$ xz --help | grep -i FILE
$ xz --help | grep FILE 

It's a very useful style and users *use* this by case-sensitive search 
in less or grep. This style is not always used 100% consistently but 
I'm happy whenever I see it, saves me a lot of time usually.

cu,
Rudi

> Sometimes a 
> vague reference like 'see below' is required. In this case the reader
> can be told exactly what they a looking for. It also keeps our
> usage() headings consistent.
>
> The two are not so different; I just think my solution is less
> ambiguous, is easier to read, and looks a bit cleaner.
>
> It's your call to make Karel.
>
> > it's more compatible with the rest than alone "COLUMNS". So I vote
> > this one.
> >
> >     Karel


