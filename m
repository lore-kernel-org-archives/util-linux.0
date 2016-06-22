Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 6/6] lscpu: fix MMHZ column entry within man page
Date: Wed, 22 Jun 2016 09:26:01 +0200
In-Reply-To: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1466580361-23435-7-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

The indentation for the MMHZ column within the man page is wrong. Also
there doesn't exist any column with the name MMHZ. The correct names
would be MAXMHZ and MINMHZ.

Therefore rename MMHZ to MAXMHZ and add the missong MINMHZ entry.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 167567fa9be0..ffe18db63332 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -87,12 +87,15 @@ The workload is concentrated on few CPUs.
 For vertical polarization, the column also shows the degree of concentration,
 high, medium, or low.  This column contains data only if your hardware system
 and hypervisor support CPU polarization.
+.RE
 .TP
-.B MMHZ
-Maximum megahertz value for the cpu.  Useful when lscpu is used as hardware
+.B MAXMHZ
+Maximum megahertz value for the CPU.  Useful when lscpu is used as hardware
 inventory information gathering tool.  Notice that the megahertz value is
 dynamic, and driven by CPU governor depending on current resource need.
-.RE
+.TP
+.B MINMHZ
+Minimum megahertz value for the CPU.
 .SH OPTIONS
 .TP
 .BR \-a , " \-\-all"
-- 
2.6.6
