Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbbDTMVg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Apr 2015 08:21:36 -0400
Date: Mon, 20 Apr 2015 14:21:32 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Andreas Henriksson <andreas@fatal.se>, util-linux@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>
Subject: Re: hwclock's synchronize_to_clock_tick_rtc returns inconsistent
 values
Message-ID: <20150420122132.GB27969@ws.net.home>
References: <20150416203604.GA6523@fatal.se>
 <55344548.6050102@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55344548.6050102@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 19, 2015 at 08:16:08PM -0400, J William Piggott wrote:
> >                         rc = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);
> >                         ret = 1;
> >                         if (rc == -1)
> >                                 warn(_("select() to %s to wait for clock tick
> > failed"),
> >                                      rtc_dev_name);
> >                         else if (rc == 0 && debug)
> >                                 printf(_("select() to %s to wait for clock
> > tick timed out"),
> >                                      rtc_dev_name);
> >                         else
> >                                 ret = 0;
> >
> 
> Karel,
> 
> The select time out still needs to return 1, so the debug test should
> have been a separate statement.

Yes, the debug (-D) should bot affect how this code works, but it
seems that hwclock.c:manipulate_clock() assumes return 2 after 
time out and we already use "2" in busy wait version of the
synchronization. 

> I don't have time to patch and test this right now, but I can do it
> later if you want?

See the patch below (note that patch also remove never used #ifdef
dead code).


diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 78f42aa..3173591 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -280,18 +280,6 @@ static int synchronize_to_clock_tick_rtc(void)
 				       rtc_dev_name);
 			ret = busywait_for_rtc_clock_tick(rtc_fd);
 		} else if (rc == 0) {
-#ifdef Wait_until_update_interrupt
-			unsigned long dummy;
-
-			/* this blocks until the next update interrupt */
-			rc = read(rtc_fd, &dummy, sizeof(dummy));
-			ret = 1;
-			if (rc == -1)
-				warn(_("read() to %s to wait for clock tick failed"),
-				     rtc_dev_name);
-			else
-				ret = 0;
-#else
 			/*
 			 * Just reading rtc_fd fails on broken hardware: no
 			 * update interrupt comes and a bootscript with a
@@ -310,15 +298,22 @@ static int synchronize_to_clock_tick_rtc(void)
 			tv.tv_usec = 0;
 			rc = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);
 			ret = 1;
-			if (rc == -1)
+
+			switch (rc) {
+			case -1: /* error */
 				warn(_("select() to %s to wait for clock tick failed"),
 				     rtc_dev_name);
-			else if (rc == 0 && debug)
-				printf(_("select() to %s to wait for clock tick timed out"),
-				     rtc_dev_name);
-			else
+				break;
+			case 0: /* timeout */
+				if (debug)
+					printf(_("select() to %s to wait for clock tick timed out"),
+					     rtc_dev_name);
+				ret = 2;
+				break;
+			default: /* success */
 				ret = 0;
-#endif
+				break;
+			}
 
 			/* Turn off update interrupts */
 			rc = ioctl(rtc_fd, RTC_UIE_OFF, 0);
