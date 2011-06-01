Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57464 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161605Ab1FAIMR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Jun 2011 04:12:17 -0400
Date: Wed, 1 Jun 2011 10:12:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 08/13] col: check with strtol_or_err option argument
Message-ID: <20110601081210.GA24847@nb.net.home>
References: <1306270604-6154-1-git-send-email-kerolasa@iki.fi> <1306270604-6154-9-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306270604-6154-9-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 24, 2011 at 10:56:39PM +0200, Sami Kerola wrote:
>  		case 'l':		/* buffered line count */
> -			if ((max_bufd_lines = atoi(optarg)) <= 0)
> -				errx(EXIT_FAILURE, _("bad -l argument %s."), optarg);
> +			tmplong = strtoul_or_err(optarg, _("bad -l argument"));
> +			if ((INT_MAX / 2) < tmplong)

 Why we need this magical (INT_MAX / 2) limit?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
