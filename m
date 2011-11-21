Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31385 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab1KUQgM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Nov 2011 11:36:12 -0500
Date: Mon, 21 Nov 2011 17:35:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Petr Uzel <petr.uzel@suse.cz>
Subject: Re: flock in 2.20.1 can no longer lock the file it will execute
Message-ID: <20111121163543.GU7916@nb.net.home>
References: <201111140123.39789.vapier@gentoo.org> <20111116131321.GN7916@nb.net.home> <201111161025.47605.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201111161025.47605.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 16, 2011 at 10:25:46AM -0500, Mike Frysinger wrote:
> On Wednesday 16 November 2011 08:13:21 Karel Zak wrote:
> > On Mon, Nov 14, 2011 at 01:23:38AM -0500, Mike Frysinger wrote:
> > > i've been using a trick with flock to add locking to all of my shell
> > > scripts.
> > > 
> > > basically, i take a lock on the shell script itself:
> > > 	flock -eon ./test.sh ./test.sh
> > > 
> > > with <=util-linux-2.20, this has worked fine.  but starting with 2.20.1,
> > > i now
> > > 
> > > get -ETXTBSY (on ext4, but i doubt that matters):
> > > 	$ echo '#!/bin/sh' > test.sh
> > > 	$ chmod a+rx test.sh
> > > 	$ ./flock -eon ./test.sh ./test.sh
> > > 	./flock: ./test.sh: Text file busy
> > > 
> > > the only commit made to flock.c between 2.20 and 2.20.1 is this:
> > > 	commit 75aaee08f06b92d119ed827c53d1af5474eb16ff
> > > 	flock: make flock(1) work on NFSv4
> > > 
> > > and indeed, reverting that made my life happy again.  reading the small
> > > patch shows the obvious flaw: you can't open a file for O_RDWR and
> > > attempt to execute it at the same time.
> > 
> >  Hmm... maybe we can add a new --read-write command line option for
> >  NFS guys rather than be smart with access(). The regression is
> >  unacceptable.
> 
> i wonder what happens if you attempt to take a read-only lock on nfs.  do you 
> get back an error ?

 yes, EIO 

> if the former, one solution might be to open the file, attempt to grab the 
> lock, and if the flock() fails, retry the whole thing but with O_RDWR instead.
> 
> int rw_flags = O_RDONLY;
> ...
> retry:
> 	... current open logic which uses new rw_flags var ...
> 
> 	... if flock fails, and rw_flags == O_RDONLY, then set rw_flags to O_RDWR 
> and jump back to retry ...

 Good idea, implemented and tested (git pull to get the change). It
 seems it works with your example as well as with NFSv4.
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
