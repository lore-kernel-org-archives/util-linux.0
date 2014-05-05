Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53578 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754953AbaEEIYm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 04:24:42 -0400
Message-Id: <1399278280.10915.113698213.4CBE794E@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 04/15] cytune: use single loop for setting and getting
 ioctl() calls
Date: Mon, 05 May 2014 10:24:40 +0200
In-Reply-To: <1399218596-21321-5-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
 <1399218596-21321-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi Sami,

On Sun, May 4, 2014, at 17:49, Sami Kerola wrote:
> +		if (set_threshold)
> +			if (ioctl(file, CYSETTHRESH, threshold_val))
> +				err(EXIT_FAILURE, _("cannot set %s to threshold %d"), argv[i], threshold_val);
> +
> +		if (set_threshold_def)
> +			if (ioctl(file, CYSETDEFTHRESH, threshold_def_val))
> +				err(EXIT_FAILURE, _("cannot set %s to threshold %d"), argv[i], threshold_def_val);

Shouldn't the latter message contain the word "default"?

> +		if (set_timeout)
> +			if (ioctl(file, CYSETTIMEOUT, timeout_val))
> +				err(EXIT_FAILURE, _("cannot set %s to time threshold %d"), argv[i], timeout_val);

s/time threshold/timeout/ ?

> +		if (set_timeout_def)
> +			if (ioctl(file, CYSETDEFTIMEOUT, timeout_def_val))
> +				err(EXIT_FAILURE, _("cannot set %s to time threshold %d"), argv[i], timeout_def_val);

s/time threshold/default timeout/ ?

> +		if (get_defaults) {
> +			if (ioctl(file, CYGETDEFTHRESH, &threshold_value))
> +				err(EXIT_FAILURE, _("cannot get threshold for %s"), argv[i]);
> +			if (ioctl(file, CYGETDEFTIMEOUT, &timeout_value))
> +				err(EXIT_FAILURE, _("cannot get timeout for %s"), argv[i]);

Again the words "default"?

Benno

-- 
http://www.fastmail.fm - mmm... Fastmail...

