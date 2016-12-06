Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751690AbcLFOSY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Dec 2016 09:18:24 -0500
Date: Tue, 6 Dec 2016 15:18:23 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: Pull request: nsenter(1) fixes
Message-ID: <20161206141822.vdhpf4wyvmjckkli@ws.net.home>
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
 <20161205115129.hvxasynsgszi33tu@ws.net.home>
 <d94b2af3-fe84-21be-9e41-3b3668729524@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d94b2af3-fe84-21be-9e41-3b3668729524@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 05, 2016 at 01:27:11PM -0500, J William Piggott wrote:
> On 12/05/2016 06:51 AM, Karel Zak wrote:
> > On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk (man-pages) wrote:
> >> I have various fixes to send, but I'll start small, with a couple of
> >> fixes for nsenter(1).
> > 
> >  Applied ... but you have removed "See also.. " sentence from
> >  description of the --user. Would be better to keep there?
> > 
> >> Is a git pull request compatible with your
> >> workflow?
> > 
> >  Sure. 
> 
> Does this apply to all of us? We no longer need to submit patches to the
> mailing list for peer review?

Well, send patch to the mailing list for review is always good choice,
and it's definitely wanted for invasive or sensitive things, or if
you're not sure.

I think for trivial changes where is nothing to discuss it's probably
good enough to send pull request only.

It's also good idea to keep the latest version of your patches in
public remote repository (e.g. github) if you expect any additional
changes after review etc. 


Use common sense anyway. It works better than strict rules. 


And this is not LKML, this is mailing list where we keep things in
friendly atmosphere, so don't be afraid to make a bad choice,
contribute non-perfect solution or ask "stupid" questions...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
