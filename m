Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:39568 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbbKOP4Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Nov 2015 10:56:25 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZxzfC-0001xF-Tc
	for util-linux@vger.kernel.org; Sun, 15 Nov 2015 16:56:22 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 15 Nov 2015 16:56:22 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 15 Nov 2015 16:56:22 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: unshare -m for non-root user
Date: Sun, 15 Nov 2015 16:56:15 +0100
Message-ID: <n2a9uv$313$1@ger.gmane.org>
References: <n2674p$ulm$1@ger.gmane.org>
 <87si49p771.fsf@x220.int.ebiederm.org> <n26nkm$13l$1@ger.gmane.org>
 <20151114181716.GA3839@newbook> <n287q4$efd$1@ger.gmane.org>
 <n28krj$8i0$1@ger.gmane.org> <20151115012418.GC31395@vapier.lan>
 <n28pis$6uv$1@ger.gmane.org> <20151115062819.GD31395@vapier.lan>
 <n29sg5$15j$1@ger.gmane.org> <20151115124211.GA5949@vapier.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151115124211.GA5949@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote on 11/15/2015 01:42 PM:
> On 15 Nov 2015 13:06, U.Mutlu wrote:
>> Mike Frysinger wrote on 11/15/2015 07:28 AM:
>>> On 15 Nov 2015 03:10, U.Mutlu wrote:
>>>> Mike Frysinger wrote on 11/15/2015 02:24 AM:
>>>>> On 15 Nov 2015 01:49, U.Mutlu wrote:
>>>>>> So, then the question remains: how to give non-root user a secure mount
>>>>>
>>>>> no, it doesn't.  at least two people have already told you how to do it:
>>>>> use the usernamespace (-U) option that unshare already supports.
>>>>
>>>> It's not yet clear for me how to use that. Can you give an example?
>>>> unshare -U /bin/bash
>>>
>>> the unshare(1) man page already includes an example:
>>> $ unshare --map-root-user --user sh -c whoami
>>> root
>>
>> No, firstly there is no such example in man unshare, secondly it doesn't do here:
>> $ unshare --map-root-user --user sh -c whoami
>> unshare: unshare failed: Operation not permitted
>>
>> Is there maybe a bug in the Debian version?
>
> complain to Debian.  iirc, they break their kernels on purpose by adding
> non-standard caps which disallow userns usage.

Ok, I found out that on Debian one needs to make the follwing entry in 
/etc/sysctl.conf:
kernel.unprivileged_userns_clone = 1
and reboot, or do sysctl -p /etc/sysctl.conf, or equivalently
echo 1 > /proc/sys/kernel/unprivileged_userns_clone

Now the above unshare command does work.

>> And thirdly: is that not even more dangerous to give a user root permission
>> then? I don't understand this philosophy. Or, where is the trick in this?
>
> you aren't actually root.  you'll probably want to read:
> 	https://lwn.net/Articles/532593/
> 	man user_namespaces

Yes, I knew them, but hadn't read throughly :-)


