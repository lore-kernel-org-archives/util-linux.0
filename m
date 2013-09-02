Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3780 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758369Ab3IBJKh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Sep 2013 05:10:37 -0400
Date: Mon, 2 Sep 2013 11:10:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/17] last: use configuration struct
Message-ID: <20130902091028.GA1876@x2.net.home>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
 <1377626779-26030-15-git-send-email-kerolasa@iki.fi>
 <20130829101519.GE24438@x2.net.home>
 <20130829180631.GC28314@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130829180631.GC28314@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 29, 2013 at 07:06:33PM +0100, Sami Kerola wrote:
> +struct last_control {
> +	char lastb;		/* Is this command 'lastb' */
> +	char extended;		/* Lots of info */
> +	char showhost;		/* Show hostname */
> +	char altlist;		/* Hostname at the end */
> +	char usedns;		/* Use DNS to lookup the hostname */
> +	char useip;		/* Print IP address in number format */
> +	char fulltime;		/* Print full dates and times */

 BTW, it's C so use bit array next time :-)

     unsigned int lastb : 1,
                  ....

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
