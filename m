Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932115AbcLHMVq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 8 Dec 2016 07:21:46 -0500
Date: Thu, 8 Dec 2016 13:21:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: Pull request: nsenter(1) fixes
Message-ID: <20161208122144.7uf6dhptb56t4ibe@ws.net.home>
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
 <d94b2af3-fe84-21be-9e41-3b3668729524@gmx.com>
 <20161206141822.vdhpf4wyvmjckkli@ws.net.home>
 <201612072034.14344.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201612072034.14344.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 07, 2016 at 08:34:13PM +0100, Ruediger Meier wrote:
> On Tuesday 06 December 2016, Karel Zak wrote:
> > On Mon, Dec 05, 2016 at 01:27:11PM -0500, J William Piggott wrote:
> > > On 12/05/2016 06:51 AM, Karel Zak wrote:
> > > > On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk 
> (man-pages) wrote:
> > > >> I have various fixes to send, but I'll start small, with a
> > > >> couple of fixes for nsenter(1).
> > > >
> > > >  Applied ... but you have removed "See also.. " sentence from
> > > >  description of the --user. Would be better to keep there?
> > > >
> > > >> Is a git pull request compatible with your
> > > >> workflow?
> > > >
> > > >  Sure.
> > >
> > > Does this apply to all of us? We no longer need to submit patches
> > > to the mailing list for peer review?
> >
> > Well, send patch to the mailing list for review is always good
> > choice, and it's definitely wanted for invasive or sensitive things,
> > or if you're not sure.
> >
> > I think for trivial changes where is nothing to discuss it's probably
> > good enough to send pull request only.
> >
> > It's also good idea to keep the latest version of your patches in
> > public remote repository (e.g. github) if you expect any additional
> > changes after review etc.
> >
> >
> > Use common sense anyway. It works better than strict rules.
> 
> One thing I would really like is that you would merge the mailing list 
> patch-sets in the same way like github does, using "git merge --no-ff". 
> This always adds an explicit merge commit which makes IMO later review 
> and bisecting easier. (Less uninteresting/intermediate points in 
> master.)

I use "git pull --log <url>" for remote repositories and "git-am" for emails.

I have doubts "git-am" allows to work with emails as with branch. IMHO
it will require manual intervention and apply the patches from mailbox
to the separate temporary branch and then merge the branch. The
question is also where to start the branch for the emails, it seems
there is no reliable information about a parental commit in the emails.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
