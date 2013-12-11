Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57576 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab3LKCIF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Dec 2013 21:08:05 -0500
Received: from [160.129.138.113] ([160.129.138.113]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0MHHdb-1VlOYz3fVb-00E8Zv for
 <util-linux@vger.kernel.org>; Wed, 11 Dec 2013 03:08:03 +0100
Message-ID: <52A7C8FB.4030605@gmx.de>
Date: Tue, 10 Dec 2013 20:07:55 -0600
From: Sten Heinze <sten.heinze@gmx.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>,
        =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Automatic SSD trim script
References: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30> <20131206104944.GE16891@x2.net.home> <alpine.LFD.2.00.1312091438300.2143@localhost.localdomain> <20131210154442.GC8419@x2.net.home>
In-Reply-To: <20131210154442.GC8419@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/10/2013 9:44 AM, Karel Zak wrote:
> On Mon, Dec 09, 2013 at 02:43:32PM +0100, Lukáš Czerner wrote:
>>> All we need is to link fstrim with libmount and lib/sysfs.c, add a new
>>> option --all and check non-zero /sys/block/<name>/queue/discard_granularity
>>> (or so).
>>
>> Yes and yes. This is the ultimate solution. Simply being able to run
>> fstrim --all to discard free space on all the mounted supported file
>> systems is great idea. In that case we do not need any scripts at
>> all.
>
>   Implemented. Sten, maybe you can try fstrim --all from git tree
>   in your crontab.
>
>      Karel
>

This was fantastic fast! I will try it out as soon as I have cloned the 
git repo and built it.

Thanks a lot!

Sten
