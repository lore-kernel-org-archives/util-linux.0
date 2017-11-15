Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753921AbdKOLJ0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Nov 2017 06:09:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6717C883A2
        for <util-linux@vger.kernel.org>; Wed, 15 Nov 2017 11:09:26 +0000 (UTC)
Date: Wed, 15 Nov 2017 12:09:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lsns: add netnsid column
Message-ID: <20171115110922.c4vufqiglnipyayn@ws.net.home>
References: <20171115025920.22394-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171115025920.22394-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 15, 2017 at 11:59:18AM +0900, Masatake YAMATO wrote:
> Linux network subsystem assigns an unique integer to a network
> namespace.
> 
>   term0# ip netns add UTIL-LINUX-LSNS-TEST-NS
>   term0# ip netns list
>   UTIL-LINUX-LSNS-TEST-NS
>   term0# ip link add name lsns-vetha type veth peer name lsns-vethb
>   term0 # ip link set lsns-vethb netns UTIL-LINUX-LSNS-TEST-NS
>   term0# ip netns list
>   UTIL-LINUX-LSNS-TEST-NS (id: 0)
>   term0# ip link show dev lsns-vetha
>   230: lsns-vetha@if229: <BROADCAST,MULTICAST> mtu 1500 qdisc noop ...
>          link/ether 3e:27:68:ba:b3:95 brd ff:ff:ff:ff:ff:ff link-netnsid 0
> In this example 0 is assigned to UTIL-LINUX-LSNS-TEST-NS net namespace.
> The name, UTIL-LINUX-LSNS-TEST-NS, and it semantics is given and defined
> by iproute2 in userland; and nothing to do with util-linux.
> 
> However, the id, 0, is managed in linux kernel. If lsns can show
> the ids, it helps users understand the state of network namespaces.

Where iproute2 stores the logical name of the namespace (e.g.
UTIL-LINUX-LSNS-TEST-NS)? Cannot we read it? :-)

> +static int netnsid_xasputs(char **str, int netnsid)
> +{
> +	if (netnsid >= 0)
> +		return xasprintf(&str, "%d", netnsid);
> +#ifdef NETNSA_NSID_NOT_ASSIGNED
> +	else if (netnsid == NETNSA_NSID_NOT_ASSIGNED)
> +		return xasprintf(&str, "%s", "unassigned");
> +#endif
> +	else
> +		return xasprintf(&str, "%s", "n/a");

 We usually use blank space rather than n/a if data are not available.
 In this case "return NULL;" is good enough.

> +#ifdef HAVE_LINUX_NET_NAMESPACE_H
> +	netlink_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> +#endif
> +	if (netlink_fd < 0)
> +		netlink_fd = -errno;

 I guess this if() is unnecessary. The rest of the code check for
 netlink_fd < 0.
         
 It would be also nice to call socket() only if NETNSID column is wanted.

 What about to add NETNSID collumn to the default output only if "--type net"
 specified on lsns command line?

 I'm ready to do all the changes (you don't have to resend the patch).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
