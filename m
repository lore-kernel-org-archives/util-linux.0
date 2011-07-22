Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34651 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917Ab1GVK5e (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Jul 2011 06:57:34 -0400
Date: Fri, 22 Jul 2011 12:57:30 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: ionice: requires scheduling since
	7ab08ba3e5e6f161b93ff2b3b7d5b18dc7b44510
Message-ID: <20110722105730.GT22568@nb.net.home>
References: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3A66@MCHP058A.global-ad.net> <20110722085420.GP22568@nb.net.home> <7856072A9D04C24B82DFE2B1112FE38A08FE2D3AC2@MCHP058A.global-ad.net> <20110722094304.GQ22568@nb.net.home> <7856072A9D04C24B82DFE2B1112FE38A08FE2D3B4F@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3B4F@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 22, 2011 at 12:21:08PM +0200, Voelker, Bernhard wrote:
> Karel Zak wrote:
> 
> > Fixed.
> > 
> >  I've also added support for human readable class names, you can use:
> > 
> >    ionice -c best-effort /bin/foo
> 
> great, thanks!
> 
> One last corner case regarding -t (ignoring failure):
> 
>   $ schedutils/ionice -c 4 -t  schedutils/ionice 
>   ionice: bad prio class 4
>   $ schedutils/ionice -n 8 -t  schedutils/ionice 
>   idle
> 
> With -c, a bad prio class leads to a failure, while it doesn't with -n.
> Is this intended?

OK. Copy & past from the latest commit:

    ionice: make -t more tolerant
    
    * replace errx() with warnx() for unknown -c class
    
      The right place to check I/O scheduler features is in kernel. We should
      not try to be more smart than kernel.
    
    * make the code ready (robust) for unknown sched.classes
    
    * fix -t behavior
    
    	old version:
    	  $ ionice -c 4 -t bash
    	  ionice: bad prio class 4
    
    	new version:
    	  $ ionice -c 4 -t bash
    
    Reported-by: Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
    Signed-off-by: Karel Zak <kzak@redhat.com>

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
