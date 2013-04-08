Return-Path: util-linux-owner@vger.kernel.org
Received: from [201.191.100.135] ([201.191.100.135]:58547 "EHLO
	bruno.wildbear.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S936387Ab3DHPDj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 11:03:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by bruno.wildbear.com (Postfix) with ESMTP id 1FF5E1BE02C9
	for <util-linux@vger.kernel.org>; Mon,  8 Apr 2013 09:03:10 -0600 (CST)
Date: Mon, 8 Apr 2013 09:03:09 -0600 (CST)
From: Joseph Parmelee <jparmele@wildbear.com>
To: util-linux@vger.kernel.org
Subject: Using NTP
Message-ID: <alpine.LNX.2.00.1304071939190.11901@bruno>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello again:

The environment variable TZUTC provides the complement to
/etc/localtime in making a linux system leap-second-aware.  This email
is a sort of mini-howto for configuring a recent linux kernel to fully
use NTP with a hwclock that understands TZUTC (is leap-second-aware).

I have assumed here that the RTC is kept in UTC, that leap-second-aware
zonefiles are found in /usr/share/zoneinfo/right, that you have set
/etc/localtime to point to the correct leap-second-aware zonefile for
your timezone, and that you are using a recent glibc.  Make appropriate
corrections if you use other conventions.

Even if no RTC driver is installed and the /dev/rtc device does not
exist, the linux kernel will initialize its system time to whatever is
in a standard RTC converted under the assumption that the RTC contains
POSIX UTC.  That is, like hwclock, the kernel knows how to directly
access standard RTC hardware.

You will need to do the following additional things in the following
order in system startup scripts:

1.  Reset the POSIX system time, which the kernel has set from the RTC
automatically at startup, to NTP time which is currently 25 seconds
greater (the number of leap seconds).  For example:

     TZUTC=:/usr/share/zoneinfo/right/UTC \
     hwclock --hctosys --utc --noadjfile

Do this as early as possible while the root filesystem is still mounted
readonly and before any attempt is made to use the system time (like
filesystem checks).  This example assumes that you have a PC with
standard RTC hardware.

It should also work if your system uses a non-standard RTC.  However,
then the appropriate RTC driver must be loaded first or built into the
kernel.  You must also specify /dev/rtc<N> on the hwclock command line
above with the additional option --rtc=/dev/rtc<N>.  Instead, you may
specify /dev/rtc<N> in the filesystem and link /dev/rtc to it, in which
case you do not need to add the --rtc option to the command line above. 
See the kernel documentation rtc.txt and hwclock.8 for more
information.

Note that you do not need to load the rtc-cmos module on a PC with
standard RTC hardware unless you want the additional features it
provides.  The kernel will provide legacy access to standard RTC
hardware without an additional driver.  If you do load rtc-cmos, then
you should treat your RTC as non-standard; that is you will also need
to specify /dev/rtc<N> (/dev/rtc0 by default) or link /dev/rtc as
above.


2.  Start ntpd.  For example:

     ntpd -g -I eth1

Do this much later after the interface that NTP will use and the name
server have been brought up.  Prior to this step, the system clock is
running close to NTP time from the RTC, though not yet locked on to an
NTP client.  Because it is close, operations performed during this period
have very close timestamps and ntpd can quickly bring the system clock
into sync.


3.  Set the RTC to the NTP system time.  Even if the system time has
not yet been changed by ntpd, and this operation has little or no
effect on the RTC, you are telling the kernel not to touch the RTC in
the future.  The RTC will be maintained in sync from user space by a
cron job (see 4 below).  For example:

     hwclock --systohc --utc --noadjfile

Do this right after step 2.


4.  Start a cron job which does the same thing every hour.  For
example:

     hwclock --systohc --utc --noadjfile


You may want to do other hwclock operations on startup and shutdown
that maintain and use /etc/adjtime.  This is useful if your system is
powered down for long periods where RTC drift is substantial.  But if
your system is running on a UPS and is only down for short periods,
this will not be necessary.

Do not hesitate to email me with questions, suggestions, gripes, money,
etc.


Hope this helps.  Regards,

Joseph Parmelee
jparmele at wildbear dot com
