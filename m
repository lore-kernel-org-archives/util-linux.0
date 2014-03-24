Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:33946 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbaCXJnd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Mar 2014 05:43:33 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <jananive@linux.vnet.ibm.com>;
	Mon, 24 Mar 2014 15:13:30 +0530
Message-ID: <532FFE3A.9060002@linux.vnet.ibm.com>
Date: Mon, 24 Mar 2014 15:13:22 +0530
From: Janani Venkataraman <jananive@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>, Karel Zak <kzak@redhat.com>
CC: amwang@redhat.com, rdunlap@xenotime.net, andi@firstfloor.org,
        aravinda@linux.vnet.ibm.com, hch@lst.de, mhiramat@redhat.com,
        jeremy.fitzhardinge@citrix.com, xemul@parallels.com,
        suzuki@linux.vnet.ibm.com, kosaki.motohiro@jp.fujitsu.com,
        adobriyan@gmail.com, tarundsk@linux.vnet.ibm.com, vapier@gentoo.org,
        roland@hack.frob.com, tj@kernel.org, ananth@linux.vnet.ibm.com,
        gorcunov@openvz.org, avagin@openvz.org, oleg@redhat.com,
        eparis@redhat.com, d.hatayama@jp.fujitsu.com, james.hogan@imgtec.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        coreutils@gnu.org, procps@freelists.org, util-linux@vger.kernel.org,
        util-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/33] [RFC] Non disruptive application core dump infrastructure
References: <20140320093040.14878.903.stgit@localhost.localdomain> <20140321080855.GE26374@x2.net.home> <532C54A3.3030903@ubuntu.com>
In-Reply-To: <532C54A3.3030903@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 03/21/2014 08:32 PM, Phillip Susi wrote:
> On 3/21/2014 4:17 AM, Karel Zak wrote:
>> The gencore command looks like a good idea, but why we need the
>> client-server infrastructure? At least at first glance it seems
>> like overkill.
> Yes, the server seems pointless.
>
>>> We would like to push this to one of the following packages: a)
>>> util-linux b) coreutils c) procps-ng
>> d) somewhere near to gdb :-)
> gdb already has such a thing; it's called gcore.  Kind of makes this
> work seem redundant?

Gcore attaches to the process using gdb and runs the gdb gcore command
and then detaches. In gcore the dump cannot be issued from a signal handler
context as fork() is not signal safe and moreover it is disruptive in nature as the
gdb attaches using ptrace which sends a SIGSTOP signal. Hence the gcore method
cannot be used if the process wants to initiate a self dump as well.
The following link points to a discussion regarding why not gcore.

https://lkml.org/lkml/2013/9/3/122

>

