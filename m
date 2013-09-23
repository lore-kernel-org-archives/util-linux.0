Return-Path: util-linux-owner@vger.kernel.org
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:9997 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab3IWTAf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 23 Sep 2013 15:00:35 -0400
Message-ID: <1379962831.11845.3.camel@buesod1.americas.hpqcorp.net>
Subject: Re: [PATCH] lscpu: report cpu min mhz
From: Davidlohr Bueso <davidlohr@hp.com>
To: kerolasa@gmail.com
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Date: Mon, 23 Sep 2013 12:00:31 -0700
In-Reply-To: <CAG27Bk0eMtYkZdDLVdEjOO+-ZyYOShDDk2mo9_N_qiZCfhB-Jg@mail.gmail.com>
References: <1379821420.2145.50.camel@buesod1.americas.hpqcorp.net>
	 <CAG27Bk0eMtYkZdDLVdEjOO+-ZyYOShDDk2mo9_N_qiZCfhB-Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 2013-09-22 at 10:39 +0100, Sami Kerola wrote:
> On 22 September 2013 04:43, Davidlohr Bueso <davidlohr@hp.com> wrote:
> > The lscpu tool only shows the current and max CPU frequencies, however,
> > in many scenarios this is not enough. If there are energy saving situations
> > (like some CPUs being idle, or not fully used) the cpugov can lower this value.
> 
> Hi Davidlohr,
> 
> The patch seems to work as one might expect. Only small thing seems to require
> attention, tests broke again. Could you run in util-linux source directory
> 
> ./tests/run.sh lscpu
> 
> and adjust expected outputs accordingly?

This actually don't break for me, I get the following with or without
this patch:

-------------------- util-linux regression tests --------------------

                    For development purpose only.                    
                 Don't execute on production system!                 

        lscpu:                                ...
                : armv7                       ... FAILED (lscpu/lscpu-armv7)
                : ppc64-POWER7-64cpu          ... OK
                : ppc64-POWER7                ... OK
                : s390-kvm                    ... OK
                : s390-lpar                   ... OK
                : s390-zvm                    ... OK
                : x86_64-64cpu                ... FAILED (lscpu/lscpu-x86_64-64cpu)
                : x86_64-dell_e4310           ... FAILED (lscpu/lscpu-x86_64-dell_e4310)
           ... FAILED (3 from 8 sub-tests)

---------------------------------------------------------------------
  1 tests of 1 FAILED
---------------------------------------------------------------------

Also, these tests seem to bee arch-specific, so not sure how valuable
updating them would be.

Thanks,
Davidlohr


