Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/6] hwclock: remove unused cmos ctl structs
To: Karel Zak <kzak@redhat.com>
References: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <8b3cac40-aa23-21b9-442f-2723f8f54483@gmx.com>
Date: Fri, 31 Mar 2017 10:44:52 -0400
MIME-Version: 1.0
In-Reply-To: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


The hwclock-cmos.c ctl structs were only used for
the since removed alpha code.

* sys-utils/hwclock-cmos.c: remove unused ctl structs

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-cmos.c | 83 +++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 7a9d595..6c86a7c 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -116,11 +116,10 @@ static int century_byte = 0;		/* 0: don't access a century byte
  */
 static unsigned long
 atomic(const char *name __attribute__ ((__unused__)),
-       unsigned long (*op) (const struct hwclock_control *ctl, unsigned long),
-       const struct hwclock_control *ctl,
+       unsigned long (*op) (unsigned long),
        unsigned long arg)
 {
-	return (*op) (ctl, arg);
+	return (*op) (arg);
 }
 
 /*
@@ -142,23 +141,20 @@ atomic(const char *name __attribute__ ((__unused__)),
  * kernel and not disable. Called only with 0 <= reg < 128
  */
 
-static inline unsigned long cmos_read(const struct hwclock_control *ctl,
-				      unsigned long reg)
+static inline unsigned long cmos_read(unsigned long reg)
 {
 	outb(reg, clock_ctl_addr);
 	return inb(clock_data_addr);
 }
 
-static inline unsigned long cmos_write(const struct hwclock_control *ctl,
-				       unsigned long reg, unsigned long val)
+static inline unsigned long cmos_write(unsigned long reg, unsigned long val)
 {
 	outb(reg, clock_ctl_addr);
 	outb(val, clock_data_addr);
 	return 0;
 }
 
