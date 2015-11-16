Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:54737 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbbKPCCF convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Nov 2015 21:02:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Zy97J-0005L9-An
	for util-linux@vger.kernel.org; Mon, 16 Nov 2015 03:02:01 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 16 Nov 2015 03:02:01 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 16 Nov 2015 03:02:01 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: unshare -m for non-root user
Date: Mon, 16 Nov 2015 03:01:54 +0100
Message-ID: <n2bdei$vhf$1@ger.gmane.org>
References: <n2674p$ulm$1@ger.gmane.org>
 <87si49p771.fsf@x220.int.ebiederm.org> <n26nkm$13l$1@ger.gmane.org>
 <20151114181716.GA3839@newbook> <n287q4$efd$1@ger.gmane.org>
 <n28krj$8i0$1@ger.gmane.org> <20151115012418.GC31395@vapier.lan>
 <n28pis$6uv$1@ger.gmane.org> <20151115062819.GD31395@vapier.lan>
 <n29sg5$15j$1@ger.gmane.org> <20151115124211.GA5949@vapier.lan>
 <n2a9uv$313$1@ger.gmane.org> <5648EA26.2080804@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <5648EA26.2080804@zoho.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ángel González wrote on 11/15/2015 09:25 PM:
>>> complain to Debian. iirc, they break their kernels on purpose by adding
>>> non-standard caps which disallow userns usage.
>>
>> Ok, I found out that on Debian one needs to make the follwing entry in
>> /etc/sysctl.conf:
>> kernel.unprivileged_userns_clone = 1
>> and reboot, or do sysctl -p /etc/sysctl.conf, or equivalently
>> echo 1 > /proc/sys/kernel/unprivileged_userns_clone
>
> The kernel will neded to be compiled with CONFIG_USER_NS

True, but the stock Debian 8 kernel has it already enabled,
as the following tool (belongs to lxc) reports:

#######
$ lxc-checkconfig
Kernel configuration not found at /proc/config.gz; searching...
Kernel configuration found at /boot/config-3.16.0-4-amd64
--- Namespaces ---
Namespaces: enabled
Utsname namespace: enabled
Ipc namespace: enabled
Pid namespace: enabled
User namespace: enabled
Network namespace: enabled
Multiple /dev/pts instances: enabled

--- Control groups ---
Cgroup: enabled
Cgroup clone_children flag: enabled
Cgroup device: enabled
Cgroup sched: enabled
Cgroup cpu account: enabled
Cgroup memory controller: enabled
Cgroup cpuset: enabled

--- Misc ---
Veth pair device: enabled
Macvlan: enabled
Vlan: enabled
File capabilities: enabled

Note : Before booting a new kernel, you can check its configuration
usage : CONFIG=/path/to/config /usr/bin/lxc-checkconfig
#######

Another method to see it is this one:
$ grep CONFIG_USER_NS /boot/config-`uname -r`
CONFIG_USER_NS=y




