Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753114AbdKOSYl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Nov 2017 13:24:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D3A210567
        for <util-linux@vger.kernel.org>; Wed, 15 Nov 2017 18:24:41 +0000 (UTC)
Date: Thu, 16 Nov 2017 03:24:39 +0900 (JST)
Message-Id: <20171116.032439.1733506489064928691.yamato@redhat.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lsns: add netnsid column
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20171115110922.c4vufqiglnipyayn@ws.net.home>
References: <20171115025920.22394-1-yamato@redhat.com>
        <20171115110922.c4vufqiglnipyayn@ws.net.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 15 Nov 2017 12:09:22 +0100, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Nov 15, 2017 at 11:59:18AM +0900, Masatake YAMATO wrote:
>> Linux network subsystem assigns an unique integer to a network
>> namespace.
>> 
>>   term0# ip netns add UTIL-LINUX-LSNS-TEST-NS
>>   term0# ip netns list
>>   UTIL-LINUX-LSNS-TEST-NS
>>   term0# ip link add name lsns-vetha type veth peer name lsns-vethb
>>   term0 # ip link set lsns-vethb netns UTIL-LINUX-LSNS-TEST-NS
>>   term0# ip netns list
>>   UTIL-LINUX-LSNS-TEST-NS (id: 0)
>>   term0# ip link show dev lsns-vetha
>>   230: lsns-vetha@if229: <BROADCAST,MULTICAST> mtu 1500 qdisc noop ...
>>          link/ether 3e:27:68:ba:b3:95 brd ff:ff:ff:ff:ff:ff link-netnsid 0
>> In this example 0 is assigned to UTIL-LINUX-LSNS-TEST-NS net namespace.
>> The name, UTIL-LINUX-LSNS-TEST-NS, and it semantics is given and defined
>> by iproute2 in userland; and nothing to do with util-linux.
>> 
>> However, the id, 0, is managed in linux kernel. If lsns can show
>> the ids, it helps users understand the state of network namespaces.
> 
> Where iproute2 stores the logical name of the namespace (e.g.
> UTIL-LINUX-LSNS-TEST-NS)? Cannot we read it? :-)

I found I don't understand the mechanism of namespace well
enough to answer this question. So I made study.

Before studying I thought logical name of the namespace is
just iproute2 local hack. iproute2 stores the name to a
file under /var/run/netns with using "bind mount".
Though iproute2 is very popular software, I thought a low level
program like lsns should rely on and utilize only kernel to get
runtime information. I assumed making a mount point under
/var/run/netns was just private rule of iproute2.

After I studied I found it is not just iproute2 and
net namespace private things.

nsfs provides kernel level interface for logical name:

    commit 0226f4923f6c9b40cfa1c1c1b19a6ac6b3924ead
    Author: Al Viro <viro@zeniv.linux.org.uk>
    Date:   Tue Dec 6 12:21:54 2011 -0500

	vfs: take /proc/*/mounts and friends to fs/proc_namespace.c

	rationale: that stuff is far tighter bound to fs/namespace.c than to
	the guts of procfs proper.

	Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

[yamato@master]~/var/util-linux% cat /proc/self/mountinfo  | grep nsfs
247 240 0:3 net:[4026532562] /run/netns/UTIL-LINUX-LSNS-TEST-NS rw shared:190 - nsfs nsfs rw,seclabel
270 26 0:3 net:[4026532562] /run/netns/UTIL-LINUX-LSNS-TEST-NS rw shared:190 - nsfs nsfs rw,seclabel

By parsing this file (with libmount), we can say
/run/netns/UTIL-LINUX-LSNS-TEST-NS is the logical name for
net:[4026532562] either the mount point is created by ip command or
not.

"ip link show" still uses netnsid, so I think my patch still makes
sense. However, as you wrote, making a column for logical name,
is more useful. It is not limited to net namespace.

A namespace can have more than one logical names.
I wonder how to print them in a column.

>> +static int netnsid_xasputs(char **str, int netnsid)
>> +{
>> +	if (netnsid >= 0)
>> +		return xasprintf(&str, "%d", netnsid);
>> +#ifdef NETNSA_NSID_NOT_ASSIGNED
>> +	else if (netnsid == NETNSA_NSID_NOT_ASSIGNED)
>> +		return xasprintf(&str, "%s", "unassigned");
>> +#endif
>> +	else
>> +		return xasprintf(&str, "%s", "n/a");
> 
>  We usually use blank space rather than n/a if data are not available.
>  In this case "return NULL;" is good enough.
> 
>> +#ifdef HAVE_LINUX_NET_NAMESPACE_H
>> +	netlink_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>> +#endif
>> +	if (netlink_fd < 0)
>> +		netlink_fd = -errno;
> 
>  I guess this if() is unnecessary. The rest of the code check for
>  netlink_fd < 0.
>          
>  It would be also nice to call socket() only if NETNSID column is wanted.
> 
>  What about to add NETNSID collumn to the default output only if "--type net"
>  specified on lsns command line?

I think it is good idea.

Masatake YAMATO

>  I'm ready to do all the changes (you don't have to resend the patch).
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
