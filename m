Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48431 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273Ab2KUKJA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Nov 2012 05:09:00 -0500
Date: Wed, 21 Nov 2012 11:08:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org, mp.lists@free.fr
Subject: Re: Accessibility of swap files
Message-ID: <20121121100852.GC2006@x2.net.home>
References: <1352214367.5099275f85792@imp.free.fr>
 <535592290.498944.1352219102253.JavaMail.open-xchange@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <535592290.498944.1352219102253.JavaMail.open-xchange@email.1und1.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 06, 2012 at 05:25:02PM +0100, Bernhard Voelker wrote:
> On November 6, 2012 at 4:06 PM mp.lists@free.fr wrote:
> > Hi *,
> >
> > I think, measures can|should be taken, which reduce the probability of having
> > a
> > swap file inadvertently run with too open permissions.

 well, you need root permissions to use swapon, the swap devices and
 files are defined in /etc/fstan which is writable by root only.

 I have doubts that we have to make the system so paranoid and
 resistant to admin's bugs. And if you really need this level of
 paranoia then use SELinux (or so) rather than expect hardcoded rules
 in swapon(8).

> > As a first idea, it looks, as if such may be implemented, eg. by
> >      letting swapon [and fstab-based "mounting"] by default not enable a swap
> > file, if it has non-root access permissions
> 
> Did you know?
> The swapon utility issues a warning diagnostic with --verbose:
> 
>   # ls -l /tmp/swapfile
>   -rw-r--r-- 1 berny users 134217728 Nov  6 17:03 /tmp/swapfile
> 
>   # sbin/swapon -v  /tmp/swapfile
>   swapon /tmp/swapfile
>   swapon: /tmp/swapfile: insecure permissions 0644, 0600 suggested.
>   swapon: /tmp/swapfile: insecure file owner 1000, 0 (root) suggested.
>   swapon: /tmp/swapfile: found swap signature: version 1, page-size 4, same byte
> order
>   swapon: /tmp/swapfile: pagesize=4096, swapsize=134217728, devsize=134217728

 this waring is there since year 1999.. so it's really nothing new.

> BTW: the check for the owner has been added in 2.19
> (in commit v2.18-88-g306c1df).
> 
> I don't know if refusing to swapon insecure swap files is a good
> idea (see below).
> 
> >   || letting mkswap by default ignore too open settings of umask and create
> > the
> > swap file mod 0600 instead.

 sorry, this is nonsense

> You don't need root privs to run mkswap. Furthermore, mkswap
> doesn't create the swap file (in terms of calling creat()).

 yep, you can use cp(1) or dd(1) to create the file as a copy...

> Instead, it just writes to it.
> Nevertheless, I think a warning would be enough/nice at this stage.
> 
> > In both cases, an explicit switch|parameter could enable the present,
> > non-restrictive behaviour.
> 
> Changing behavior is not always a good idea for compatibility reasons,
> and therefore deserves *good* arguments.

Yes, I don't see good arguments.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
