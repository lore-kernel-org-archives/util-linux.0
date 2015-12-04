Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:47104 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbbLDW0k (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 17:26:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1a4yoG-0000Mm-G4
	for util-linux@vger.kernel.org; Fri, 04 Dec 2015 23:26:36 +0100
Received: from ip4d14b373.dynamic.kabel-deutschland.de ([77.20.179.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 23:26:36 +0100
Received: from for-gmane by ip4d14b373.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 23:26:36 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: fsck memory leak
Date: Fri, 4 Dec 2015 23:26:30 +0100
Message-ID: <n3t3um$inb$1@ger.gmane.org>
References: <n3rei3$8l3$1@ger.gmane.org> <20151204195848.GA18359@thunk.org>
 <n3st78$77b$1@ger.gmane.org> <201512042240.19891.sweet_f_a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <201512042240.19891.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meier wrote on 12/04/2015 10:40 PM:
> On Friday 04 December 2015, U.Mutlu wrote:
>> I think it's a double-edged sword: if user has less memory then
>> the integrated caching will IMO degrade the performance.
>
> It will use as much memory as available (not more). Ideally Linux would
> use always 100% memory. You've spent money for memory ... why you
> wouldn't want to use it?
>
> After ...
> $ echo 3 > /proc/sys/vm/drop_caches
>
> ... my memory looks like this:
> $ free -h
>               total    used    free       shared    buffers     cached
> Mem:          7.7G    1.8G    6.0G         230M       4.4M       487M
> -/+ buffers/cache:    1.3G    6.5G
> Swap:         1.7G     68M    1.6G
>
> Then after ...
> $ dd if=/dev/sda of=/dev/null count=8K bs=1M
>
> ... cache/buffer is filled
> $ free -h
>               total    used    free       shared    buffers     cached
> Mem:          7.7G    7.6G    168M <=(1)   230M       5.6G       665M
> -/+ buffers/cache:    1.3G    6.5G <=(2)
> Swap:         1.7G     68M    1.6G
>
> ... and this should not change until reboot.
>
> (1) shows that almost 100% memory is "in use"
> (2) shows that it's just buffer or cache

Try the test with fsck at boot with drop_caches=0, and you will get an
illogical result as shown in my initial posting.

I'm not a friend of such default integrated system caching, it reminds
me of Windows idiocy. This is nothing but a diskcache in ram, but then
the admin should have the the freedom to set the size of the cache via
a config file in etc, for example /etc/default/cache or in /etc/default/tmpfs.

> sorun yapma ;)

:-)

> Rudi


