Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbcFXINN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jun 2016 04:13:13 -0400
Date: Fri, 24 Jun 2016 10:13:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: hwclock issue: RTC_SET_DELAY_SECS = 0.5s assumption not always
 true
Message-ID: <20160624081310.wwtekaxjtj6dlqgv@ws.net.home>
References: <c842577c-850e-16bb-f434-10260cffe720@bitwise.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c842577c-850e-16bb-f434-10260cffe720@bitwise.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 16, 2016 at 04:43:44PM +0300, Anssi Hannula wrote:
> -       const double RTC_SET_DELAY_SECS = 0.5;      /* 500 ms */
> +       const double RTC_SET_DELAY_SECS = 0.0;      /* 0 ms */
> Then it works with MC34708, but this obviously breaks it with other RTCs.

Is there a way how to detect currently used HW (/sys/class/rtc/name) ?
If yes, we can set the delay. The another possible way would be to
add command line option (--delay-on-set <ms>).
    
        Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
