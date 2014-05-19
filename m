Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15102 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561AbaESJ30 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 05:29:26 -0400
Date: Mon, 19 May 2014 11:29:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/17] setterm: use getopt_long_only() for option parsing
Message-ID: <20140519092915.GF26357@x2.net.home>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <1400421941-14244-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400421941-14244-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 18, 2014 at 03:05:26PM +0100, Sami Kerola wrote:
> +static void set_opt_flag(int *opt)
> +{
> +	if (*opt)
> +		errx(EXIT_FAILURE, "duplicate use of an option");

 NLS.. _("duplicate use of an option")

> +	*opt = 1;
> +}

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
