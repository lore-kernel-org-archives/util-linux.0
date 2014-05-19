Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47050 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbaESJjG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 05:39:06 -0400
Date: Mon, 19 May 2014 11:38:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 06/17] setterm: add option control structure
Message-ID: <20140519093855.GG26357@x2.net.home>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <1400421941-14244-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400421941-14244-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 18, 2014 at 03:05:30PM +0100, Sami Kerola wrote:
> +			ctl->opt_repeat = set_opt_flag(ctl->opt_repeat);
> +			ctl->opt_rep_on = parse_switch(optarg, "on", "off");
...
> +			ctl->opt_foreground = set_opt_flag(ctl->opt_foreground);
> +			ctl->opt_fo_color = parse_febg_color(optarg);

It would be nice (by another patch!) consolidate the names of the
options. For example opt_foreground and opt_fo_color is brain dead.
What about:

     ctl->opt_repeat
     ctl->opt_repeat_on

and

     ctl->opt_foreground
     ctl->opt_foreground_color

etc. Maybe the whole "opt_" prefix is unnecessary.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
