Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdFMNQq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 09:16:46 -0400
Date: Tue, 13 Jun 2017 15:16:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/11] uuidgen: add --date option to display time when
 uuid was generated
Message-ID: <20170613131627.ajcqe2k6gicrtelv@ws.net.home>
References: <20170608195215.1702-1-kerolasa@iki.fi>
 <20170608195215.1702-6-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608195215.1702-6-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 08, 2017 at 08:52:09PM +0100, Sami Kerola wrote:
> The uuidgen has always had option to use time as a uuid value.  To common
> users these timestamps have been difficult to convert to readable format, so
> add an option to do that.

The name of the tool is uuidgen and at first glance it seems like
--date is a way how to use a different time than the current ;-)

Maybe it would be better to create a small independent tool uuidparse
and print all available details about UUID (variant, type and time).

 $ uuidparse  7e400110-3e4a-11e7-8af1-00037f500001
 variant: DCE
 type: time
 time: 2017-05-21 17:25:32,471528+0000

 $ uuidparse --time
 2017-05-21 17:25:32,471528+0000

 It would be also nice to accept more than one UUID on command line/stdin.

or so... Comments?

 See libuuid/src/uuid_time.c where is test program.

> +static int print_uuid_date(char *date)
> +{
> +	uuid_t uuid;
> +	struct timeval tv;
> +	char buf[ISO_8601_BUFSIZ];
> +
> +	if (uuid_parse(date, uuid)) {
> +		printf(_("invalid uuid: %s\n"), date);

 "failed to parse UUID" sounds better

> +		return 1;
> +	}

Maybe you want to check UUID type and variant, only DCE time is
supported.

I think separated pull request would be better ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
