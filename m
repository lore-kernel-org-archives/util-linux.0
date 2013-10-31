Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715Ab3JaL30 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Oct 2013 07:29:26 -0400
Date: Thu, 31 Oct 2013 12:29:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] cal: use control structure for run time
 configuration
Message-ID: <20131031112917.GC1536@x2.net.home>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
 <1382906556-16442-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382906556-16442-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 27, 2013 at 08:42:27PM +0000, Sami Kerola wrote:
> +struct cal_control {
> +	const char *full_month[MONTHS_IN_YEAR];	/* month names */
> +	int colormode;			/* day and week number highlight */
> +	int num_months;			/* number of months horizontally in print out */
> +	int weekstart;			/* day the week starts, often Sun or Mon */
> +	int wflag;			/* uses WEEK_NUM_ enum */
> +	int wnum;			/* requested --week=number */

 hmm... you duplicate information the struct
 
    wnum == wflag & WEEK_NUM_MASK 

 Anyway, I think the whole WEEK_NUM_MASK thing is unnecessary if you
 have the control struct, just use:

    struct cal_control {
      ...
      int weekstart;
      int weektype;     /* WEEK_TYPE_{NONE,ISO,US} */
      int weeknum;      /* --week=<num> */
      ...
    }

 Note more readable "week" rather than "w" prefix :-)

> -	if (wflag) {
> -		wflag = wnum & WEEK_NUM_MASK;
> -		wflag |= (weekstart == MONDAY ? WEEK_NUM_ISO : WEEK_NUM_US);
> +	if (ctl.wflag) {
> +		ctl.wflag = ctl.wnum & WEEK_NUM_MASK;
> +		ctl.wflag |= (ctl.weekstart == MONDAY ? WEEK_NUM_ISO : WEEK_NUM_US);
>  	}

 In the original code is wnum main()-only variable.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
