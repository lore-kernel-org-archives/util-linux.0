Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933017AbdCaOtB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 10:49:01 -0400
Subject: [PATCH 5/6] hwclock: remove dead cmos code
To: Karel Zak <kzak@redhat.com>
References: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <3e9fc1bb-8387-dd5c-d107-b397bae09495@gmx.com>
Date: Fri, 31 Mar 2017 10:48:46 -0400
MIME-Version: 1.0
In-Reply-To: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* hwclock-cmos.c: remove unused 'century' code.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-cmos.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 5158369..6227b94 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -104,11 +104,6 @@ static int inb(int c __attribute__((__unused__)))
 static unsigned short clock_ctl_addr = 0x70;
 static unsigned short clock_data_addr = 0x71;
 
-static int century_byte = 0;		/* 0: don't access a century byte
-					 * 50 (0x32): usual PC value
-					 * 55 (0x37): PS/2
-					 */
-
 /*
  * Hmmh, this isn't very atomic. Maybe we should force an error instead?
  *
@@ -156,7 +151,6 @@ static unsigned long cmos_set_time(unsigned long arg)
 {
 	unsigned char save_control, save_freq_select, pmbit = 0;
 	struct tm tm = *(struct tm *)arg;
-	unsigned int century;
 
 /*
  * CMOS byte 10 (clock status register A) has 3 bitfields:
@@ -180,7 +174,6 @@ static unsigned long cmos_set_time(unsigned long arg)
 	save_freq_select = cmos_read(10);	/* stop and reset prescaler */
 	cmos_write(10, (save_freq_select | 0x70));
 
-	century = (tm.tm_year + TM_EPOCH) / 100;
 	tm.tm_year %= 100;
 	tm.tm_mon += 1;
 	tm.tm_wday += 1;
@@ -202,7 +195,6 @@ static unsigned long cmos_set_time(unsigned long arg)
 		BIN_TO_BCD(tm.tm_mday);
 		BIN_TO_BCD(tm.tm_mon);
 		BIN_TO_BCD(tm.tm_year);
-		BIN_TO_BCD(century);
 	}
 
 	cmos_write(0, tm.tm_sec);
@@ -212,8 +204,6 @@ static unsigned long cmos_set_time(unsigned long arg)
 	cmos_write(7, tm.tm_mday);
 	cmos_write(8, tm.tm_mon);
 	cmos_write(9, tm.tm_year);
-	if (century_byte)
-		cmos_write(century_byte, century);
 
 	/*
 	 * The kernel sources, linux/arch/i386/kernel/time.c, have the
@@ -316,10 +306,6 @@ static int read_hardware_clock_cmos(const struct hwclock_control *ctl
 			tm->tm_mon = hclock_read(8);
 			tm->tm_year = hclock_read(9);
 			status = hclock_read(11);
-#if 0
-			if (century_byte)
-				century = hclock_read(century_byte);
-#endif
 			/*
 			 * Unless the clock changed while we were reading,
 			 * consider this a good clock read .
@@ -343,9 +329,6 @@ static int read_hardware_clock_cmos(const struct hwclock_control *ctl
 		BCD_TO_BIN(tm->tm_mday);
 		BCD_TO_BIN(tm->tm_mon);
 		BCD_TO_BIN(tm->tm_year);
-#if 0
-		BCD_TO_BIN(century);
-#endif
 	}
 
 	/*
