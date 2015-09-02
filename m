Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33951 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbIBB3w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 1 Sep 2015 21:29:52 -0400
Received: by padhy1 with SMTP id hy1so13806954pad.1
        for <util-linux@vger.kernel.org>; Tue, 01 Sep 2015 18:29:51 -0700 (PDT)
Date: Tue, 1 Sep 2015 18:29:51 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
Subject: Re: fdisk
Message-ID: <20150902012950.GA1910@newbook>
References: <55E3B640.2060606@gmail.com>
 <55E3FAA9.5060204@bernhard-voelker.de>
 <55E47EC8.1030904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55E47EC8.1030904@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 31, 2015 at 11:20:24AM -0500, Bruce Dubbs wrote:
> Bernhard Voelker wrote:
> >On 08/31/2015 04:04 AM, Bruce Dubbs wrote:
> >>I have a question about (or a enhancement request) running fdisk.  When
> >>asking to list known partition types, I get about 70 lines of output.
> >>Generally that would not be a problem, but I was running in a Debian
> >>install/rescue iso that uses busybox in a 25 line terminal.  I do not
> >>have a way to scroll up and thus cannot see the first 40 or so partition
> >>types.
> >>
> >>Is there a way to use a pager for this?  In this situation 'more' is
> >>available but 'less' is not.  Otherwise I think an automatic pause every
> >>20 lines or so would be appropriate to build into the partition type
> >>listing.
> >
> >hmm, I'm getting 27 lines (at a maximum line length of 79 characters) as
> >output of the 'l' command  here - even if I resize the xterm to 20x80
> >characters.
> >OTOH, the main help output via the 'm' command uses 38 lines.  Shouldn't
> >you also have issues with that one in your environment?
> 
> In a konsole terminal resized to
> 
> # echo $LINES
> 25
> # fdisk --version
> fdisk from util-linux 2.26.2
> 
> Yes, the main menu scrolls off the top do the topmost line is:
> 
> n   add a new partition
> 
> but that is not a big problem in konsole because I can scroll back the
> buffer.  The l command lists the partition types and the topmost line of the
> screen is entry number 44.
> 
> The difficult problem is in busybox where there is no scroll back
> capability.

If you do not switch VTs, the Linux kernel has a limited "scroll back"
capability:
use <Shift>+<PgUp> or <Shift>+<PgDn>.

There are serious enough limitations to this that it's not really viable
except as a workaround:
-only things that have been on-screen after you last switched to the
current VT will be visible
-switch VTs, and you lose history

But it may be useful to you.

HTH,
Isaac Dunham
