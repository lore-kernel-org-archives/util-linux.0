Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56593
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbbHUOWO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Aug 2015 10:22:14 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 2/3] hwclock: fix fgets unchecked return value warning on alpha
Date: Fri, 21 Aug 2015 16:13:28 +0200
Message-Id: <1440166409-32215-2-git-send-email-andreas@fatal.se>
In-Reply-To: <1440166409-32215-1-git-send-email-andreas@fatal.se>
References: <1440166409-32215-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Build warning:
sys-utils/hwclock-cmos.c: In function 'is_in_cpuinfo':
sys-utils/hwclock-cmos.c:162:4: warning: ignoring return value of 'fgets', declared with attribute warn_unused_result [-Wunused-result]
    fgets(field, 256, cpuinfo);

Full build log:
https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=alpha&ver=2.26.2-9&stamp=1440078034

Detected by/via:
https://qa.debian.org/bls/packages/u/util-linux.html

This change has never actually been (build-)tested on alpha, but
hopefully the change should fix the warning.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/hwclock-cmos.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 8d68808..de678ab 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -152,15 +152,15 @@ static int is_in_cpuinfo(char *fmt, char *str)
 
 	sprintf(format, "%s : %s", fmt, "%255s");
 
-	if ((cpuinfo = fopen("/proc/cpuinfo", "r")) != NULL) {
-		while (!feof(cpuinfo)) {
+	cpuinfo = fopen("/proc/cpuinfo", "r");
+	if (cpuinfo) {
+		do {
 			if (fscanf(cpuinfo, format, field) == 1) {
 				if (strncmp(field, str, strlen(str)) == 0)
 					found = 1;
 				break;
 			}
-			fgets(field, 256, cpuinfo);
-		}
+		} while (fgets(field, 256, cpuinfo));
 		fclose(cpuinfo);
 	}
 	return found;
-- 
2.1.4

