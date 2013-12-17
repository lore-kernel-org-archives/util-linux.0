Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:54331 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab3LQTuJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Dec 2013 14:50:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Vt0eZ-0000UC-5o
	for util-linux@vger.kernel.org; Tue, 17 Dec 2013 20:50:03 +0100
Received: from bd0693be.virtua.com.br ([bd0693be.virtua.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 17 Dec 2013 20:50:03 +0100
Received: from marcosfrm by bd0693be.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 17 Dec 2013 20:50:03 +0100
To: util-linux@vger.kernel.org
From: Marcos Mello <marcosfrm@gmail.com>
Subject: Re: Automatic SSD trim script
Date: Tue, 17 Dec 2013 19:46:35 +0000 (UTC)
Message-ID: <loom.20131217T203643-235@post.gmane.org>
References: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30> <20131206104944.GE16891@x2.net.home> <alpine.LFD.2.00.1312091438300.2143@localhost.localdomain> <20131210154442.GC8419@x2.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@...> writes:

> 
> On Mon, Dec 09, 2013 at 02:43:32PM +0100, Lukáš Czerner wrote:
> > > All we need is to link fstrim with libmount and lib/sysfs.c, add a new
> > > option --all and check non-zero
/sys/block/≤name>/queue/discard_granularity
> > > (or so).
> > 
> > Yes and yes. This is the ultimate solution. Simply being able to run
> > fstrim --all to discard free space on all the mounted supported file
> > systems is great idea. In that case we do not need any scripts at
> > all.
> 
>  Implemented. Sten, maybe you can try fstrim --all from git tree 
>  in your crontab.
> 

Thanks, Karel!

Would it be possible add an option for the "--all" mode to tell fstrim skip
mountpoints witch have "discard" option in fstab?

--
Marcos

