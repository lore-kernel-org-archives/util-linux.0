Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33524 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756404Ab3H2KJb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Aug 2013 06:09:31 -0400
Date: Thu, 29 Aug 2013 12:09:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/17] last: parse easy to use time formats
Message-ID: <20130829100919.GC24438@x2.net.home>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
 <1377626779-26030-11-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377626779-26030-11-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 27, 2013 at 07:06:13PM +0100, Sami Kerola wrote:
>  		case 'p':
>  			present = parsetm(optarg);
> -			if (present == (time_t) -1)
> +			if (present != (time_t) -1)
> +				break;
> +			if (parse_timestamp(optarg, &p) < 0)
>  				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
> +			present = (time_t) (p / 1000000);
>  			break;

 It would be better to add support for YYYYMMDDHHMMSS into
 parse_timestamp() rather than maintain and use two parsers.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
