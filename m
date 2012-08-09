Return-Path: util-linux-owner@vger.kernel.org
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:38308 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab2HIH7K (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 Aug 2012 03:59:10 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 9 Aug 2012 08:59:08 +0100
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q797wxol2113690
	for <util-linux@vger.kernel.org>; Thu, 9 Aug 2012 08:58:59 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q797wxQf031902
	for <util-linux@vger.kernel.org>; Thu, 9 Aug 2012 01:58:59 -0600
Date: Thu, 9 Aug 2012 09:58:59 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: faizan husain <faizanh@linux.vnet.ibm.com>
Cc: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: limit options --all, --online, --offline to
 parsable and extended output
Message-ID: <20120809075859.GA6814@osiris.de.ibm.com>
References: <20120808085911.GA3441@osiris.de.ibm.com>
 <50235651.6030409@linux.vnet.ibm.com>
 <20120809065759.GA3930@osiris.de.ibm.com>
 <50236466.2030906@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50236466.2030906@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 09, 2012 at 12:49:02PM +0530, faizan husain wrote:
> On Thursday 09 August 2012 12:27 PM, Heiko Carstens wrote:
> >>  [root@mx3650m2 ~]# lscpu -a
> >That wouldn't work with the patch above applied (and without the patch
> >applied there wouldn't be any difference in the output, regardless if you
> >would specify "-a" or not).
> >
> >So.. I don't understand what your concern is.
> 
> My concern here is, earlier we used to print all the column information with
> -a, -b(limit online and other column info), -c(limit offline and other column info.
> 
> but with your patch we are certainly going to miss other information?
> 
> here is output from you patch:
> 
> [root@mx3650m2 ~]# lscpu -a
> lscpu: options --all, --online and --offline may only be used with options --extended or --parsable.
> 
> [root@mx3650m2 util-linux-2.21.1]# lscpu -ae
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE
> 0   0    0      0    0:0:0:0       yes
> 1   0    0      1    1:1:1:0       yes

[...]

> so only CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE are printed with your patch.
> other column like Architecture, CPU op-mode(s), Byte Order, Thread(s) per core,
> vendors ID, CPU family etc... user are going to miss.

lscpu never printed columns for architecture, threads per core etc. for the
extended and parsable output. My patch doesn't make any difference here.
Also it doesn't make any sense to print such static and identical information
for each and every cpu line.

The purpose of the extended and parsable output is to give the user an overview
of the cpu topology and per cpu attributes.
It's purpose is certainly not to give an overview of the whole system.

