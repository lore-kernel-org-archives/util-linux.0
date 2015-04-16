Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:38475
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbbDPUnI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 16 Apr 2015 16:43:08 -0400
Date: Thu, 16 Apr 2015 22:36:04 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Serge Schneider <serge@raspberrypi.org>
Subject: hwclock's synchronize_to_clock_tick_rtc returns inconsistent values
Message-ID: <20150416203604.GA6523@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello!

The below forwarded issue seems to have been introduced in
commit ab8f402952301106ad0bd5c5a51dc
"hwclock: don't confuse users with select() timeout warning"

This issue is also tracked at http://bugs.debian.org/782726

Regards,
Andreas Henriksson

----- Forwarded message from Serge Schneider <serge@raspberrypi.org> -----

Date: Thu, 16 Apr 2015 20:24:26 +0100
From: Serge Schneider <serge@raspberrypi.org>
To: submit@bugs.debian.org
Subject: Bug#782726: util-linux: hwclock's synchronize_to_clock_tick_rtc
	returns inconsistent values
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
	Thunderbird/31.6.0

Package: util-linux
Version: 2.25.2-6
Severity: normal

Dear Maintainer,
                        rc = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);
                        ret = 1;
                        if (rc == -1)
                                warn(_("select() to %s to wait for clock tick
failed"),
                                     rtc_dev_name);
                        else if (rc == 0 && debug)
                                printf(_("select() to %s to wait for clock
tick timed out"),
                                     rtc_dev_name);
                        else
                                ret = 0;

When 'select' times out and returns 0, synchronize_to_clock_tick_rtc returns
either 1 or 0, depnding on whether the -D option (debug) was used. This causes
hwclock -r to succeed and hwclock -r -D to return an error. In one case, it
just fails, in the other, the values are off by the timeout period (10
seconds, in this version).

pi@test-pi ~/dev/util-linux-2.25.2 $ sudo ./hwclock -r
Thu 16 Apr 2015 19:18:44 UTC  -10.016913 seconds
pi@test-pi ~/dev/util-linux-2.25.2 $ sudo ./hwclock -r -D
hwclock from util-linux 2.25.2
Using the /dev interface to the clock.
Last drift adjustment done at 1429205484 seconds after 1969
Last calibration done at 1429205484 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
select() to /dev/rtc0 to wait for clock tick timed out...synchronization
failed

----- End forwarded message -----
