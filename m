Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43576 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756207AbaGXJ4N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jul 2014 05:56:13 -0400
Date: Thu, 24 Jul 2014 11:55:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Kodiak Firesmith <ksf@sei.cmu.edu>
Subject: Re: [PATCH 07/10] logger: add rfc5424 support
Message-ID: <20140724095556.GK26781@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
 <1406066459-4816-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406066459-4816-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 22, 2014 at 11:00:56PM +0100, Sami Kerola wrote:
>  struct logger_ctl {
> @@ -82,6 +85,9 @@ struct logger_ctl {
>  	int logflags;
>  	int pri;
>  	char *tag;
> +	unsigned int	rfc5424_time:1,
> +			rfc5424_tq:1,

 what does it mean "_tq"? It's always good idea use comments for flags
 and struct members :-)

> +	fputs(_("     --rfc3164         use the BSD syslog protocol\n"), out);

 "use obsolete BSD syslog protocol"
      ^^^^^^^

> +				parse_rfc5424(&ctl, optarg);

   parse_rfc5424_flags()

 or so...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
