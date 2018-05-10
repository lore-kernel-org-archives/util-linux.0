Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756741AbeEJJip (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 May 2018 05:38:45 -0400
Date: Thu, 10 May 2018 11:38:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: Michael Matz <matz@suse.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Avoid use of the old CPU macros
Message-ID: <20180510093842.zahlwrsxdmjpmmp2@ws.net.home>
References: <2985b3d2-facd-13f1-10f7-bc265edfed6d@suse.cz>
 <alpine.LSU.2.21.1805091812050.12477@wotan.suse.de>
 <e77e06a7-12a5-2e53-42ff-78e337bb6d14@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e77e06a7-12a5-2e53-42ff-78e337bb6d14@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 09, 2018 at 06:26:16PM +0200, Stanislav Brabec wrote:
> Michael Matz wrote:
> > On Wed, 9 May 2018, Stanislav Brabec wrote:
> >>  	for (cpu = 0; cpu < setsize; cpu++) {
> >> -		if (!CPU_ISSET(cpu, cpu_set))
> >> +		if (!CPU_ISSET_S(cpu, setsize, cpu_set))
> > 
> > Careful, the _S macros count the size in _bytes_, the above loop iterates 
> > in nr-of-cpus (i.e. bits), or alternatively if the caller really gives a 
> > byte size then the loop iterations don't catch all CPUs.  More instances 
> > follow.
> 
> setsize passed to the function is CPU_ALLOC_SIZE(maxcpus).
> 
> Do I understand correctly that the new !CPU_ISSET_S is correct, but the
> loop limit should be maxcpus?

I think so, setsize is aligned (in bytes) to handle maxsize (bits).
The loop is incorrect, should be maxcpus. I'll fix.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
