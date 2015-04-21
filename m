Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33640 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932783AbbDUPut (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 21 Apr 2015 11:50:49 -0400
Received: by wiax7 with SMTP id x7so110506760wia.0
        for <util-linux@vger.kernel.org>; Tue, 21 Apr 2015 08:50:47 -0700 (PDT)
Date: Tue, 21 Apr 2015 17:50:45 +0200
From: Alexey Galakhov <agalakhov@gmail.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
Message-ID: <20150421175045.75d3ffe7@aga-ws-01>
In-Reply-To: <55366A6A.7010807@gmx.com>
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>
	<5534498B.4080803@gmx.com>
	<20150420092824.13611c6b@aga-ws-01>
	<55366A6A.7010807@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am Tue, 21 Apr 2015 11:19:06 -0400
schrieb J William Piggott <elseifthen@gmx.com>:

> So you are using the Hardware Clock as a reference to detect anomalies
> in the System Clock? You must have an exceptional Hardware Clock. It
> sounds as though you are using NTP, why not compare NTP time directly
> to your System time?

We just compare all available clocks (actually two) to find anomalies
in both. The anomalies we're looking for are really huge and even
visible with the naked eye (10000 ppm or more), so even a crude
Hardware Clock is more than enough.

The problem of using NTP is, we're running that on a bunch of
experimental devices. Some of them have no working network connection
as the hardware is not quite ready.

> I assume then, that you are only using columns one and two, because
> columns 3 and 4 are invalid output.

IN the beginning I used column 3. By examining the source code I
figured out that it is suitable for such kind of tests, at least
if /etc/adjtime is empty.

> Your test could capture timestamps without hwclock's compare
> function, yes?

Right now I reimplemented the whole (simplified) hwclock -c
functionality in my own test. In fact, I recalculate column 3 on my own.

What I really want to see is a "correct" column 3. In my test I'm doing
direct comparison. Pseudocode:

while(1) {
    do { // busy-wait
        t1 = clock_gettime();
        t2 = ioctl(RTC);
    } while t2 does not change;
    
    drift = (t1 - t2) / total time;

    sleep(until t1 + 990ms);
}

My test fails if a relative drift is more than expected with such a
hardware. This is useful to quickly detect stupid bugs like wrong PLL
configuration on new hardware ("time runs 10% faster" and so on). The
reason why we do so is, nobody really cares about the system clock
while installing the kernel and base system. Thus the problem is
detected only when the complete user level is up and running, and
nobody wants to touch the bootloader and the kernel at this time. So we
created a bunch of "early warning tests" to detect non-obvious kernel
and hardware issues.

Regards,
Alexey
