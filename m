Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:57608 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbcLGTeW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Dec 2016 14:34:22 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: Pull request: nsenter(1) fixes
Date: Wed, 7 Dec 2016 20:34:13 +0100
Cc: J William Piggott <elseifthen@gmx.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        util-linux@vger.kernel.org
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com> <d94b2af3-fe84-21be-9e41-3b3668729524@gmx.com> <20161206141822.vdhpf4wyvmjckkli@ws.net.home>
In-Reply-To: <20161206141822.vdhpf4wyvmjckkli@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201612072034.14344.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 06 December 2016, Karel Zak wrote:
> On Mon, Dec 05, 2016 at 01:27:11PM -0500, J William Piggott wrote:
> > On 12/05/2016 06:51 AM, Karel Zak wrote:
> > > On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk 
(man-pages) wrote:
> > >> I have various fixes to send, but I'll start small, with a
> > >> couple of fixes for nsenter(1).
> > >
> > >  Applied ... but you have removed "See also.. " sentence from
> > >  description of the --user. Would be better to keep there?
> > >
> > >> Is a git pull request compatible with your
> > >> workflow?
> > >
> > >  Sure.
> >
> > Does this apply to all of us? We no longer need to submit patches
> > to the mailing list for peer review?
>
> Well, send patch to the mailing list for review is always good
> choice, and it's definitely wanted for invasive or sensitive things,
> or if you're not sure.
>
> I think for trivial changes where is nothing to discuss it's probably
> good enough to send pull request only.
>
> It's also good idea to keep the latest version of your patches in
> public remote repository (e.g. github) if you expect any additional
> changes after review etc.
>
>
> Use common sense anyway. It works better than strict rules.

One thing I would really like is that you would merge the mailing list 
patch-sets in the same way like github does, using "git merge --no-ff". 
This always adds an explicit merge commit which makes IMO later review 
and bisecting easier. (Less uninteresting/intermediate points in 
master.)

Though maybe other people would rather like a simple straight forward 
master branch. Anyways this is just my vote for --no-ff :)

cu,
Rudi
