Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:49732 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527AbbDUTNF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Apr 2015 15:13:05 -0400
Message-ID: <5536A139.9030905@gmx.com>
Date: Tue, 21 Apr 2015 15:12:57 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Alexey Galakhov <agalakhov@gmail.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>	<5534498B.4080803@gmx.com>	<20150420092824.13611c6b@aga-ws-01>	<55366A6A.7010807@gmx.com> <20150421175045.75d3ffe7@aga-ws-01>
In-Reply-To: <20150421175045.75d3ffe7@aga-ws-01>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 04/21/2015 11:50 AM, Alexey Galakhov wrote:
> Am Tue, 21 Apr 2015 11:19:06 -0400
> schrieb J William Piggott <elseifthen@gmx.com>:
> 
>> I assume then, that you are only using columns one and two, because
>> columns 3 and 4 are invalid output.
> 
> IN the beginning I used column 3. By examining the source code I
> figured out that it is suitable for such kind of tests, at least
> if /etc/adjtime is empty.
> 
>> Your test could capture timestamps without hwclock's compare
>> function, yes?
> 
> Right now I reimplemented the whole (simplified) hwclock -c
> functionality in my own test. In fact, I recalculate column 3 on my own.
> 
> What I really want to see is a "correct" column 3. In my test I'm doing
> direct comparison.

So you are confirming my position that hwclock's compare function is
broken and that you are not using it for any useful purpose.


> Pseudocode:
> 
> while(1) {
>     do { // busy-wait
>         t1 = clock_gettime();
>         t2 = ioctl(RTC);
>     } while t2 does not change;
>     
>     drift = (t1 - t2) / total time;
> 
>     sleep(until t1 + 990ms);
> }
> 
> My test fails if a relative drift is more than expected with such a
> hardware. This is useful to quickly detect stupid bugs like wrong PLL
> configuration on new hardware ("time runs 10% faster" and so on). The
> reason why we do so is, nobody really cares about the system clock
> while installing the kernel and base system. Thus the problem is
> detected only when the complete user level is up and running, and
> nobody wants to touch the bootloader and the kernel at this time. So we
> created a bunch of "early warning tests" to detect non-obvious kernel
> and hardware issues.

Thank you for the detailed explanation Alexey. I can see how comparing
the System and Hardware clocks is useful for your situation and worthy
of a specialize test as you have written. In my opinion, comparing two
drifting clocks is not useful to end users, system administrators, or
distribution maintainers and I am hopeful that Karel will agree to its
removal from hwclock.

> 
> Regards,
> Alexey
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
