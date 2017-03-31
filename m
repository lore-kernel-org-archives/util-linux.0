Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933030AbdCaOqR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 10:46:17 -0400
Subject: [PATCH 3/6] hwclock: remove unused atomic arg in cmos
To: Karel Zak <kzak@redhat.com>
References: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <221f8650-b1ed-0b89-d536-cb1e7c495acc@gmx.com>
Date: Fri, 31 Mar 2017 10:46:08 -0400
MIME-Version: 1.0
In-Reply-To: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* sys-utils/hwclock-cmos.c: remove unused arg for atomic()

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-cmos.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 6c86a7c..a5eb9fd 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -114,10 +114,8 @@ static int century_byte = 0;		/* 0: don't access a century byte
  *
  * TODO: optimize the access to CMOS by mlockall(MCL_CURRENT) and SCHED_FIFO
  */
-static unsigned long
-atomic(const char *name __attribute__ ((__unused__)),
-       unsigned long (*op) (unsigned long),
-       unsigned long arg)
+static unsigned long atomic(unsigned long (*op) (unsigned long),
+			    unsigned long arg)
 {
 	return (*op) (arg);
 }
@@ -235,12 +233,12 @@ static unsigned long cmos_set_time(unsigned long arg)
 
 static int hclock_read(unsigned long reg)
 {
-	return atomic("clock read", cmos_read, reg);
+	return atomic(cmos_read, reg);
 }
 
 static void hclock_set_time(const struct tm *tm)
 {
-	atomic("set time", cmos_set_time, (unsigned long)(tm));
+	atomic(cmos_set_time, (unsigned long)(tm));
 }
 
 static inline int cmos_clock_busy(void)
