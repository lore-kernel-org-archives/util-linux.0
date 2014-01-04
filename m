Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16675 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbaADIbR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 4 Jan 2014 03:31:17 -0500
Date: Sat, 4 Jan 2014 09:31:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Kjetil Torgrim Homme <kjetil.homme@redpill-linpro.com>
Cc: util-linux@vger.kernel.org
Subject: Re: flock(1): working with fcntl locks
Message-ID: <20140104083107.GB4435@x2.net.home>
References: <52C6C23E.1070207@redpill-linpro.com>
 <20140103144050.GA4435@x2.net.home>
 <52C6D365.10601@redpill-linpro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52C6D365.10601@redpill-linpro.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 03, 2014 at 04:12:37PM +0100, Kjetil Torgrim Homme wrote:
> >  Welcome to POSIX/Linux locking... read nice Lennart's summary:
> >  http://0pointer.de/blog/projects/locking.html
> >  http://0pointer.de/blog/projects/locking2
> 
> thanks!  doesn't seem relevant for flock(1), though, since there is no
> threading involved.  flock(1) should acquire the lock, fork the child and
> wait for it before returning the lock.  no pitfalls there?

       (
          flock -n 9 || exit 1
          # ... commands executed under lock ...
       ) 9>/var/lock/mylockfile

this is way how people use flock in scripts and it works because it's 
based on file descriptors and independent on original process.

> I don't see why you think fcntl(2) sucks more.

 see Lennart's summary, the problem is that the lock is based on
 process and it's useless for system files (due to open/close 
 in libraries), etc.

> >  No please, flock(1) is based on flock(2), that's all. The semantic
> >  and all possible limitations are well known. I don't think we want to
> >  make things more complicated.
> 
> do you think we should have a posixlock(1)?  (if so, perhaps it would fit
> better in coreutils rather than util-linux ...)

 Yep.

 Frankly, reliable fcntl locking requires a lot of code and extra lock
 files (we use it for example in original mount for /etc/mtab).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
