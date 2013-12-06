Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab3LFKH1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 6 Dec 2013 05:07:27 -0500
Date: Fri, 6 Dec 2013 11:07:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/13] cal: use month contents structure for --three
 printing
Message-ID: <20131206100718.GD16891@x2.net.home>
References: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
 <1384107820-498-13-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384107820-498-13-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> +	struct cal_month m1, m2, m3, *i;
> +	int first_month;
> +	long first_year;
> +
> +	m1.next = &m2;
> +	m2.next = &m3;
> +	m3.next = NULL;
 ...
> +	set_consecutive_months(&m1, first_month, first_year);

Maybe you can add something like:

  m1 = cal_new_months(clt->req);

to allocate and initialize all necessary months and join all to the
list according to the user's request (where should be info if whole year
or 1 or 3 months are requested).

And then ... cal_free_months()

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
