Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:34503 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbbLDTJs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 14:09:48 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1a4vjl-0007ZW-Cq
	for util-linux@vger.kernel.org; Fri, 04 Dec 2015 20:09:45 +0100
Received: from ip4d14b373.dynamic.kabel-deutschland.de ([77.20.179.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 20:09:45 +0100
Received: from for-gmane by ip4d14b373.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 04 Dec 2015 20:09:45 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: fsck memory leak
Date: Fri, 4 Dec 2015 20:09:38 +0100
Message-ID: <n3sodi$qhv$1@ger.gmane.org>
References: <n3rei3$8l3$1@ger.gmane.org> <20151204151927.GA3548@thunk.org>
 <n3sjvh$ib8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <n3sjvh$ib8$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

U.Mutlu wrote on 12/04/2015 06:53 PM:
> Theodore Ts'o wrote on 12/04/2015 04:19 PM:
>> On Fri, Dec 04, 2015 at 08:15:14AM +0100, U.Mutlu wrote:
>>> Hi,
>>> when I as root do "touch /forcefsck" and reboot, then fsck will be done.
>>> But afterwards one has less free memory available than normal.
>>> Example:
>>> used mem immediately after login:
>>>   without fsck during boot:  98 MB (this the normal level here)
>>>   with fsck during boot   : 139 MB
>>> So, there is a memory leak of about 41 MB.
>>
>> Please send the output of cat /proc/meminfo (a) before running fsck,
>> (b) after running fsck, and then (c) after running "echo 3 >
>> /proc/sys/vm/drop_caches".
>
> Just tried it out.
> Doing "echo 3 > /proc/sys/vm/drop_caches" solves the problem.

But thinking twice about this leads me to the conclusion that
there still must be something fishy in the system, because
I had read the used mem from the "-/+ buffers/cache" line of the "free -lh" 
command, here an example output:

$ free -lh
              total       used       free     shared    buffers     cached
Mem:          6.9G       1.3G       5.6G        17M        70M       882M
Low:          6.9G       1.3G       5.6G
High:           0B         0B         0B
-/+ buffers/cache:       404M       6.5G
Swap:         8.0G         0B       8.0G

So, it should have already counted-in the cached memory, and IMO it does.
But then it's mysterious why the said discrepancy of 41 MB shows up
if /proc/sys/vm/drop_caches has the default value of 0.



