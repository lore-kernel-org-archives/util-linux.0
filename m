Return-Path: util-linux-owner@vger.kernel.org
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:53973 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbaB1Hx7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Feb 2014 02:53:59 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 28 Feb 2014 07:53:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7DCF5219005C
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2014 07:53:53 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s1S7riZL52297828
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2014 07:53:44 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s1S7ruAG024055
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2014 00:53:56 -0700
Date: Fri, 28 Feb 2014 08:53:55 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: chcpu exit code?
Message-ID: <20140228075355.GB4216@osiris>
References: <530F0972.3040205@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <530F0972.3040205@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 27, 2014 at 10:46:26AM +0100, Bernhard Voelker wrote:
> Although the man page does not mention the exit status, I think
> it's wrong that 'chcpu' exits OK when an action failed or
> when a bad CPU number was specified:
> 
>   $ ./chcpu -d 0 ; echo $?
>   CPU 0 is not hot pluggable
>   0
> 
>   $ ./chcpu -g 3 ; echo $?
>   CPU 3 is not configurable
>   0
> 
>   $ ./chcpu -e 4 ; echo $?
>   CPU 4 does not exist
>   0
> 
> WDYT?

The question is: what should chcpu return if it partially succeeded?

# chcpu -d 3-4
CPU 3 disabled
CPU 4 does not exist

If I remember correctly this was the reason to make it always return 0.

However, it is indeed valid to say if *everything* failed, it should
return an error. Hm?

