Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12407 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934579AbaEFK4t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 06:56:49 -0400
Date: Tue, 6 May 2014 12:56:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] hwclock: Fix excessive adjustment
Message-ID: <20140506105645.GN5962@x2.net.home>
References: <1399315741.11780.36.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399315741.11780.36.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 05, 2014 at 08:49:01PM +0200, Stanislav Brabec wrote:
> Algorithm of calculation of hwclock adjustment is vulnerable to
> miscalculations. These miscalculations may lead to clock drifting by
> many years even after fixing CMOS hwclock failure.
> 
> Following two patches are attempts to solve the most visible parts of
> the problem:
> - Calculation of excessive drift values in /etc/adjtime
> - Applying of excessive drift that causes many years clock failure.
> - It also prevents hangs before 4a44a54b.

 Applied, thanks.

> There are further poor places in the code that are above the scope of
> this patch set:
> - Algorithm for detecting of invalid hwclock is very poor (valid_p fails
>   only if hwclock output fails to pass mktime()).
> - There is no or failing discrimination between fine time adjustment and
>   clock set.
> - In particular, proposed patch does not cover miscalculation while
>   changing clock due to DST change, and more than 2 days passed since
>   last adjustment. This could be covered by lowering of MAX_DRIFT, but
>   heuristics for discrimination between adjustment and clock setting
>   would be much better.
> - Most of failures fixed by these patches were hidden by a poor
>   calculation of time passed since last adjustment:
>   if ((hclocktime - adjtime_p->last_calib_time) < 23 * 60 * 60)
>   (As there is no abs(), all times in past were considered as "less than
>   one day ago".)

Look forward to see another patches ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
