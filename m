Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45876 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710Ab3LJPot (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Dec 2013 10:44:49 -0500
Date: Tue, 10 Dec 2013 16:44:42 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Sten Heinze <shze@gmx.de>, util-linux@vger.kernel.org
Subject: Re: Automatic SSD trim script
Message-ID: <20131210154442.GC8419@x2.net.home>
References: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30>
 <20131206104944.GE16891@x2.net.home>
 <alpine.LFD.2.00.1312091438300.2143@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LFD.2.00.1312091438300.2143@localhost.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 09, 2013 at 02:43:32PM +0100, Lukáš Czerner wrote:
> > All we need is to link fstrim with libmount and lib/sysfs.c, add a new
> > option --all and check non-zero /sys/block/<name>/queue/discard_granularity
> > (or so).
> 
> Yes and yes. This is the ultimate solution. Simply being able to run
> fstrim --all to discard free space on all the mounted supported file
> systems is great idea. In that case we do not need any scripts at
> all.

 Implemented. Sten, maybe you can try fstrim --all from git tree 
 in your crontab.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
