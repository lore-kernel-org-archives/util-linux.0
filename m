Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63792 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161763Ab1FAINc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Jun 2011 04:13:32 -0400
Date: Wed, 1 Jun 2011 10:13:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/13] colrm: gotos, long options and argument checking
Message-ID: <20110601081326.GB24847@nb.net.home>
References: <1306270604-6154-1-git-send-email-kerolasa@iki.fi> <1306270604-6154-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306270604-6154-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 24, 2011 at 10:56:40PM +0200, Sami Kerola wrote:
> +int main(int argc, char **argv)
> +{
> +	unsigned long first = 0, last = 0;
> +	int opt;
> +
> +	static const struct option longopts[] = {
> +		{"version", no_argument, 0, 'V'},
> +		{"help", no_argument, 0, 'h'},
> +		{NULL, 0, 0, 0}
> +	};
> +
> +	setlocale(LC_ALL, "");
 
and

    bindtextdomain(PACKAGE, LOCALEDIR);
    textdomain(PACKAGE);

right?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
