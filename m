Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.73]:51259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeF0F70 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 Jun 2018 01:59:26 -0400
Subject: Re: [PATCH] hwclock: stop supporting alpha cpu architecture
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20180626211343.4675-1-kerolasa@iki.fi>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <09cf76ad-032f-2e6c-0d67-e4c8ff5bb3f2@bernhard-voelker.de>
Date: Wed, 27 Jun 2018 07:58:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180626211343.4675-1-kerolasa@iki.fi>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/26/2018 11:13 PM, Sami Kerola wrote:
> @@ -255,16 +249,7 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
>  	} else {
>  		int rc;		/* Return code from ioctl */
>  		/* Turn on update interrupts (one per second) */
> -#if defined(__alpha__) || defined(__sparc__)
> -		/*
> -		 * Not all alpha kernels reject RTC_UIE_ON, but probably
> -		 * they should.
> -		 */
> -		rc = -1;
> -		errno = EINVAL;
> -#else
>  		rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
> -#endif

Are you sure you want to change the code path for SPARC?

Have a nice day,
Berny
