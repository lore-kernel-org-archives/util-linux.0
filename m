Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751464AbeCTR54 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Mar 2018 13:57:56 -0400
Date: Tue, 20 Mar 2018 18:57:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: util-linux@vger.kernel.org, wild@linux.vnet.ibm.com,
        alkl@linux.vnet.ibm.com
Subject: Re: [PATCH] lsmem: fix total online/offline memory calculation
Message-ID: <20180320175753.s4gmu2mvtaj2avp3@ws.net.home>
References: <20180320161738.49439-1-gerald.schaefer@de.ibm.com>
 <20180320184743.09c3375a@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320184743.09c3375a@thinkpad>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 20, 2018 at 06:47:43PM +0100, Gerald Schaefer wrote:
> On Tue, 20 Mar 2018 17:17:38 +0100
> Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:
> 
> > lsmem currently calculates the total online/offline memory by iterating
> > over all lsmem->blocks. Depending on the lsmem options, there may be
> > only one lsmem->block, because all sysfs memory blocks could be merged
> > into one. In this case, the calculation is wrong, because the individual
> > online/offline state of the sysfs memory blocks is not preserved, but
> > rather lsmem->blocks[0].state is set to the state of the first sysfs
> > memory block, typically MEMORY_STATE_ONLINE (at least on s390).
> > 
> > This means that "Total offline memory" will always be calculated as 0
> > in such cases, e.g. when using "lsmem --summary", or any options that
> > would merge the table output to one line, like "lsmem -o RANGE":
> > 
> > ~# lsmem --summary
> > Memory block size:         1G
> > Total online memory:      20G
> > Total offline memory:      0B
> > 
> > Adding the "-a" option shows the real summary, since there is no block
> > merging going on, and the calculation is therefore correct:
> > 
> > ~# lsmem -a --summary
> > Memory block size:         1G
> > Total online memory:      16G
> > Total offline memory:      4G
> > 
> > Fix this by moving the online/offline calculation into the loop that
> > is iterating over all sysfs memory blocks, instead of iterating over
> > potentially merged lsmem->blocks.
> > 
> > Reported-by: Andre Wild <wild@linux.vnet.ibm.com>
> 
> Sorry, I mixed that up, this bug was
> Reported-by: Alexander Klein <alkl@linux.vnet.ibm.com>

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
