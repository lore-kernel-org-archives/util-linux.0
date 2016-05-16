Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.bitwise.fi ([109.204.228.163]:52648 "EHLO mail.bitwise.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbcEPNnv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 May 2016 09:43:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.bitwise.fi (Postfix) with ESMTP id 6363A6087A
	for <util-linux@vger.kernel.org>; Mon, 16 May 2016 16:43:48 +0300 (EEST)
Received: from mail.bitwise.fi ([127.0.0.1])
	by localhost (mail.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJObjWoLm2tg for <util-linux@vger.kernel.org>;
	Mon, 16 May 2016 16:43:45 +0300 (EEST)
Received: from [192.168.5.225] (fw1.dmz.bitwise.fi [192.168.69.1])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: anssiha)
	by mail.bitwise.fi (Postfix) with ESMTPSA id DEEEE60212
	for <util-linux@vger.kernel.org>; Mon, 16 May 2016 16:43:45 +0300 (EEST)
From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: hwclock issue: RTC_SET_DELAY_SECS = 0.5s assumption not always true
To: util-linux@vger.kernel.org
Message-ID: <c842577c-850e-16bb-f434-10260cffe720@bitwise.fi>
Date: Mon, 16 May 2016 16:43:44 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

I noticed that "hwclock --systohc" does not set the RTC time exactly
with Freescale MC34708 RTC (driver in mainline).

After running the command, the RTC is running exactly 0.5 sec late
compared to the system clock.

Looking at the code (set_hardware_clock_exact()), it seems hwclock
assumes that when setting the RTC to e.g. "1:23:45", it is actually set
to "1:23:45.5", IOW the code assumes that the next second tick occurs
0.5 sec after setting the time. The code cites Motorola MC146818
datasheet for this behavior.

However, this is not the behavior of Freescale MC34708 RTC. Instead the
next second tick occurs 1.0 sec after setting the time.
If I change util-linux/sys-utils/hwclock.c like this:
-       const double RTC_SET_DELAY_SECS = 0.5;      /* 500 ms */
+       const double RTC_SET_DELAY_SECS = 0.0;      /* 0 ms */
Then it works with MC34708, but this obviously breaks it with other RTCs.

I guess most common desktop HW has the MC146818 behavior, but I have no
idea how widespread this alternate behavior MC34708 has is.

This 0.5sec offset was originally added to the code in commit
99c392d8ba1 ("hwclock: fix --systohc sets clock 0.5 seconds slow") in
2.13, from https://bugzilla.redhat.com/show_bug.cgi?id=150493 , so
before that commit the MC34708 (which didn't exist back then) behavior
was assumed.

Below is a short test program for comparing system time with RTC:
---
#include <time.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/rtc.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/time.h>

void timeloop(void) {
        int fd;
        struct rtc_time rtct;
        struct timeval tv;

        while (1) {
                gettimeofday(&tv, NULL);
                fd = open("/dev/rtc0", O_RDONLY);
                ioctl(fd, RTC_RD_TIME, &rtct);
                close(fd); /* close to allow hwclock to work */

                printf("\rtime: %02d.%01d, rtc: %02d", tv.tv_sec % 60,
tv.tv_usec/100000, rtct.tm_sec);
                fflush(stdout);
                usleep(100000);
        }
}

int main() {
        timeloop();
        return 0;
}


-- 
Anssi Hannula

