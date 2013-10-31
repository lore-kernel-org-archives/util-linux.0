Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49106 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807Ab3JaLuI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Oct 2013 07:50:08 -0400
Date: Thu, 31 Oct 2013 12:49:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] cal: make user request to be part of read-only
 control struct
Message-ID: <20131031114958.GE1536@x2.net.home>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
 <1382906556-16442-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382906556-16442-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 27, 2013 at 08:42:33PM +0000, Sami Kerola wrote:
> +struct cal_request {
> +	int day;
> +	int month;
> +	long year;
> +	int week;
> +};

 It makes more sense than cal_width :-)

> +			ctl.req.day = day_in_year(ctl.req.day, ctl.req.month, ctl.req.year);

   req.day = calculate_request_day(&req);

> -static void monthly(int day, int month, long year, const struct cal_control *ctl)
> +static void monthly(const struct cal_control *ctl)
...  
> -	rows = do_monthly(day, month, year, &out, -1, ctl);
> +	rows = do_monthly(ctl->req.day, ctl->req.month, ctl->req.year, &out, -1, ctl);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Well, if you have a request struct then use it!

      do_monthly(req, &out, -1, ctl);


 Maybe you can keep request and control structs independent, so then
 one day you can implement something like  
 
    cal --date=Dec-2013 --date=Dec-2014

 to print more independent calendars :-)

 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
