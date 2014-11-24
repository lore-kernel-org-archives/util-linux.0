Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56223 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbaKXKOX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 05:14:23 -0500
Date: Mon, 24 Nov 2014 11:14:15 +0100
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: RFC hwclock: refactoring
Message-ID: <20141124101415.GB926@x2.net.home>
References: <5470FE32.9030805@gmx.com>
 <CAG27Bk3zu-8Qar_k44uM3_8_kOddJkqvb1be1_KmjkBGfBGcYA@mail.gmail.com>
 <CAG27Bk1cCo_S0txKeFtAb3+oEQn9k24h9Ty7+E++Oxg93pVeQA@mail.gmail.com>
 <54728FF3.2020600@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54728FF3.2020600@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 23, 2014 at 08:54:59PM -0500, JWP wrote:
> I intentionally did not include --directisa and hwclock-cmos.c in my
> RFC, because my current position is that I2C access should remain in
> hwclock for troubleshooting and testing purposes.

Sure, hwclock-cmos.c is still usable.

> of the main development channel.  I wanted to see if the Alpha and 
> Award code was somehow important to someone.  My opinion is to remove
> it, but maybe there is something I am unaware of.

I think we don't have to care about Award workarounds at all.

Linux kernel provides RTC layer for Alpha, the question is usability,
but I think we can be optimistic and drop the alpha specific cmos code :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
