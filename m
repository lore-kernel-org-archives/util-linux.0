Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42993 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959AbbBWUch (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Feb 2015 15:32:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C2BDC20915
	for <util-linux@vger.kernel.org>; Mon, 23 Feb 2015 15:32:33 -0500 (EST)
Message-Id: <1424723554.3616066.231389761.392C999E@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1424616139-638-7-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
 <1424616139-638-7-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 06/13] rtcwake: add human readable --date timestamp format
Date: Mon, 23 Feb 2015 21:32:34 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:42, Sami Kerola wrote:
> +.BR \-\-date " \fItimestamp"

.BI \-\-date " timestamp"

> +Set the wakeup time to the value of the timestamp.  Format of the
> +timestmap can be any of the following:

s/the timestamp.  Format of the timestmap/
  \fItimestamp\fR.  The format of \fItimestamp\fR/

> +	fputs(_("     --date <timestamp>   date time of timestamp to wake\n"), out);

s:date time of timestamp to wake:date and/or time to wake:

> +				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);

s:time:date/time:

Benno

-- 
http://www.fastmail.com - IMAP accessible web-mail

