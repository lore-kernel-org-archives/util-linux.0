Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:43480 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758958Ab2IKLZC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Sep 2012 07:25:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TBOaV-0001xW-PA
	for util-linux@vger.kernel.org; Tue, 11 Sep 2012 13:25:03 +0200
Received: from 94.247.8.10 ([94.247.8.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 11 Sep 2012 13:25:03 +0200
Received: from giacomo.perale by 94.247.8.10 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 11 Sep 2012 13:25:03 +0200
To: util-linux@vger.kernel.org
From: Giacomo <giacomo.perale@gmail.com>
Subject: rtcwake doesn't reset wakealarm
Date: Tue, 11 Sep 2012 11:11:46 +0000 (UTC)
Message-ID: <loom.20120911T131040-30@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I recently upgraded to util-linux 2.22 and I noticed that powertop started
reporting about 50-60 wakeups per second caused by rtc (interrupt 8). 

I quickly found out that this happened when I used rtcwake to wake up the
machine, and that after the reboot /sys/class/rtc/rtc0/wakealarm was still set
to the scheduled wakeup time (now in the past). Resetting it to 0 with "echo 0 >
/sys/class/rtc/rtc0/wakealarm" made the interrupt stop.

After a quick investigation I discovered that this is caused by commit
1707576155daf644c5df3c1776b52fd297ff9318 ("rtcwake: only invoke RTC_AIE_ON/OFF
ioctls in pairs"): my system uses RTC_WKALM_SET so ioctl_aie_on stays false and
RTC_AIE_OFF doesn't get called.

I removed the check to revert to the previous behaviour and after my machine
rebooted /sys/class/rtc/rtc0/wakealarm was correctly (I suppose) set to 0, rtc
didn't fire regular interrupts anymore and there were apparently no negative
consequences.

Is this a bug or am I missing something?

Thanks,

Giacomo

PS. I'm not subscribed to the list so please cc me if you need other information.

