Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:48791 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab2ILJwb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Sep 2012 05:52:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TBjcX-0004bK-IA
	for util-linux@vger.kernel.org; Wed, 12 Sep 2012 11:52:33 +0200
Received: from 94.247.8.10 ([94.247.8.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 12 Sep 2012 11:52:33 +0200
Received: from giacomo.perale by 94.247.8.10 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 12 Sep 2012 11:52:33 +0200
To: util-linux@vger.kernel.org
From: Giacomo <giacomo.perale@gmail.com>
Subject: Re: rtcwake doesn't reset wakealarm
Date: Wed, 12 Sep 2012 09:52:14 +0000 (UTC)
Message-ID: <loom.20120912T113440-886@post.gmane.org>
References: <loom.20120911T131040-30@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Giacomo <giacomo.perale@...> writes:

> I recently upgraded to util-linux 2.22 and I noticed that powertop started
> reporting about 50-60 wakeups per second caused by rtc (interrupt 8). 
> 
> I quickly found out that this happened when I used rtcwake to wake up the
> machine, and that after the reboot /sys/class/rtc/rtc0/wakealarm was still 
> set to the scheduled wakeup time (now in the past). 
> 
> After a quick investigation I discovered that this is caused by commit
> 1707576155daf644c5df3c1776b52fd297ff9318 ("rtcwake: only invoke RTC_AIE_ON/OFF
> ioctls in pairs"): my system uses RTC_WKALM_SET so ioctl_aie_on stays false and
> RTC_AIE_OFF doesn't get called.
> 

Hi,

that commit also broke "disable". This is what happens on my system:

KazeNoTani ~ # cat /sys/class/rtc/rtc0/wakealarm
KazeNoTani ~ # rtcwake -m show
alarm: off
KazeNoTani ~ # rtcwake -m no -s 300
rtcwake: wakeup using /dev/rtc0 at Wed Sep 12 09:40:31 2012
KazeNoTani ~ # rtcwake -m show
alarm: on  Wed Sep 12 09:40:32 2012
KazeNoTani ~ # cat /sys/class/rtc/rtc0/wakealarm
1347442831
KazeNoTani ~ # rtcwake -m disable
KazeNoTani ~ # rtcwake -m show
alarm: on  Wed Sep 12 09:40:32 2012
KazeNoTani ~ # cat /sys/class/rtc/rtc0/wakealarm
1347442831
KazeNoTani ~ # echo 0 > /sys/class/rtc/rtc0/wakealarm
KazeNoTani ~ # cat /sys/class/rtc/rtc0/wakealarm
KazeNoTani ~ # rtcwake -m show
alarm: off


rtcwake -m disable doesn't remove the alarm. This is because as it is
implemented now "-m disable" does nothing but break and rely on the call to
RTC_AIE_OFF that was always done at the end of the execution of rtcwake, but now
is conditional on "ioctl_aie_on" that doesn't get set in most cases.

Thanks,

Giacomo


