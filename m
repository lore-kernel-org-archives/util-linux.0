Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752633AbdEQPFA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 May 2017 11:05:00 -0400
Date: Wed, 17 May 2017 17:04:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: versioning
Message-ID: <20170517150455.svjd332dyrq4zfyh@ws.net.home>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
 <201705171042.53414.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201705171042.53414.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 17, 2017 at 10:42:53AM +0200, Ruediger Meier wrote:
> v3 just to avoid big numbers. But could also be a hint regarding the 
> minimum supported/tested kernel version. I believe that we have already 
> a few incompatibilities for kernel <2.6.32. Maybe we could cleanup our 
> code, only supporting kernel >=3.1.

I'm almost sure we have users who use util-linux on old kernels. For
example RHEL6 with 2.6.32 is pretty common and I have no problem to
compile util-linux there. And sometimes we also backport patches from
util-linux upstream to RHEL6 etc ;-)

It's fine to kill things for 2.2 (etc.) but for I'd like to be
friendly to 2.6 users (if possible).

    Karel


./lscpu --version
lt-lscpu from util-linux 2.30-rc1-25-b7eb

$ ./lscpu
Architecture:        s390x
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Big Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s) per book:  1
Book(s):             4
Vendor ID:           IBM/S390
Machine type:        2827
BogoMIPS:            2913.00
Hypervisor vendor:   (null)
Virtualization type: full
Dispatching mode:    horizontal
Flags:               esan3 zarch stfle msa ldisp eimm dfp etf3eh highgprs

$ uname -a
Linux devel2.s390.bos.redhat.com 2.6.32-550.el6.s390x #1 SMP Fri Apr 3 10:12:50 EDT 2015 s390x s390x s390x GNU/Linux


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
