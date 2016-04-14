Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbcDNKcy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Apr 2016 06:32:54 -0400
Date: Thu, 14 Apr 2016 12:32:52 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] chrt: make --sched-* short options to require an
 argument
Message-ID: <20160414103252.44t25l3mb2r7inll@ws.net.home>
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
 <20160404002100.eqclqk2rqbttbued@ws.net.home>
 <20160404082749.tqyzkgyba2ed77kr@ws.net.home>
 <201604041107.12672.sweet_f_a@gmx.de>
 <CAG27Bk3r9kEX+83wxXaSGyZ8driZgKO+0mESd7hD+tCkY8TGsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3r9kEX+83wxXaSGyZ8driZgKO+0mESd7hD+tCkY8TGsA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 04, 2016 at 03:43:23PM +0100, Sami Kerola wrote:
> On 4 April 2016 at 10:07, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > On Monday 04 April 2016, Karel Zak wrote:
> >> On Mon, Apr 04, 2016 at 02:21:00AM +0200, Karel Zak wrote:
> >> > On Sun, Apr 03, 2016 at 09:35:27AM +0100, Sami Kerola wrote:
> >> > > These options are expecting an argument, and the long options
> >> > > struct already required them.
> >> >
> >> >  Good catch, but deadline and runtime should be optional arguments
> >> > (it seems I have merged wrong version of my patch:-(
> >>
> >> Sorry, didn't read the patch correctly. You're right. Applied,
> >> thanks.
> >
> > BTW I like the coreutils convention that new options with optional
> > arguments should be long options only. This is less confusing for the
> > users.
> 
> Makes sense, and if Karel agrees Documentation/* files need updating.

Go ahead.

> BTW the debian bug 791707 that was the reason why I even started to look
> chrt is pretty good indication the command is not easy to use or understand.

All sched-utils has horrible command line, if I good remember we
have already tried to improve things, but unfortunately things are
limited by backward compatibility.

> But fixing that cannot be done without breaking ABI, and such change cannot
> be approved.  So should the util-linux v2.29 (or perhaps v3.0 as the numbers
> are getting a bit large) have new tools:
> 
> $ rtctl
> $ lsrt
> 
> Where the former has expected interface using options as people normally see
> them.  For example:
> 
> $ rtctl --priority 0 --policy rt --exec 'ls /etc' --pid $$
> 
> In above --exec or --pid can be used more than once, but 'settings' type options
> should not be allowed more than one instance to avoid confusions.
> 
> And 'lsrt' would be for displaying the stuff rtctl is controlling.

I have already thought about ls-like util for scheduling stuff and it
seems like a good idea. Not sure if we really need rtctl (I hate the
name, what about 'sched' :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
