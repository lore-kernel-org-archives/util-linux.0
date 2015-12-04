Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:40257 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371AbbLDUbo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 15:31:44 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1a4x14-00045x-IR
	for util-linux@vger.kernel.org; Fri, 04 Dec 2015 21:31:42 +0100
Received: from ip4d14b373.dynamic.kabel-deutschland.de ([77.20.179.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 21:31:42 +0100
Received: from for-gmane by ip4d14b373.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 21:31:42 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: fsck memory leak
Date: Fri, 4 Dec 2015 21:31:36 +0100
Message-ID: <n3st78$77b$1@ger.gmane.org>
References: <n3rei3$8l3$1@ger.gmane.org> <20151204151927.GA3548@thunk.org>
 <n3sjvh$ib8$1@ger.gmane.org> <20151204195848.GA18359@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151204195848.GA18359@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Theodore Ts'o wrote on 12/04/2015 08:58 PM:
> On Fri, Dec 04, 2015 at 06:53:53PM +0100, U.Mutlu wrote:
>>> Please send the output of cat /proc/meminfo (a) before running fsck,
>>> (b) after running fsck, and then (c) after running "echo 3 >
>>> /proc/sys/vm/drop_caches".
>>
>> Just tried it out.
>> Doing "echo 3 > /proc/sys/vm/drop_caches" solves the problem.
>
> There's no problem then --- except in your understanding of how
> Linux's memory management system works.
>
> Linux keeps data that was read from disk in its buffer and page cache,
> because there is always a chance that data could be needed again.  So
> although it looks like free space is being consumed by the buffer and
> page caches, if those pages are clean (not dirty; if they were
> modified, we've gotten around to writing the modified data back to
> disk) and inactive (not installed in some process's page table, such
> that the page is visible in some process's virtual address space),
> even though those pages aren't counted as "free" memory, it can be
> instantly reused for something else.
>
> So doing something like "echo 3 > /proc/sys/vm/drop_caches" is
> actually a _bad_ thing, since it means you are throwing away data that
> could be used to avoid blocking waiting for disk I/O to complete.
> However, if it helps satisfy some system administrator's insecurity
> because they are looking at this field:
>
>            total      used      free    shared  buff/cache   available
> Mem:        15G      4.4G  ==> 4.5G <==  392M        6.4G         10G
> Swap:        0B        0B        0B
>
> when they should be looking at *this* field:
>
>            total      used      free    shared  buff/cache   available
> Mem:        15G      4.4G      4.5G      392M        6.4G    ===> 10G <===
> Swap:        0B        0B        0B
>
> It's just being silly.
>
> Yes, after doing the "echo 3 > /proc/sys/vm/drop_caches", you would
> see this instead:
>
>            total      used      free    shared  buff/cache   available
> Mem:        15G      4.1G       10G      390M        927M         10G
> Swap:        0B        0B        0B
>
> But reducing the size of buff/cache is not a win!  If you suddenly
> need the memory because you suddently started some memory hog such as
> Eclipse, the system will automatically reclaim the clean and inactive
> pages for use by the new memory user.  But until then, why not keep
> the cache pages around just in case they are needed?
>
> Regards,
>
> 						- Ted


I think it's a double-edged sword: if user has less memory then
the integrated caching will IMO degrade the performance.

Btw, why does my "free" command not have the "available" column?
Or did you use a different tool for the above outputs?



