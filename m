Return-Path: util-linux-owner@vger.kernel.org
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:46218 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab2LGTTQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Dec 2012 14:19:16 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 2D8CD77C70E
	for <util-linux@vger.kernel.org>; Fri,  7 Dec 2012 20:19:12 +0100 (CET)
Message-ID: <1354907914.50c2410a715a9@imp.free.fr>
Date: Fri, 07 Dec 2012 20:18:34 +0100
From: mp.lists@free.fr
To: util-linux <util-linux@vger.kernel.org>
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: Accessibility of swap files
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



Karel Zak <kzak@...> writes:

>
> On Wed, Nov 21, 2012 at 01:46:59PM +0000, Sami Kerola wrote:
> > On Wed, Nov 21, 2012 at 10:08 AM, Karel Zak <kzak@...> wrote:
> > > On Tue, Nov 06, 2012 at 05:25:02PM +0100, Bernhard Voelker wrote:
> > >> On November 6, 2012 at 4:06 PM mp.lists@... wrote:
> > >> > As a first idea, it looks, as if such may be implemented, eg. by
> > >> >      letting swapon [and fstab-based "mounting"] by default not enable
a swap
> > >> > file, if it has non-root access permissions
> > >>
> > >> Did you know?
> > >> The swapon utility issues a warning diagnostic with --verbose:
> > >>
> > >>   # ls -l /tmp/swapfile
> > >>   -rw-r--r-- 1 berny users 134217728 Nov  6 17:03 /tmp/swapfile
> > >>
> > >>   # sbin/swapon -v  /tmp/swapfile
> > >>   swapon /tmp/swapfile
> > >>   swapon: /tmp/swapfile: insecure permissions 0644, 0600 suggested.
> > >>   swapon: /tmp/swapfile: insecure file owner 1000, 0 (root) suggested.
> > >>   swapon: /tmp/swapfile: found swap signature: version 1, page-size 4,
same byte
> > >> order
> > >>   swapon: /tmp/swapfile: pagesize=4096, swapsize=134217728,
devsize=134217728
> > >
> > >  this waring is there since year 1999.. so it's really nothing new.
> >
Fine.

This contains three kinds of information:
  - a line, which is redundant wrt the command line
  - two lines of {critical, in my opinion} warning about insecure fs permissions
  - another two lines, which characterise the content of the swapfile


...
>
>  since util-linux 2.9t:
>
>     /* people generally dislike this warning - now it is printed
>        only when `verbose' is set */
>
Does anybody have a pointer to the arguments, why people dislike to know
about insecure permissions?!

Since I can rarely imagine any useful use case of insecure swap file
permissions compared to the immense security hole, an open swap file usually
presents, I would propose to:
  - remove the first line, which is redundant to the command line
    {low prio; you may leave it in order not to break anything}
  -    write the two lines of critical warning [as cited above] also,
       if --verbose isn't set
       {at least}
    || refuse to swapon|mount a swap file with insecure permissions without
       a "--force" parameter {also in fstab}
       {preferrable}


To make my arguments more understandable on the social level:
it's a quite frequent use case, that some root is given the task to work on a
POSIX system, he does not have any deeper knowledge of, yet.  May be, it's a
fresh Unix installation or a VM image.  At least in my experience, it's a
relatively early activity in the life-cycle of a system to adjust a its swap
configuration.  root has a hard time, if he has to work in a complex
environment[, where is he is almost always in a situation, he does not know
enough about,] without compromising hese systems, when he can not rely on a
paranoid policy of those, who prepared his ground.


I hope, this makes my intention understandable, and lets reconsider their
good-enough-ness.


Best, Markus

