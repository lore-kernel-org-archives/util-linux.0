Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11554 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbaESJYc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 05:24:32 -0400
Date: Mon, 19 May 2014 11:24:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/17] setterm: use string utils to numeric parsing
Message-ID: <20140519092421.GE26357@x2.net.home>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <1400421941-14244-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1400421941-14244-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 18, 2014 at 03:05:27PM +0100, Sami Kerola wrote:
> +static int strtoint_or_err(const char *str)
> +{
> +	int64_t num = strtos64_or_err(str, _("argument error"));
> +
> +	if (num < INT_MIN || INT_MAX < num)
> +		errx(EXIT_FAILURE, _("argument error: %s"), str);
> +	return num;
> +}

 Why not strtos32_or_err() from lib/strutils.c ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
