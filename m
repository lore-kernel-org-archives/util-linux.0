Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp5-g21.free.fr ([212.27.42.5]:58790 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab2LGTOn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Dec 2012 14:14:43 -0500
Message-ID: <1354907674.50c2401a5ee19@imp.free.fr>
Date: Fri, 07 Dec 2012 20:14:34 +0100
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
> On Tue, Nov 06, 2012 at 05:25:02PM +0100, Bernhard Voelker wrote:
> > On November 6, 2012 at 4:06 PM mp.lists@... wrote:
> > > Hi *,
> > >
> > > I think, measures can|should be taken, which reduce the probability of
having
> > > a
> > > swap file inadvertently run with too open permissions.
>
>  well, you need root permissions to use swapon, the swap devices and
>  files are defined in /etc/fstan which is writable by root only.
>
Very often "root" is a human.


>  I have doubts that we have to make the system so paranoid and
>  resistant to admin's bugs. And if you really need this level of
>  paranoia then use SELinux (or so) rather than expect hardcoded rules
>  in swapon(8).
>
Let me say it more liberally:
I expect a POSIXoid system in its default status to be configured the paranoid
way.  Everything else shall be an explicit informed decision.

I don't care, how paranoia is implemented, but it has to be omnipresent to a
reasonable degree.  If not, we may [in the best case] achieve correctness in a
mathematical sense, but never practically.


> > > As a first idea, it looks, as if such may be implemented, eg. by
> > >      letting swapon [and fstab-based "mounting"] by default not enable a
swap
> > > file, if it has non-root access permissions
> >
> > Did you know?
> > The swapon utility issues a warning diagnostic with --verbose:
> >
> >   # ls -l /tmp/swapfile
> >   -rw-r--r-- 1 berny users 134217728 Nov  6 17:03 /tmp/swapfile
> >
> >   # sbin/swapon -v  /tmp/swapfile
> >   swapon /tmp/swapfile
> >   swapon: /tmp/swapfile: insecure permissions 0644, 0600 suggested.
> >   swapon: /tmp/swapfile: insecure file owner 1000, 0 (root) suggested.
> >   swapon: /tmp/swapfile: found swap signature: version 1, page-size 4, same
byte
> > order
> >   swapon: /tmp/swapfile: pagesize=4096, swapsize=134217728,
devsize=134217728
>
>  this waring is there since year 1999.. so it's really nothing new.
>
> > BTW: the check for the owner has been added in 2.19
> > (in commit v2.18-88-g306c1df).
> >
> > I don't know if refusing to swapon insecure swap files is a good
> > idea (see below).
> >
> > >   || letting mkswap by default ignore too open settings of umask and
create
> > > the
> > > swap file mod 0600 instead.
>
>  sorry, this is nonsense
>
You are right.


> > You don't need root privs to run mkswap. Furthermore, mkswap
> > doesn't create the swap file (in terms of calling creat()).
>
>  yep, you can use cp(1) or dd(1) to create the file as a copy...
>
> > Instead, it just writes to it.
> > Nevertheless, I think a warning would be enough/nice at this stage.
> >
> > > In both cases, an explicit switch|parameter could enable the present,
> > > non-restrictive behaviour.
> >
> > Changing behavior is not always a good idea for compatibility reasons,
> > and therefore deserves *good* arguments.
>
> Yes, I don't see good arguments.
>
See my next posting.

{In order to get the right balance, I think, its a good idea to have a look at
those well-known systems, which are built on the policy of compatibility... }


Best, Markus