-static unsigned long cmos_set_time(const struct hwclock_control *ctl,
-				   unsigned long arg)
+static unsigned long cmos_set_time(unsigned long arg)
 {
 	unsigned char save_control, save_freq_select, pmbit = 0;
 	struct tm tm = *(struct tm *)arg;
@@ -181,10 +177,10 @@ static unsigned long cmos_set_time(const struct hwclock_control *ctl,
  *         1111 500 milliseconds (maximum, 2 Hz)
  *         0110 976.562 microseconds (default 1024 Hz)
  */
-	save_control = cmos_read(ctl, 11);	/* tell the clock it's being set */
-	cmos_write(ctl, 11, (save_control | 0x80));
-	save_freq_select = cmos_read(ctl, 10);	/* stop and reset prescaler */
-	cmos_write(ctl, 10, (save_freq_select | 0x70));
+	save_control = cmos_read(11);	/* tell the clock it's being set */
+	cmos_write(11, (save_control | 0x80));
+	save_freq_select = cmos_read(10);	/* stop and reset prescaler */
+	cmos_write(10, (save_freq_select | 0x70));
 
 	century = (tm.tm_year + TM_EPOCH) / 100;
 	tm.tm_year %= 100;
@@ -211,15 +207,15 @@ static unsigned long cmos_set_time(const struct hwclock_control *ctl,
 		BIN_TO_BCD(century);
 	}
 
-	cmos_write(ctl, 0, tm.tm_sec);
-	cmos_write(ctl, 2, tm.tm_min);
-	cmos_write(ctl, 4, tm.tm_hour | pmbit);
-	cmos_write(ctl, 6, tm.tm_wday);
-	cmos_write(ctl, 7, tm.tm_mday);
-	cmos_write(ctl, 8, tm.tm_mon);
-	cmos_write(ctl, 9, tm.tm_year);
+	cmos_write(0, tm.tm_sec);
+	cmos_write(2, tm.tm_min);
+	cmos_write(4, tm.tm_hour | pmbit);
+	cmos_write(6, tm.tm_wday);
+	cmos_write(7, tm.tm_mday);
+	cmos_write(8, tm.tm_mon);
+	cmos_write(9, tm.tm_year);
 	if (century_byte)
-		cmos_write(ctl, century_byte, century);
+		cmos_write(century_byte, century);
 
 	/*
 	 * The kernel sources, linux/arch/i386/kernel/time.c, have the
@@ -232,26 +228,26 @@ static unsigned long cmos_set_time(const struct hwclock_control *ctl,
 	 * the Dallas Semiconductor data sheets, but who believes data
 	 * sheets anyway ... -- Markus Kuhn
 	 */
-	cmos_write(ctl, 11, save_control);
-	cmos_write(ctl, 10, save_freq_select);
+	cmos_write(11, save_control);
+	cmos_write(10, save_freq_select);
 	return 0;
 }
 
-static int hclock_read(const struct hwclock_control *ctl, unsigned long reg)
+static int hclock_read(unsigned long reg)
 {
-	return atomic("clock read", cmos_read, ctl, reg);
+	return atomic("clock read", cmos_read, reg);
 }
 
-static void hclock_set_time(const struct hwclock_control *ctl, const struct tm *tm)
+static void hclock_set_time(const struct tm *tm)
 {
-	atomic("set time", cmos_set_time, ctl, (unsigned long)(tm));
+	atomic("set time", cmos_set_time, (unsigned long)(tm));
 }
 
-static inline int cmos_clock_busy(const struct hwclock_control *ctl)
+static inline int cmos_clock_busy(void)
 {
 	return
 	    /* poll bit 7 (UIP) of Control Register A */
-	    (hclock_read(ctl, 10) & 0x80);
+	    (hclock_read(10) & 0x80);
 }
 
 static int synchronize_to_clock_tick_cmos(const struct hwclock_control *ctl
@@ -264,12 +260,12 @@ static int synchronize_to_clock_tick_cmos(const struct hwclock_control *ctl
 	 * weird happens, we have a limit on this loop to reduce the impact
 	 * of this failure.
 	 */
-	for (i = 0; !cmos_clock_busy(ctl); i++)
+	for (i = 0; !cmos_clock_busy(); i++)
 		if (i >= 10000000)
 			return 1;
 
 	/* Wait for fall.  Should be within 2.228 ms. */
-	for (i = 0; cmos_clock_busy(ctl); i++)
+	for (i = 0; cmos_clock_busy(); i++)
 		if (i >= 1000000)
 			return 1;
 	return 0;
@@ -312,25 +308,25 @@ static int read_hardware_clock_cmos(const struct hwclock_control *ctl
 		 * at first, the clock has changed while we were running. We
 		 * check for that too, and if it happens, we start over.
 		 */
-		if (!cmos_clock_busy(ctl)) {
+		if (!cmos_clock_busy()) {
 			/* No clock update in progress, go ahead and read */
-			tm->tm_sec = hclock_read(ctl, 0);
-			tm->tm_min = hclock_read(ctl, 2);
-			tm->tm_hour = hclock_read(ctl, 4);
-			tm->tm_wday = hclock_read(ctl, 6);
-			tm->tm_mday = hclock_read(ctl, 7);
-			tm->tm_mon = hclock_read(ctl, 8);
-			tm->tm_year = hclock_read(ctl, 9);
-			status = hclock_read(ctl, 11);
+			tm->tm_sec = hclock_read(0);
+			tm->tm_min = hclock_read(2);
+			tm->tm_hour = hclock_read(4);
+			tm->tm_wday = hclock_read(6);
+			tm->tm_mday = hclock_read(7);
+			tm->tm_mon = hclock_read(8);
+			tm->tm_year = hclock_read(9);
+			status = hclock_read(11);
 #if 0
 			if (century_byte)
-				century = hclock_read(ctl, century_byte);
+				century = hclock_read(century_byte);
 #endif
 			/*
 			 * Unless the clock changed while we were reading,
 			 * consider this a good clock read .
 			 */
-			if (tm->tm_sec == hclock_read(ctl, 0))
+			if (tm->tm_sec == hclock_read(0))
 				got_time = TRUE;
 		}
 		/*
@@ -381,8 +377,7 @@ static int set_hardware_clock_cmos(const struct hwclock_control *ctl
 				   __attribute__((__unused__)),
 				   const struct tm *new_broken_time)
 {
-
-	hclock_set_time(ctl, new_broken_time);
+	hclock_set_time(new_broken_time);
 	return 0;
 }
 
