Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbaAMMMe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Jan 2014 07:12:34 -0500
Date: Mon, 13 Jan 2014 13:12:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Marcos Mello <marcosfrm@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Automatic SSD trim script
Message-ID: <20140113121231.GB12700@x2.net.home>
References: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30>
 <20131206104944.GE16891@x2.net.home>
 <alpine.LFD.2.00.1312091438300.2143@localhost.localdomain>
 <20131210154442.GC8419@x2.net.home>
 <loom.20131217T203643-235@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <loom.20131217T203643-235@post.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 17, 2013 at 07:46:35PM +0000, Marcos Mello wrote:
> Karel Zak <kzak@...> writes:
> 
> > 
> > On Mon, Dec 09, 2013 at 02:43:32PM +0100, Lukáš Czerner wrote:
> > > > All we need is to link fstrim with libmount and lib/sysfs.c, add a new
> > > > option --all and check non-zero
> /sys/block/≤name>/queue/discard_granularity
> > > > (or so).
> > > 
> > > Yes and yes. This is the ultimate solution. Simply being able to run
> > > fstrim --all to discard free space on all the mounted supported file
> > > systems is great idea. In that case we do not need any scripts at
> > > all.
> > 
> >  Implemented. Sten, maybe you can try fstrim --all from git tree 
> >  in your crontab.
> > 
> 
> Thanks, Karel!
> 
> Would it be possible add an option for the "--all" mode to tell fstrim skip
> mountpoints witch have "discard" option in fstab?

It seems like unnecessary optimization -- the overhead on filesystem with 
active discard is minimal.

(And according to Lukas in some cases FSTRIM ioctl can help you 
 with deleted files smaller than than discard_granularity.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
