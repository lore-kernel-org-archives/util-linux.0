Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:51911 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbaGCM70 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Jul 2014 08:59:26 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <suzuki@in.ibm.com>;
	Thu, 3 Jul 2014 18:29:24 +0530
Message-ID: <53B553A4.6070407@in.ibm.com>
Date: Thu, 03 Jul 2014 18:29:16 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>,
        Janani Venkataraman <jananive@linux.vnet.ibm.com>,
        Karel Zak <kzak@redhat.com>
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/33] [RFC] Non disruptive application core dump infrastructure
References: <20140320093040.14878.903.stgit@localhost.localdomain> <20140321080855.GE26374@x2.net.home> <532C54A3.3030903@ubuntu.com> <532FFE3A.9060002@linux.vnet.ibm.com> <53303927.1030004@ubuntu.com>
In-Reply-To: <53303927.1030004@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/24/2014 07:24 PM, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 3/24/2014 5:43 AM, Janani Venkataraman wrote:
>> Gcore attaches to the process using gdb and runs the gdb gcore
>> command and then detaches. In gcore the dump cannot be issued from
>> a signal handler context as fork() is not signal safe and moreover
>> it is disruptive in
> 
> You can fork+exec from a signal handler just fine.
Please go through the bug, and especially the comment below :

https://sourceware.org/bugzilla/show_bug.cgi?id=4737#c12

Cheers
Suzuki

