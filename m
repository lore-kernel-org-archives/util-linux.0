Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755635Ab2ILKJW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Sep 2012 06:09:22 -0400
Date: Wed, 12 Sep 2012 12:09:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Giacomo <giacomo.perale@gmail.com>
Cc: util-linux@vger.kernel.org, Paul Fox <pgf@laptop.org>
Subject: Re: rtcwake doesn't reset wakealarm
Message-ID: <20120912100916.GB17256@x2.net.home>
References: <loom.20120911T131040-30@post.gmane.org>
 <loom.20120912T113440-886@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20120912T113440-886@post.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Let's add Paul to CC ;-)

On Wed, Sep 12, 2012 at 09:52:14AM +0000, Giacomo wrote:
> Giacomo <giacomo.perale@...> writes:
> 
> > I recently upgraded to util-linux 2.22 and I noticed that powertop started
> > reporting about 50-60 wakeups per second caused by rtc (interrupt 8). 
> > 
> > I quickly found out that this happened when I used rtcwake to wake up the
> > machine, and that after the reboot /sys/class/rtc/rtc0/wakealarm was still 
> > set to the scheduled wakeup time (now in the past). 
> > 
> > After a quick investigation I discovered that this is caused by commit
> > 1707576155daf644c5df3c1776b52fd297ff9318 ("rtcwake: only invoke RTC_AIE_ON/OFF
> > ioctls in pairs"): my system uses RTC_WKALM_SET so ioctl_aie_on stays false and
> > RTC_AIE_OFF doesn't get called.
> > 
> 
> Hi,
> 
> that commit also broke "disable". This is what happens on my system:
> 
> KazeNoTani ~ # cat /sys/class/rtc/rtc0/wakealarm
> KazeNoTani ~ # rtcwake -m show
> alarm: off
> KazeNoTani ~ # rtcwake -m no -s 300
> rtcwake: wakeup using /dev/rtc0 at Wed Sep 12 09:40:31 2012
> KazeNoTani ~ # rtcwake -m show
> alarm: on  Wed Sep 12 09:40:32 2012
> KazeNoTani ~ # cat /sys/class/rtc/rtc0/wakealarm
> 1347442831
> KazeNoTani ~ # rtcwake -m disable
> KazeNoTani ~ # rtcwake -m show
> alarm: on  Wed Sep 12 09:40:32 2012
> KazeNoTani ~ # cat /sys/class/rtc/rtc0/wakealarm
> 1347442831
> KazeNoTani ~ # echo 0 > /sys/class/rtc/rtc0/wakealarm
> KazeNoTani ~ # cat /sys/class/rtc/rtc0/wakealarm
> KazeNoTani ~ # rtcwake -m show
> alarm: off
> 
> 
> rtcwake -m disable doesn't remove the alarm. This is because as it is
> implemented now "-m disable" does nothing but break and rely on the call to
> RTC_AIE_OFF that was always done at the end of the execution of rtcwake, but now
> is conditional on "ioctl_aie_on" that doesn't get set in most cases.
> 
> Thanks,
> 
> Giacomo
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
