Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43242 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbbGIHUL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jul 2015 03:20:11 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id B5E96ABC
	for <util-linux@vger.kernel.org>; Thu,  9 Jul 2015 07:20:11 +0000 (UTC)
Received: from falcon.thewalter.lan (ovpn-116-75.ams2.redhat.com [10.36.116.75])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t697K9if017289
	for <util-linux@vger.kernel.org>; Thu, 9 Jul 2015 03:20:10 -0400
Subject: Re: [PATCH] agetty: Reprompt once the network addresses change if
 address displayed
To: util-linux@vger.kernel.org
References: <1435928288-25644-1-git-send-email-stefw@redhat.com>
 <20150706140711.GF17734@vapier>
From: Stef Walter <stefw@redhat.com>
Message-ID: <559E20A9.7010307@redhat.com>
Date: Thu, 9 Jul 2015 09:20:09 +0200
MIME-Version: 1.0
In-Reply-To: <20150706140711.GF17734@vapier>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06.07.2015 16:07, Mike Frysinger wrote:
> On 03 Jul 2015 14:58, Stef Walter wrote:
>   #ifdef AGETTY_RELOAD
>>  # include <sys/inotify.h>
>> +# include <linux/netlink.h>
>> +# include <linux/rtnetlink.h>
> 
> why not use libmnl instead ?
> 	http://netfilter.org/projects/libmnl

I'm only a sporadic contributor to util-linux. I felt that adding a
dependency to util-linux wasn't my place to suggest. In addition this
patch performs very very simple usage of the netlink socket. We don't
even look at message data.

However the mantainers feel this is a better approach, I'd be happy to
implement it this way. Are you a maintainer of util-linux (sorry for the
dumb question)?

>> +static void open_netlink(void)
>> +{
>> ...
>> +		if (bind(sock,(struct sockaddr *)&addr, sizeof(addr)) < 0)
> 
> need space after the first ,

<snip>

Fixed all of these other review items and pushed the patch here:

https://github.com/stefwalter/util-linux/commits/agetty-addrchange

I'd be happy to repost the patch to the mailing list once a maintainer
decides on whether libmnl is necessary or not.

Stef

